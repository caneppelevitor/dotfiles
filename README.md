# dotfiles

Personal configs for macOS and Windows.

## macOS Setup

```bash
xcode-select --install
git clone https://github.com/caneppelevitor/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles/macos
./install.sh
```

Open a new terminal, then install tmux plugins: `tmux` → `Ctrl+A` then `I`.

### What gets installed

| Category | Tools |
|----------|-------|
| Terminal | ghostty, tmux, fastfetch |
| Editor | neovim (LazyVim) |
| Dev | go, bat, gh, glab, tree, fzf |
| Shell | oh-my-zsh, autosuggestions, syntax-highlighting |
| WM | aerospace |
| Apps | obsidian-cli |

### What gets symlinked

| Config | Target |
|--------|--------|
| zsh | `~/.zshrc`, `~/.aliases` |
| neovim | `~/.config/nvim` |
| aerospace | `~/.config/aerospace/aerospace.toml` |
| ghostty | `~/.config/ghostty/config` |
| fastfetch | `~/.config/fastfetch` |
| lazygit | `~/Library/Application Support/lazygit/config.yml` |
| tmux | `~/.tmux.conf` |
| git | `~/.gitconfig` |
| ssh | `~/.ssh/config` |
| obsidian-cli | `~/.obsidian-cli/config.yaml` |
