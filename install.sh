rm -rf "$HOME/.config/nvim"
ln -sf "$PWD/nvim" "$HOME/.config/nvim"

# Install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf "$PWD/git/.gitconfig" "$HOME/.gitconfig"

ln -sf "$PWD/zsh/.zshrc" "$HOME/.zshrc"

ln -sf "$PWD/tig/.tigrc" "$HOME/.tigrc"
