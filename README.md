# dotfiles

This project contains most of the setup files I have for my Arch Linux.

## Issues

### Graphic Card and Drivers

I have a Thinkpad X1 extreme, and I had some major problems configuring the external monitor cause its hdmi port wired to the nvidia gpu directly.

Finally I solved the issue using these links, maybe useful for somebody else too.

I stopped thinking about hybrid graphic or some fancy thing like that, if it works I really will be happy :|

I used optimus-manager with bbswitch and followed this guide:

https://forum.manjaro.org/t/guide-install-and-configure-optimus-manager-for-hybrid-gpu-setups-intel-nvidia/92196

About my laptop:

https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Extreme

and the newer version which has some helpful instructions too:

https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Extreme_(Gen_2)

### Oh My Zsh with vi-mode

I had an issue with oh-my-zsh which my `home` and `end` keys were not working properly. This issue helped fixing the problem:

https://github.com/ohmyzsh/ohmyzsh/issues/7330#issuecomment-475844784

Also numpad keys are not working there, using this link helped me:

https://github.com/ohmyzsh/ohmyzsh/issues/3061#issuecomment-136554709

