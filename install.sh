#!/bin/bash
set -euo pipefail

if [[ "$(uname -s)" != Darwin ]]; then
  echo 'This installer targets macOS.' >&2
  exit 1
fi

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
data_home="${XDG_DATA_HOME:-$HOME/.local/share}"

find_brew() {
  local path
  for path in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x "$path" ]]; then
      printf '%s\n' "$path"
      return
    fi
  done
  type -P brew
}

if ! brew_bin="$(find_brew)"; then
  echo 'Installing Homebrew. Its installer may ask for your password.'
  brew_installer="$(mktemp)"
  trap 'rm -f "$brew_installer"' EXIT
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o "$brew_installer"
  /bin/bash "$brew_installer"
  brew_bin="$(find_brew)"
fi

eval "$("$brew_bin" shellenv bash)"
"$brew_bin" install neovim tmux fzf ripgrep bat jq node
"$brew_bin" install --cask font-meslo-lg-nerd-font

nvim="$("$brew_bin" --prefix)/bin/nvim"
if ! "$nvim" --clean --headless '+if !has("nvim-0.11.3") | cquit | endif' +qa; then
  echo 'Neovim 0.11.3 or newer is required. Run brew upgrade neovim and try again.' >&2
  exit 1
fi

link_config() {
  local source="$1" destination="$2" backup
  mkdir -p "$(dirname "$destination")"
  if [[ -L "$destination" && "$(readlink "$destination")" == "$source" ]]; then
    return
  fi
  if [[ -e "$destination" || -L "$destination" ]]; then
    backup="$(mktemp -d "$destination.backup.XXXXXXXX")"
    mv "$destination" "$backup/"
    echo "Backed up $destination to $backup/"
  fi
  ln -s "$source" "$destination"
}

link_config "$repo/src/config/alacritty" "$config_home/alacritty"
if ! defaults read org.alacritty AppleFontSmoothing >/dev/null 2>&1; then
  defaults write org.alacritty AppleFontSmoothing -int 2
fi
link_config "$repo/src/config/nvim" "$config_home/nvim"
link_config "$repo/src/tmux.conf" "$HOME/.tmux.conf"

plug="$data_home/nvim/site/autoload/plug.vim"
if [[ ! -s "$plug" ]]; then
  curl -fsSL --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/0.14.0/plug.vim -o "$plug"
fi

unset NVIM_APPNAME
"$nvim" --headless --cmd 'let g:dotfiles_installing = 1' '+PlugInstall --sync' \
  '+lua for name, plug in pairs(vim.g.plugs) do if vim.fn.isdirectory(plug.dir) == 0 then print("Failed to install " .. name); vim.cmd("cquit") end end' +qa
"$nvim" --headless '+if v:errmsg != "" | cquit | endif' +qa

if [[ "${SHELL:-/bin/zsh}" == */zsh ]]; then
  zprofile="${ZDOTDIR:-$HOME}/.zprofile"
  mkdir -p "$(dirname "$zprofile")"
  if ! grep -Fqs -- "$brew_bin shellenv" "$zprofile"; then
    printf '\n# Homebrew\neval "$(%q shellenv zsh)"\n' "$brew_bin" >> "$zprofile"
  fi
else
  printf 'Set up Homebrew in your login shell with %s shellenv.\n' "$brew_bin"
fi

echo 'Done. Relaunch Alacritty, then run tmux or nvim.'
