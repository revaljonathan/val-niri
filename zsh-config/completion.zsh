skip_global_compinit=1                          
autoload -Uz compinit 
if [[ -n /tmp/zcompdump-$USER(#qN.mh+24) ]]; then
  compinit -d /tmp/zcompdump-$USER
else
  compinit -C -d /tmp/zcompdump-$USER
fi
