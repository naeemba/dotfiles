rm -rf "$HOME/.config/nvim"
ln -sf "$PWD/nvim" "$HOME/.config/nvim"

# Install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf "$PWD/git/.gitconfig" "$HOME/.gitconfig"

git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
ln -sf "$PWD/zsh/.zshrc" "$HOME/.zshrc"

ln -sf "$PWD/tig/.tigrc" "$HOME/.tigrc"

ln -sf "$PWD/i3/config" "$HOME/.config/i3/config"
ln -sf "$PWD/i3/polybar.sh" "$HOME/.config/i3/polybar.sh"
ln -sf "$PWD/i3/monitors.sh" "$HOME/.config/i3/monitors.sh"
