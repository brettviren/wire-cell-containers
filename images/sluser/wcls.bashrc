export ps_sing="${SINGULARITY_NAME%.*}"
export PS1="[$ps_sing] \u@\h:\w$ "
export PATH=/usr/bin:/usr/local/bin
export TERM=xterm
export PAGER=less
export DIRENV_CONFIG=/etc/direnv
eval "$(direnv hook bash)"
