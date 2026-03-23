#!/usr/bin/env bash
set -e

echo "==> Detecting package manager..."

if command -v apt >/dev/null; then
    PKG_MANAGER="apt"
elif command -v dnf >/dev/null; then
    PKG_MANAGER="dnf"
elif command -v pacman >/dev/null; then
    PKG_MANAGER="pacman"
else
    echo "Unsupported distro"
    exit 1
fi

install_pkg() {
    case $PKG_MANAGER in
        apt)
            sudo apt update
            sudo apt install -y "$@"
            ;;
        dnf)
            sudo dnf install -y "$@"
            ;;
        pacman)
            sudo pacman -Sy --noconfirm "$@"
            ;;
    esac
}

ensure_cmd() {
    if ! command -v "$1" >/dev/null; then
        echo "Installing $1..."
        install_pkg "$2"
    else
        echo "$1 already installed"
    fi
}

echo "==> Installing dependencies..."

ensure_cmd git git
ensure_cmd curl curl
ensure_cmd unzip unzip
ensure_cmd rg ripgrep
ensure_cmd fd fd-find
ensure_cmd node nodejs
ensure_cmd npm npm
ensure_cmd python3 python3
ensure_cmd pip3 python3-pip

echo "==> Installing build tools..."
install_pkg build-essential gcc make cmake

echo "==> Installing Java..."
install_pkg openjdk-21-jdk || install_pkg openjdk-17-jdk

# -------------------------------
# FIXES (from your previous errors)
# -------------------------------
echo "==> Fixing environment..."

mkdir -p ~/.local/bin

if command -v fdfind >/dev/null && ! command -v fd >/dev/null; then
    ln -sf "$(which fdfind)" ~/.local/bin/fd
fi

export PATH="$HOME/.local/bin:$PATH"

# Fix pip (PEP 668 compliant)
if ! python3 -m pip show pynvim >/dev/null 2>&1; then
    python3 -m venv ~/.venvs/nvim
    ~/.venvs/nvim/bin/pip install pynvim
fi

# -------------------------------
# NEOVIM INSTALL (official binary)
# -------------------------------
echo "==> Installing Neovim (official)..."

ARCH=$(uname -m)

if [[ "$ARCH" == "x86_64" ]]; then
    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz"
    NVIM_DIR="/opt/nvim-linux-x86_64"
elif [[ "$ARCH" == "aarch64" || "$ARCH" == "arm64" ]]; then
    NVIM_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz"
    NVIM_DIR="/opt/nvim-linux-arm64"
else
    echo "Unsupported architecture: $ARCH"
    exit 1
fi

cd /tmp

if command -v pv >/dev/null; then
    curl -L "$NVIM_URL" | pv > nvim.tar.gz
else
    wget --show-progress "$NVIM_URL" -O nvim.tar.gz
fi

sudo rm -rf "$NVIM_DIR"
sudo tar -C /opt -xzf nvim.tar.gz
rm nvim.tar.gz

# PATH setup
SHELL_CONFIG="$HOME/.bashrc"
[[ -n "$ZSH_VERSION" ]] && SHELL_CONFIG="$HOME/.zshrc"

NVIM_PATH_LINE="export PATH=\"\$PATH:$NVIM_DIR/bin\""

grep -qxF "$NVIM_PATH_LINE" "$SHELL_CONFIG" 2>/dev/null || echo "$NVIM_PATH_LINE" >> "$SHELL_CONFIG"

export PATH="$PATH:$NVIM_DIR/bin"

echo "Neovim version:"
nvim --version | head -n 1

# -------------------------------
# FONT INSTALL
# -------------------------------
echo "==> Nerd Fonts installation"

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

# Candidate fonts
FONTS=(
  "JetBrainsMono"
  "FiraCode"
  "Hack"
  "Meslo"
  "SourceCodePro"
)

# Detect installed fonts via fc-list
echo "==> Checking installed fonts..."

AVAILABLE_FONTS=()
INDEX=1

for FONT in "${FONTS[@]}"; do
    if fc-list | grep -iq "$FONT"; then
        echo "[✓] $FONT already installed"
    else
        echo "[$INDEX] $FONT"
        AVAILABLE_FONTS+=("$FONT")
        ((INDEX++))
    fi
done

if [ ${#AVAILABLE_FONTS[@]} -eq 0 ]; then
    echo "All fonts already installed. Skipping."
else
    echo "0) Skip"
    read -p "Select font to install: " choice

    if [[ "$choice" -gt 0 && "$choice" -le ${#AVAILABLE_FONTS[@]} ]]; then
        FONT_NAME="${AVAILABLE_FONTS[$((choice-1))]}"
        FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"

        echo "Installing $FONT_NAME..."

        cd /tmp

        if command -v pv >/dev/null; then
            curl -L "$FONT_URL" | pv > font.zip
        else
            wget --show-progress "$FONT_URL" -O font.zip
        fi

        unzip -o font.zip -d "$FONT_DIR"
        rm font.zip

        fc-cache -fv

        echo "$FONT_NAME installed successfully"
    else
        echo "Skipping font installation"
    fi
fi

# -------------------------------
# OPTIONAL: Git HTTPS fallback
# -------------------------------
#git config --global url."https://github.com/".insteadOf "git@github.com:"

# -------------------------------
# INSTALL NEOVIM PLUGINS
# -------------------------------
echo "==> Installing Neovim plugins..."
nvim --headless "+Lazy sync" +qa || true

echo "==> DONE"
