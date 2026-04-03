#!/usr/bin/env bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# -----------------------------------------------------------
# 1. Homebrew
# -----------------------------------------------------------
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add brew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

echo "Installing packages from Brewfile..."
brew bundle --file="$DOTFILES/Brewfile"

# -----------------------------------------------------------
# 2. oh-my-zsh
# -----------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# -----------------------------------------------------------
# 3. tmux plugin manager
# -----------------------------------------------------------
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# -----------------------------------------------------------
# 4. obsidian-cli
# -----------------------------------------------------------
if ! command -v obsidian &>/dev/null; then
    echo "Installing obsidian-cli..."
    git clone https://github.com/caneppelevitor/obsidian-cli.git /tmp/obsidian-cli
    cd /tmp/obsidian-cli
    go install .
    cd "$DOTFILES"
    rm -rf /tmp/obsidian-cli
fi

# -----------------------------------------------------------
# 5. Symlinks
# -----------------------------------------------------------
link() {
    local src="$1"
    local dst="$2"

    # Create parent directory if needed
    mkdir -p "$(dirname "$dst")"

    # Back up existing file if it's not already a symlink to our source
    if [ -e "$dst" ] && [ ! -L "$dst" ]; then
        echo "Backing up existing $dst -> ${dst}.backup"
        mv "$dst" "${dst}.backup"
    fi

    ln -sfn "$src" "$dst"
    echo "Linked $dst -> $src"
}

echo ""
echo "Creating symlinks..."

# zsh
link "$DOTFILES/zsh/rc.zsh"            "$HOME/.zshrc"
link "$DOTFILES/zsh/rc.aliases"         "$HOME/.aliases"

# aerospace
link "$DOTFILES/aerospace/aerospace.toml" "$HOME/.config/aerospace/aerospace.toml"

# ghostty
link "$DOTFILES/ghostty/config"         "$HOME/.config/ghostty/config"

# fastfetch (link entire directory for logos + config)
link "$DOTFILES/fastfetch"              "$HOME/.config/fastfetch"

# lazygit
link "$DOTFILES/lazygit/config.yml"     "$HOME/Library/Application Support/lazygit/config.yml"

# tmux
link "$DOTFILES/tmux/tmux.conf"         "$HOME/.tmux.conf"

# tmux-sessionizer script
link "$DOTFILES/tmux/tmux-sessionizer"  "$HOME/.local/bin/tmux-sessionizer"

# obsidian-cli
link "$DOTFILES/obsidian-cli/config.yaml" "$HOME/.obsidian-cli/config.yaml"

# -----------------------------------------------------------
# 6. Done
# -----------------------------------------------------------
echo ""
echo "Setup complete! Open a new terminal to apply changes."
echo "Run 'tmux' then press prefix + I to install tmux plugins."
