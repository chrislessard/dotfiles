#! /bin/zsh

cd "${0%/*}"

# Link dotfiles
#
echo
echo Linking dotfiles
echo ----------------
echo
for dotfile in src/**/*; do
    # Iterate through each file/dir in src, and link it in the local env
    destination=~/.${dotfile:4} # Remove src/ and prepend ~/.

    # If entry is a directory, create it as such
    if [ -d "$dotfile" ] && [ ! -d "$destination" ]; then
        mkdir $destination
    fi

    # If entry is a file, create it as such
    if [ -f "$dotfile" ]; then
        echo "--- $dotfile -> $destination"
        ln -sf ${dotfile:P} "$destination"
    fi
done

echo "Setting up vimrc for Neovim"
mkdir -p ~/.config/nvim
ln -s ~/.init.lua ~/.config/nvim/init.lua

# Install dependencies
echo
echo Install dependencies
echo -----------------------
echo

sudo apt-get update

sudo apt-get install -y neovim
echo "--- Neovim installed"

# Neovim
if command -v apt-get &> /dev/null; then
  # Uninstall any old version of neovim which was installed from the wrong
  # repository
  if command -v nvim &> /dev/null; then
    if [[ $(nvim -v | grep -oP "(?<=NVIM v)\d+\.\d+") -lt 0.7 ]]; then
      sudo apt-get remove -y neovim neovim-runtime
    fi
  fi
fi
sudo apt-get install -y neovim

# Install Vim plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install AG
sudo apt-get install silversearcher-ag

# Install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --update-rc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
sudo rm -rf /usr/local/bin/fzf
sudo rm -rf /usr/bin/fzf

# Trigger installation of nvim plugins
nvim --headless +PlugInstall +qall

gem install ruby-lsp
