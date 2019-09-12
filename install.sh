rm "$HOME/.config/nvim/init.vim"
ln "$PWD/nvim" "$HOME/.config/nvim"

# Install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf "$PWD/git/config" "$HOME/.gitconfig"
