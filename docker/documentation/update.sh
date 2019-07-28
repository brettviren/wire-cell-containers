#!/bin/bash


if [ -d ~/.ssh/ ] ; then
    echo "Using existing ~/.ssh/"
else
    [ -z "${SSH_KEY}" ] && { echo "Need to set SSH_KEY"; exit 1; }
    mkdir -p ~/.ssh
    echo -e "${SSH_KEY}" > ~/.ssh/id_rsa
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_rsa
    echo -e "Host *\n    StrictHostKeyChecking no\n    UserKnownHostsFile=/dev/null\n" > ~/.ssh/config
fi

git config --global user.name "${COMMIT_USER}"
git config --global user.email "${COMMIT_EMAIL}"

top="$(pwd)"

srvurl="git@github.com:WireCell/wirecell.github.io.git"
srvdir="$(basename $srvurl .git)"
srcurl="https://github.com/WireCell/wire-cell-docs.git"
srcdir="$(basename $srcurl .git)"

for url in "$srvurl" "$srcurl" ; do
    dname=$(basename "$url" .git)
    if [ -d "$dname" ] ; then
        cd "$dname"
        git pull
    else
        cd "$top/"
        git clone "$url"
    fi
done

cd "$top/wire-cell-docs/manuals/"
python3 waf configure --prefix="$top/wirecell.github.io"
python3 waf -j1 build install

cd "$top/wire-cell-docs/news/"
nikola build

cd "$top/wirecell.github.io"
if [ -z "$(git status -s | awk {'print $2'})" ] ; then
    echo "No changes"
    exit
fi
   
git add . || exit 1
git commit -am "Update from CI" 
echo "Pushing"
git push origin master




