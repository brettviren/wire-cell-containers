#!/bin/bash

top="$(pwd)"

srvurl="https://github.com/WireCell/wirecell.github.io.git"
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

git status


