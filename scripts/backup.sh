#!/usr/bin/sh

cp -r ~/.config/matugen/ ~/.config/dunst/ ~/.config/waybar ~/.config/niri ~/.config/rofi/ ~/.config/swaylock/ ~/.config/kitty ~/.config/zathura/ ~/.config/btop ~/.config/fastfetch/ ~/.config/zsh/ ~/.config/yazi ~/code/val-niri/config/
cp -r ~/.config/nvim ~/code/val-niri/config/

cp  ~/.config/clipse/{theme.json,config.json} ~/code/val-niri/config/clipse/

cp ~/.zshrc ~/.p10k.zsh ~/code/val-niri/

cp -r ~/.icons/icon_scripts/ ~/code/val-niri/

cp ~/.local/bin/{tl.sh,filerofi.sh,powermenu.sh,sleep.sh,dynalock.sh,dunstvol.sh,dunstback.sh,wifi.sh,steam.sh,browse.sh,barsel.sh,bat.sh,mem.sh,weather.sh,ss.sh,backup.sh,playerctl.sh,media.sh,ppd.sh,control.sh,dunst.sh,record.sh,dnd-toggle.sh,rng.sh,wall.sh,cal.sh,yazi-note.sh} ~/code/val-niri/scripts/

cd ~/code/val-niri/

git add . && git commit -m "$1" && git push
