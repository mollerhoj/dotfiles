Repository containing my dotfiles

# Install notes:

# zsh
sudo apt-get install zsh

# ack
sudo apt install ack-grep

# ctags
sudo apt install exuberant-ctags

# neovim (Ubuntu)
sudo apt-get install software-properties-common
sudo apt-get install python-software-properties
sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

# plugged (neovim package manager)
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install plugins
nvim +PlugInstall +qall
