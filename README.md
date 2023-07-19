# dotfiles

This project contains most of the setup files I have for my Arch Linux.

## Graphic Card and Drivers (Lenovo X1 Extreme)

I have a Thinkpad X1 extreme, and I had some major problems configuring the external monitor cause its hdmi port wired to the nvidia gpu directly.

Finally I solved the issue using these links, maybe useful for somebody else too.

I stopped thinking about hybrid graphic or some fancy thing like that, if it works I really will be happy :|

I used optimus-manager with bbswitch and followed this guide:

https://forum.manjaro.org/t/guide-install-and-configure-optimus-manager-for-hybrid-gpu-setups-intel-nvidia/92196

About my laptop:

https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Extreme

and the newer version which has some helpful instructions too:

https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Extreme_(Gen_2)

## Keychron Keyboard (fix fn keys)

Create the `/etc/modprob.d/hid_apple.conf` with this content:
```
options hid_apple fnmode=0
```
and then add it to the list of files:
edit `mkinitcpio.conf` and add it to the `FILES`, then regenerate the configuration file:
```
mkinitcpio -P
```
Links:
https://wiki.archlinux.org/title/mkinitcpio#BINARIES_and_FILES
https://wiki.archlinux.org/title/Apple_Keyboard

### Oh My Zsh with vi-mode

I had an issue with oh-my-zsh which my `home` and `end` keys were not working properly. This issue helped fixing the problem:

https://github.com/ohmyzsh/ohmyzsh/issues/7330#issuecomment-475844784

Also numpad keys are not working there, using this link helped me:

https://github.com/ohmyzsh/ohmyzsh/issues/3061#issuecomment-136554709

### Fan issue with manjaro and Predator Helios 300

It is not the best, but it will work:

https://github.com/nbfc-linux/nbfc-linux

and we can go with this config:

https://github.com/nbfc-linux/nbfc-linux/blob/main/share/nbfc/configs/Acer%20Predator%20PH315-53.json

```
sudo systemctl enable nbfc_service
```

### Suggested softwares:

Peek: (simple screen recorder)
https://github.com/phw/peek

Flameshot (screenshot)
https://github.com/flameshot-org/flameshot

## Copy Paste on Neovim issue

First check health in `neovim`
```
:checkhealth
```
If there is no clipboard tool, install `xclip` for example,
https://wiki.archlinux.org/title/clipboard#Tools

## Inspired by

[VishnuSanal](https://github.com/VishnuSanal/dotfiles/tree/main)
