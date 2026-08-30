#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${CYAN}${BOLD}[*] Starting TermOS setup...${NC}"

cd ~

ensure_pkg() {
    if ! dpkg -s "$1" &>/dev/null; then
        echo -e "${GREEN}[+] Installing $1...${NC}"
        pkg install -y "$1"
    else
        echo -e "${YELLOW}[i] $1 is already installed.${NC}"
    fi
}

pkg update -y

ensure_pkg zsh
ensure_pkg git
ensure_pkg which
ensure_pkg curl
ensure_pkg python
ensure_pkg nodejs
ensure_pkg termux-api
ensure_pkg bc
ensure_pkg sox
ensure_pkg mpv

mkdir -p ~/.zsh

if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
    echo -e "${GREEN}[+] Cloning zsh-autosuggestions...${NC}"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
else
    echo -e "${YELLOW}[i] zsh-autosuggestions already present.${NC}"
fi

if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
    echo -e "${GREEN}[+] Cloning zsh-syntax-highlighting...${NC}"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
else
    echo -e "${YELLOW}[i] zsh-syntax-highlighting already present.${NC}"
fi

if [ ! -d ~/.zsh/zsh-autocomplete ]; then
    echo -e "${GREEN}[+] Cloning zsh-autocomplete...${NC}"
    git clone https://github.com/marlonrichert/zsh-autocomplete.git ~/.zsh/zsh-autocomplete
else
    echo -e "${YELLOW}[i] zsh-autocomplete already present.${NC}"
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ -f "$SCRIPT_DIR/.zshrc" ]; then
    cp "$SCRIPT_DIR/.zshrc" ~/.zshrc
    echo -e "${GREEN}[+] .zshrc copied from script directory.${NC}"
else
    echo -e "${RED}[!] .zshrc not found in script directory, downloading from GitHub...${NC}"
    curl -fsSL -o ~/.zshrc "https://raw.githubusercontent.com/neveerlabs/TermOS/main/.zshrc" 2>/dev/null || {
        echo -e "${RED}[!] Failed to download .zshrc. Please check your internet connection or repository URL.${NC}"
        exit 1
    }
    if [ -f ~/.zshrc ]; then
        echo -e "${GREEN}[+] .zshrc downloaded successfully.${NC}"
    else
        echo -e "${RED}[!] Failed to download .zshrc.${NC}"
        exit 1
    fi
fi

mkdir -p ~/.termux/praytimes

if [ -f "$SCRIPT_DIR/PrayTimes.js" ]; then
    cp "$SCRIPT_DIR/PrayTimes.js" ~/.termux/praytimes/PrayTimes.js
    echo -e "${GREEN}[+] PrayTimes.js copied from script directory.${NC}"
else
    echo -e "${RED}[!] PrayTimes.js not found in script directory, downloading from GitHub...${NC}"
    curl -fsSL -o ~/.termux/praytimes/PrayTimes.js "https://raw.githubusercontent.com/neveerlabs/TermOS/main/PrayTimes.js" 2>/dev/null || {
        echo -e "${RED}[!] Failed to download PrayTimes.js. Please check your internet connection or repository URL.${NC}"
        exit 1
    }
    if [ -f ~/.termux/praytimes/PrayTimes.js ]; then
        echo -e "${GREEN}[+] PrayTimes.js downloaded successfully.${NC}"
    else
        echo -e "${RED}[!] Failed to download PrayTimes.js.${NC}"
        exit 1
    fi
fi

if [ -f "$SCRIPT_DIR/termux.properties" ]; then
    cp "$SCRIPT_DIR/termux.properties" ~/.termux/termux.properties
    echo -e "${GREEN}[+] termux.properties copied from script directory.${NC}"
else
    echo -e "${YELLOW}[!] termux.properties not found in script directory, skipping.${NC}"
fi

VENV_PATH="$HOME/venv"
VENV_CREATED=false
if [ ! -d "$VENV_PATH" ]; then
    echo -e "${CYAN}[*] Python virtual environment not found. Creating...${NC}"
    python3 -m venv "$VENV_PATH" || {
        echo -e "${RED}[!] Failed to create virtual environment. Trying to install python3-venv...${NC}"
        pkg install -y python
        python3 -m venv "$VENV_PATH" || {
            echo -e "${RED}[!] Could not create virtual environment. Continuing without it.${NC}"
            VENV_PATH=""
        }
    }
    if [ -d "$VENV_PATH" ]; then
        VENV_CREATED=true
        echo -e "${GREEN}[+] Virtual environment created at $VENV_PATH${NC}"
    fi
