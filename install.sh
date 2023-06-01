rm -rf "$HOME/.config/nvim"
ln -sf "$PWD/nvim" "$HOME/.config/nvim"

# Install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf "$PWD/git/.gitconfig" "$HOME/.gitconfig"
ln -sf "$PWD/git/.gitignore" "$HOME/.gitignore"
ln -sf "$PWD/git/.work-gitconfig" "$HOME/.work/.gitconfig"

git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
ln -sf "$PWD/zsh/.zshrc" "$HOME/.zshrc"

ln -sf "$PWD/tig/.tigrc" "$HOME/.tigrc"

#mkdir -p "$HOME/.config/i3"
ln -sf "$PWD/i3/config" "$HOME/.config/i3/config"
ln -sf "$PWD/i3/polybar.sh" "$HOME/.config/i3/polybar.sh"
ln -sf "$PWD/i3/monitors.sh" "$HOME/.config/i3/monitors.sh"
ln -sf "$PWD/polybar/config" "$HOME/.config/polybar/config"
ln -sf "$PWD/polybar/spotify.py" "$HOME/.config/polybar/spotify.py"
ln -sf "$PWD/picom/picom.conf" "$HOME/.config/picom/picom.conf"
ln -sf "$PWD/chrome/chrome-flags.conf" "$HOME/.config/chrome-flags.conf"
ln -sf "$PWD/chrome/chromium-flags.conf" "$HOME/.config/chromium-flags.conf"
mkdir -p "$HOME/.config/rofi"
ln -sf "$PWD/rofi/rofi" "$HOME/.config/rofi/rofi"
mkdir -p "$HOME/.config/alacritty"
ln -sf "$PWD/alacritty/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml"
mkdir -p "$HOME/.ssh"
ln -sf "$PWD/ssh/config" "$HOME/.ssh/config"
#ln -sf "$PWD/redshift/redshift.conf" "$HOME/.config/redshift/redshift.conf"
#ln -sf "$PWD/dunst/dunstrc" "$HOME/.config/dunst/dunstrc"
mkdir -p "$HOME/.gradle"
ln -sf "$PWD/gradle/gradle.properties" "$HOME/.gradle/gradle.properties"

sh install_apps.sh

# install rofi themes
mkdir -p "$HOME/.rofi/themes"
git clone --depth=1 https://github.com/adi1090x/rofi.git "$HOME/.rofi/themes" 
cd "$HOME/.rofi/themes"
sh setup.sh
