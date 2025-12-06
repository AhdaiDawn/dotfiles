pacman -Qqe | grep -v "$(pacman -Qqm)" > pacman.txt
# pacman -Qe > pacman-all.txt
pacman -Qqm > aur_local.txt