else
    echo -e "${YELLOW}[i] Python virtual environment already exists at $VENV_PATH${NC}"
fi

if [ -n "$VENV_PATH" ]; then
    source "$VENV_PATH/bin/activate"
    echo -e "${CYAN}[*] Upgrading pip...${NC}"
    pip install --upgrade pip 2>/dev/null || true
    echo -e "${CYAN}[*] Installing Python dependencies...${NC}"
    pip install requests 2>/dev/null || true
    deactivate
fi

touch ~/.hushlogin

if [ -f ~/.zsh_config ]; then
    source ~/.zsh_config
    echo -e "${CYAN}[*] Current username: $USER_NAME${NC}"
    read -rp "[?] Change username? (y/n): " ganti
    if [[ "$ganti" == "y" ]]; then
        read -rp "[+] Enter new username: " new_name
        USER_NAME="$new_name"
        echo "USER_NAME=$USER_NAME" > ~/.zsh_config
        echo -e "${GREEN}[+] Username updated.${NC}"
    else
        echo -e "${YELLOW}[i] Keeping existing username.${NC}"
    fi
else
    read -rp "[+] Enter your terminal username: " user_name
    echo "USER_NAME=$user_name" > ~/.zsh_config
    echo -e "${GREEN}[+] Username saved.${NC}"
fi

read -rp "[?] Auto-start MySQL/MariaDB if present? (y/n): " mysql_auto
if [[ "$mysql_auto" =~ ^[Yy] ]]; then
    ENABLE_MYSQL="yes"
else
    ENABLE_MYSQL="no"
fi
grep -q "^ENABLE_MYSQL=" ~/.zsh_config 2>/dev/null && sed -i "s/^ENABLE_MYSQL=.*/ENABLE_MYSQL=$ENABLE_MYSQL/" ~/.zsh_config || echo "ENABLE_MYSQL=$ENABLE_MYSQL" >> ~/.zsh_config

read -rp "[?] Enable automatic update check on startup? (y/n): " update_check
if [[ "$update_check" =~ ^[Yy] ]]; then
    UPDATE_CHECK="yes"
else
    UPDATE_CHECK="no"
fi
grep -q "^UPDATE_CHECK=" ~/.zsh_config 2>/dev/null && sed -i "s/^UPDATE_CHECK=.*/UPDATE_CHECK=$UPDATE_CHECK/" ~/.zsh_config || echo "UPDATE_CHECK=$UPDATE_CHECK" >> ~/.zsh_config

read -rp "[?] Enable notifications (prayer alarms, location updates)? (y/n): " notif_auto
if [[ "$notif_auto" =~ ^[Yy] ]]; then
    ENABLE_NOTIFICATIONS="yes"
else
    ENABLE_NOTIFICATIONS="no"
fi
grep -q "^ENABLE_NOTIFICATIONS=" ~/.zsh_config 2>/dev/null && sed -i "s/^ENABLE_NOTIFICATIONS=.*/ENABLE_NOTIFICATIONS=$ENABLE_NOTIFICATIONS/" ~/.zsh_config || echo "ENABLE_NOTIFICATIONS=$ENABLE_NOTIFICATIONS" >> ~/.zsh_config

if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "${GREEN}[+] Changing default shell to zsh...${NC}"
    chsh -s zsh
else
    echo -e "${YELLOW}[i] Default shell is already zsh.${NC}"
fi

if ! grep -q "exec zsh -l" ~/.bashrc; then
    echo "exec zsh -l" >> ~/.bashrc
    echo -e "${GREEN}[+] Zsh will now load automatically when you restart Termux.${NC}"
fi

echo -e "${CYAN}${BOLD}[*] Setup complete.${NC}"
echo ""
echo -e "${CYAN}${BOLD}=========== IMPORTANT NOTES ===========${NC}"
echo -e "1. Make sure Termux:API app is installed from F-Droid and permissions are granted (especially Location)."
echo -e "2. Run 'termux-location' once to trigger the location permission popup."
echo -e "3. To manually check prayer times, use commands: --location, --schedule, --update, --changelog"
echo -e "4. If sound not working, install one of: termux-media-player (built-in), sox, mpv"
echo -e "5. Restart Termux or run 'exec zsh' to start using the new configuration."
if [ "$VENV_CREATED" = true ]; then
    echo -e "6. A Python virtual environment was created at ~/venv. To use it, run: source ~/venv/bin/activate"
fi
echo -e "${CYAN}${BOLD}=======================================${NC}"
