# Dotfiles

## Install on macOS

With Alacritty already installed, open it and run:

```sh
git clone https://github.com/chrislessard/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

If macOS prompts for the Command Line Tools when you run `git`, install them and retry.
The installer sets up Homebrew if needed, installs tmux, Neovim, the Meslo Nerd Font,
and the editor's command-line tools and plugins. It links the Alacritty, tmux, and
Neovim configs from this checkout. Existing configs are moved into nearby
`*.backup.*` directories; rerunning the installer leaves correct links in place.
It sets font smoothing for Alacritty if you haven't set it already and adds
Homebrew to zsh's login environment without replacing your shell or Git config.
Keep the checkout in place so the links still work.

Relaunch Alacritty, then run `tmux` or `nvim`. If you already have a tmux server
running, reload with Ctrl-s then r. In Neovim, `ogb` opens a GitHub link and `gb`
copies it, for either the current line or a visual selection.

For language support, install `ruby-lsp` or `rust-analyzer` with your project's
toolchain. Sorbet is enabled for Ruby projects with `sorbet/config` and
runs through the project's bundle. Copilot is optional; run `:Copilot setup` to
sign in if you use it.
