#!/usr/bin/sh

cp -r ~/.config/matugen/ ~/.config/dunst/ ~/.config/waybar ~/.config/niri ~/.config/rofi/ ~/.config/swaylock/ ~/.config/kitty ~/.config/zathura/ ~/.config/btop ~/code/val-niri/config/
cp -r ~/.config/nvim ~/code/val-niri/config/

cp  ~/.config/clipse/{theme.json,config.json} ~/code/val-niri/config/clipse/

cp ~/.zshrc ~/.p10k.zsh ~/code/val-niri/

cp ~/.local/bin/{wp.sh,tl.sh,filerofi.sh,powermenu.sh,sleep.sh,dynalock.sh,gamma.sh,dunstvol.sh,dunstback.sh,wifi.sh,steam.sh,browse.sh,barsel.sh,bat.sh,mem.sh,weather.sh,ss.sh,backup.sh,wttrbar,player.sh} ~/code/val-niri/local-bin/

cd ~/code/val-niri/

git add . && git commit -m "$1" && git push
