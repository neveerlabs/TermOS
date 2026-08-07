HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt NO_NOTIFY
setopt INTERACTIVE_COMMENTS

autoload -Uz compinit
compinit

if [[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555"
ZSH_AUTOSUGGEST_STRATEGY=(history)

if [[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]='fg=white'
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=magenta'

typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS=('--help' 'fg=cyan,bold' '--updates' 'fg=cyan,bold' '--update' 'fg=cyan,bold' '--changelog' 'fg=cyan,bold' '--location' 'fg=cyan,bold' '--schedule' 'fg=cyan,bold' '--tocket' 'fg=cyan,bold' '--profile' 'fg=cyan,bold')

if [[ -f ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]]; then
    source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' history-search yes
zstyle ':autocomplete:*' insert-unambiguous no
zstyle ':autocomplete:*' list-lines 16
zstyle ':autocomplete:*' autosuggest no
zstyle ':autocomplete:*' recent-dirs-insert always
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
bindkey -M autocomplete '^[[C' _accept_suggestion_or_forward_char
bindkey -M autocomplete '^F' autosuggest-accept

ZSH_PLUGINS_DIR="$HOME/.zsh/plugins"
if [[ -d "$ZSH_PLUGINS_DIR" ]]; then
    for plugin in "$ZSH_PLUGINS_DIR"/*.zsh "$ZSH_PLUGINS_DIR"/*.plugin.zsh; do
        [[ -f "$plugin" ]] || continue
        if ! source "$plugin" 2>/dev/null; then
            printf 'Warning: Failed to load plugin: %s\n' "${plugin:t}"
        fi
    done
fi

alias ls='ls --color=auto'
export LS_COLORS='di=36:fi=37:ln=36:ex=32:or=31:mi=31:pi=35:so=33:bd=33;1:cd=33;1:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:*.tar=01;33:*.tgz=01;33:*.arc=01;33:*.arj=01;33:*.taz=01;33:*.lha=01;33:*.lz4=01;33:*.lzh=01;33:*.lzma=01;33:*.tlz=01;33:*.txz=01;33:*.tzo=01;33:*.t7z=01;33:*.zip=01;33:*.z=01;33:*.dz=01;33:*.gz=01;33:*.lrz=01;33:*.lz=01;33:*.lzo=01;33:*.xz=01;33:*.zst=01;33:*.tzst=01;33:*.bz2=01;33:*.bz=01;33:*.tbz=01;33:*.tbz2=01;33:*.tz=01;33:*.deb=01;33:*.rpm=01;33:*.jar=01;33:*.war=01;33:*.ear=01;33:*.sar=01;33:*.rar=01;33:*.alz=01;33:*.ace=01;33:*.zoo=01;33:*.cpio=01;33:*.7z=01;33:*.rz=01;33:*.cab=01;33:*.wim=01;33:*.swm=01;33:*.dwm=01;33:*.esd=01;33:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

TERMUX_CONFIG_VERSION="v4.2.7"

[ -f ~/.zsh_config ] && source ~/.zsh_config
if [ -z "$USER_NAME" ]; then
    USER_NAME="user"
fi
if [ -z "$ENABLE_MYSQL" ]; then
    ENABLE_MYSQL="yes"
fi
if [ -z "$UPDATE_CHECK" ]; then
    UPDATE_CHECK="yes"
fi

if [[ "$ENABLE_MYSQL" == "yes" ]]; then
    if command -v mysqld >/dev/null 2>&1 || command -v mariadbd >/dev/null 2>&1; then
        if ! pgrep -x "mysqld" > /dev/null && ! pgrep -x "mariadbd" > /dev/null; then
            termux-wake-lock 2>/dev/null
            mysqld --log-error=/dev/null --general-log=0 --slow-query-log=0 --pid-file=$PREFIX/var/lib/mysql/$(hostname).pid &>/dev/null &!
        fi
    fi
fi

TERMUX_CONFIG_DIR="$HOME/Termux-Config"
_update_check_done=0

_download_with_progress() {
    local url="$1"
    local dest="$2"
    local filename=$(basename "$dest")
    local remote_size
    remote_size=$(curl -sI "$url" 2>/dev/null | grep -i content-length | awk '{print $2}' | tr -d '\r')
    local remote_kb="?"
    if [[ -n "$remote_size" && "$remote_size" -gt 0 ]]; then
        remote_kb=$(( remote_size / 1024 ))
    else
        remote_size=0
    fi

    setopt localoptions no_monitor 2>/dev/null

    curl -L -o "$dest" "$url" 2>/dev/null &
    local pid=$!

    local bar_width=20
    local filled=0
    local percent=0
    local dest_size=0
    local bar=""
    local i

    if [[ "$remote_size" -gt 0 ]]; then
        printf 'Updating %s %skb [' "$filename" "$remote_kb"
        while kill -0 "$pid" 2>/dev/null; do
            if [[ -f "$dest" ]]; then
                dest_size=$(wc -c < "$dest" 2>/dev/null || echo 0)
            fi
            percent=$(( dest_size * 100 / remote_size ))
            (( percent > 100 )) && percent=100
            filled=$(( percent * bar_width / 100 ))
            bar=""
            for ((i=0; i<filled; i++)); do bar+="#"; done
            for ((i=filled; i<bar_width; i++)); do bar+="·"; done
            printf '\rUpdating %s %skb [%s] %d%%' "$filename" "$remote_kb" "$bar" "$percent"
            sleep 0.2
        done
        wait "$pid" 2>/dev/null
        local exit_code=$?
        bar=""
        for ((i=0; i<bar_width; i++)); do bar+="#"; done
        if [[ $exit_code -eq 0 ]]; then
            printf '\rUpdating %s %skb [%s] Done\n' "$filename" "$remote_kb" "$bar"
            return 0
        else
            printf '\rUpdating %s %skb [%s] Failed\n' "$filename" "$remote_kb" "$bar"
            return 1
        fi
    else
        printf 'Updating %s ...' "$filename"
        wait "$pid" 2>/dev/null
        local exit_code=$?
        if [[ $exit_code -eq 0 ]]; then
            printf '\rUpdating %s Done\n' "$filename"
            return 0
        else
            printf '\rUpdating %s Failed\n' "$filename"
            return 1
        fi
    fi
}

_get_remote_version() {
    if ! command -v curl >/dev/null 2>&1; then
        return 1
    fi
    local remote_zshrc
    remote_zshrc=$(curl -fsSL --max-time 10 "https://raw.githubusercontent.com/neveerlabs/Termux-Config/main/.zshrc" 2>/dev/null)
    if [[ -z "$remote_zshrc" ]]; then
        return 1
    fi
    local ver
    ver=$(echo "$remote_zshrc" | grep -o 'TERMUX_CONFIG_VERSION="[^"]*"' | head -1 | grep -o '"[^"]*"' | tr -d '"')
    if [[ -z "$ver" ]]; then
        return 1
    fi
    echo "$ver"
    return 0
}

_version_parse() {
    if command -v python3 >/dev/null 2>&1; then
        python3 -c "import sys; v=sys.argv[1].lstrip('v'); print('.'.join(str(int(x)) for x in v.split('.')))" "$1" 2>/dev/null || echo "0.0.0"
    else
        local v="${1#v}"
        echo "$v" | awk -F. '{ printf "%d.%d.%d", $1+0, $2+0, $3+0 }' 2>/dev/null || echo "0.0.0"
    fi
}

_version_greater_equal() {
    local v1=$(_version_parse "$1")
    local v2=$(_version_parse "$2")
    if command -v python3 >/dev/null 2>&1; then
        python3 -c "
import sys
v1 = tuple(map(int, sys.argv[1].split('.')))
v2 = tuple(map(int, sys.argv[2].split('.')))
sys.exit(0 if v1 >= v2 else 1)
" "$v1" "$v2" 2>/dev/null
        return $?
    else
        local IFS=.
        local a1=(${=v1})
        local a2=(${=v2})
        for i in 1 2 3; do
            local x=${a1[$i]:-0}
            local y=${a2[$i]:-0}
            if (( x > y )); then
                return 0
            elif (( x < y )); then
                return 1
            fi
        done
        return 0
    fi
}

_show_changelog_since() {
    local since_version="$1"
    local changelog_file="$TERMUX_CONFIG_DIR/Changelog.json"
    local changelog_json
    if command -v curl >/dev/null 2>&1; then
        changelog_json=$(curl -fsSL --max-time 10 "https://raw.githubusercontent.com/neveerlabs/Termux-Config/main/Changelog.json" 2>/dev/null)
        if [[ -n "$changelog_json" ]]; then
            printf '%s\n' "$changelog_json" > "$changelog_file"
        fi
    fi
    if [[ -z "$changelog_json" ]]; then
        if [[ -f "$changelog_file" ]]; then
            changelog_json=$(cat "$changelog_file")
        else
            printf 'Changelog not available.\n'
            return 1
        fi
    fi
    local output
    if command -v python3 >/dev/null 2>&1; then
        output=$(python3 -c "
import json, sys
entries = json.loads(sys.stdin.read())
since = sys.argv[1]
def parse(v):
    return tuple(map(int, v.lstrip('v').split('.')))
target = parse(since)
latest = None
for e in entries:
    if parse(e['version']) > target:
        latest = e
        break
if latest:
    print(latest['version'])
    print(latest['changes'])
else:
    print('')
    print('No recent changes.')
" "$since_version" <<< "$changelog_json" 2>/dev/null) || {
        printf 'Failed to parse changelog.\n'
        return 1
    }
    else
        printf 'Python3 required to display changelog.\n'
        return 1
    fi
    if [[ -n "$output" ]]; then
        local version_clean
        version_clean=$(echo "$output" | head -1)
        local changes
        changes=$(echo "$output" | tail -n +2)
        if [[ "$version_clean" == "No recent changes." || -z "$version_clean" ]]; then
            printf '%s\n' "$changes"
            return 0
        fi
        _print_styled_header "Changelog ${version_clean}"
        printf '%s\n' "$changes"
    fi
}

_show_current_changelog() {
    local changelog_file="$TERMUX_CONFIG_DIR/Changelog.json"
    local changelog_json
    if command -v curl >/dev/null 2>&1; then
        changelog_json=$(curl -fsSL --max-time 10 "https://raw.githubusercontent.com/neveerlabs/Termux-Config/main/Changelog.json" 2>/dev/null)
        if [[ -n "$changelog_json" ]]; then
            printf '%s\n' "$changelog_json" > "$changelog_file"
        fi
    fi
    if [[ -z "$changelog_json" ]]; then
        if [[ -f "$changelog_file" ]]; then
            changelog_json=$(cat "$changelog_file")
        else
            printf 'Changelog not available.\n'
            return 1
        fi
    fi
    local output
    if command -v python3 >/dev/null 2>&1; then
        output=$(python3 -c "
import json, sys
entries = json.loads(sys.stdin.read())
current_version = sys.argv[1]
found = None
for e in entries:
    if e['version'] == current_version:
        found = e
        break
if found:
    print(found['version'])
    print(found['changes'])
else:
    print('')
    print('No changelog found for current version.')
" "$TERMUX_CONFIG_VERSION" <<< "$changelog_json" 2>/dev/null) || {
        printf 'Failed to parse changelog.\n'
        return 1
    }
    else
        printf 'Python3 required to display changelog.\n'
        return 1
    fi
    if [[ -n "$output" ]]; then
        local version_clean
        version_clean=$(echo "$output" | head -1)
        local changes
        changes=$(echo "$output" | tail -n +2)
        if [[ "$version_clean" == "No changelog found for current version." || -z "$version_clean" ]]; then
            printf '%s\n' "$changes"
            return 0
        fi
        _print_styled_header "Changelog ${version_clean}"
        printf '%s\n' "$changes"
    fi
}

_print_styled_header() {
    local header="$1"
    local cols
    cols=$(stty size 2>/dev/null | awk '{print $2}')
    [[ -z "$cols" ]] && cols=80
    local header_len=${#header}
    local pad=$(( (cols - header_len) / 2 ))
    (( pad < 0 )) && pad=0
    local line
    line=$(printf '\u2500%.0s' $(seq 1 $cols))
    printf "%*s\e[3m%s\e[0m\n" "$pad" "" "$header"
    printf '%s\n' "$line"
}

_update_plugins() {
    local plugins=(
        "$HOME/.zsh/zsh-autosuggestions"
        "$HOME/.zsh/zsh-syntax-highlighting"
        "$HOME/.zsh/zsh-autocomplete"
    )
    for plugin in "${plugins[@]}"; do
        if [[ -d "$plugin/.git" ]]; then
            git -C "$plugin" pull --ff-only 2>/dev/null
        fi
    done
}

_perform_update() {
    local base_url="https://raw.githubusercontent.com/neveerlabs/Termux-Config/main"
    local update_failed=0
    mkdir -p "$TERMUX_CONFIG_DIR"
    _download_with_progress "$base_url/.zshrc" "$HOME/.zshrc.tmp" || update_failed=1
    if [[ $update_failed -eq 0 ]]; then
        mv "$HOME/.zshrc.tmp" "$HOME/.zshrc"
        cp "$HOME/.zshrc" "$TERMUX_CONFIG_DIR/.zshrc"
    fi
    _download_with_progress "$base_url/Changelog.json" "$TERMUX_CONFIG_DIR/Changelog.json" || true
    _download_with_progress "$base_url/README.md" "$TERMUX_CONFIG_DIR/README.md" || true
    _download_with_progress "$base_url/config.sh" "$TERMUX_CONFIG_DIR/config.sh" || true
    _download_with_progress "$base_url/termux.properties" "$HOME/.termux/termux.properties" || true
    if command -v termux-reload-settings >/dev/null 2>&1; then
        termux-reload-settings 2>/dev/null || true
    else
        printf '\nNote: Restart Termux or run termux-reload-settings to apply new properties.\n'
    fi
    _update_plugins
    if [[ $update_failed -eq 0 ]]; then
        printf '\nUpdate complete. Restart Termux to apply changes.\n'
    else
        printf '\nUpdate finished with errors. Some files may not have been updated.\n'
    fi
}

_scan_updates_output() {
    if ! command -v curl >/dev/null 2>&1; then
        printf 'curl is required.\n'
        return 1
    fi
    local remote_version
    remote_version=$(_get_remote_version)
    if [[ -z "$remote_version" ]]; then
        printf 'Unable to check remote version. Check your internet connection.\n'
        return 1
    fi
    printf 'Local version:  %s\n' "$TERMUX_CONFIG_VERSION"
    printf 'Remote version: %s\n' "$remote_version"
    if [[ "$TERMUX_CONFIG_VERSION" != "$remote_version" ]]; then
        if _version_greater_equal "$remote_version" "$TERMUX_CONFIG_VERSION"; then
            printf '\nUpdate available.\n\n'
            _show_changelog_since "$TERMUX_CONFIG_VERSION"
        else
            printf '\nLocal version is newer than remote. You may have a pre-release.\n'
        fi
    else
        printf 'Already up to date.\n'
    fi
    return 0
}

_check_for_updates() {
    if [[ $_update_check_done -eq 1 ]]; then
        return
    fi
    _update_check_done=1
    if [[ "$UPDATE_CHECK" != "yes" ]]; then
        return
    fi
    if [[ ! -d "$TERMUX_CONFIG_DIR" ]]; then
        mkdir -p "$TERMUX_CONFIG_DIR"
    fi
    if ! command -v curl >/dev/null 2>&1; then
        return
    fi
    local remote_version
    remote_version=$(_get_remote_version)
    if [[ -z "$remote_version" ]]; then
        return
    fi
    if [[ "$TERMUX_CONFIG_VERSION" != "$remote_version" ]]; then
        if _version_greater_equal "$remote_version" "$TERMUX_CONFIG_VERSION"; then
            printf '\n'
            printf '╔══════════════════════════════════════════╗\n'
            printf '║  Update available!                       ║\n'
            printf '╠══════════════════════════════════════════╣\n'
            printf '║  Current version: %-23s║\n' "$TERMUX_CONFIG_VERSION"
            printf '║  New version:     %-23s║\n' "$remote_version"
            printf '╚══════════════════════════════════════════╝\n'
            printf '\n'
            _show_changelog_since "$TERMUX_CONFIG_VERSION"
            printf 'Do you want to update? (y/n): '
            read -rk1 ans
            printf '\n'
            if [[ "$ans" == "y" || "$ans" == "Y" ]]; then
                _perform_update
            fi
        fi
    fi
}

show_banner() {
    local cols
    cols=$(stty size 2>/dev/null | awk '{print $2}')
    [[ -z "$cols" || "$cols" -lt 10 ]] && cols=80

    local lines=(
        "████████╗███████╗██████╗ ███╗   ███╗ ██████╗ ███████╗"
        "╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██╔═══██╗██╔════╝"
        "   ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║███████╗"
        "   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║╚════██║"
        "   ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝███████║"
        "   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚══════╝"
    )

    local max_len=0
    local line
    for line in "${lines[@]}"; do
        local len=${#line}
        (( len > max_len )) && max_len=$len
    done

    for line in "${lines[@]}"; do
        local padding=$(( (cols - max_len) / 2 ))
        (( padding < 0 )) && padding=0
        printf "%*s\e[1;37m%s\e[0m\n" "$padding" "" "$line"
    done

    local info="(c) 2026 Neverlabs. All rights reserved."
    local info_len=${#info}
    local padding=$(( (cols - info_len) / 2 ))
    (( padding < 0 )) && padding=0
    printf "%*s\e[1;37m%s\e[0m\n" "$padding" "" "$info"
    echo
}

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%f'

_last_exit_code=0
_first_prompt=1
precmd() {
    _last_exit_code=$?
    if (( _first_prompt )); then
        printf '\033[2J\033[H'
        show_banner
        _first_prompt=0
        (_check_for_updates >/dev/null 2>&1 &)
        (_auto_update_schedule >/dev/null 2>&1 &)
    fi
    vcs_info
    printf '\e[2 q'
    printf '\e]12;white\a'

    local env_part=""
    if [[ -n $VIRTUAL_ENV ]]; then
        env_part="%F{green}($(basename $VIRTUAL_ENV))-%f"
    fi

    local display_path
    if [[ $PWD == $HOME ]]; then
        display_path="~"
    elif [[ $PWD == $HOME/* ]]; then
        display_path="~/${PWD#$HOME/}"
    else
        display_path="$PWD"
    fi

    if (( ${#display_path} > 30 )); then
        if [[ $PWD == $HOME || $PWD == $HOME/* ]]; then
            display_path="~/⋯/${PWD##*/}"
        else
            display_path="/⋯/${PWD##*/}"
        fi
    fi

    local green="%F{green}"
    local cyan="%F{cyan}"
    local white="%F{white}"
    local reset="%f"

    PROMPT="${green}┌───${reset}${env_part}${green}(${reset}${cyan}${USER_NAME}㉿TermOS${reset}${green})-[${reset}%B%F{white}${display_path}%f%b${reset}${green}]${vcs_info_msg_0_}${reset}
${green}└──${white}\$${reset} "
}

zshaddhistory() {
    [[ $_last_exit_code -eq 0 ]] && return 0 || return 1
}

function _accept_suggestion_or_forward_char() {
    if [[ -n $POSTDISPLAY ]] && [[ $CURSOR -eq ${#BUFFER} ]]; then
        zle autosuggest-accept
    else
        zle forward-char
    fi
}
zle -N _accept_suggestion_or_forward_char
bindkey '^[[C' _accept_suggestion_or_forward_char
bindkey '^F' autosuggest-accept
bindkey '^[[1;3C' forward-word

_autopair_insert() {
    local open="$1" close="$2"
    LBUFFER+="$open$close"
    zle backward-char
}

_autopair_insert_paren() { _autopair_insert '(' ')'; }
_autopair_insert_bracket() { _autopair_insert '[' ']'; }
_autopair_insert_brace() { _autopair_insert '{' '}'; }
_autopair_insert_angle() { _autopair_insert '<' '>'; }
_autopair_insert_single() { _autopair_insert "'" "'"; }
_autopair_insert_double() { _autopair_insert '"' '"'; }
_autopair_insert_backtick() { _autopair_insert '`' '`'; }

zle -N _autopair_insert_paren
zle -N _autopair_insert_bracket
zle -N _autopair_insert_brace
zle -N _autopair_insert_angle
zle -N _autopair_insert_single
zle -N _autopair_insert_double
zle -N _autopair_insert_backtick

bindkey '(' _autopair_insert_paren
bindkey '[' _autopair_insert_bracket
bindkey '{' _autopair_insert_brace
bindkey '<' _autopair_insert_angle
bindkey "'" _autopair_insert_single
bindkey '"' _autopair_insert_double
bindkey '`' _autopair_insert_backtick

command_not_found_handler() {
    case "$1" in
        --help)
            printf '%s\n' "Available custom commands:"
            printf '%s\n' "  --help          Show this help message"
            printf '%s\n' "  --updates [scan|install]   Check for updates (default: scan)"
            printf '%s\n' "  --update        Update configuration files"
            printf '%s\n' "  --reconfig      Re-run setup script"
            printf '%s\n' "  --changelog     Show changelog for current version"
            printf '%s\n' "  --location      Show real-time location data"
            printf '%s\n' "  --schedule      Show prayer times schedule"
            printf '%s\n' "  --tocket        Run Tocket tool (auto-setup if needed)"
            printf '%s\n' "  --profile       Show device profile & OS info"
            return 0
            ;;
        --updates)
            if [[ -z "$2" || "$2" == "scan" ]]; then
                _scan_updates_output
            elif [[ "$2" == "install" ]]; then
                _perform_update
            else
                printf 'Usage: --updates [scan|install]\n'
                return 1
            fi
            return 0
            ;;
        --update)
            _perform_update
            return 0
            ;;
        --reconfig)
            if [[ -f "$TERMUX_CONFIG_DIR/config.sh" ]]; then
                bash "$TERMUX_CONFIG_DIR/config.sh"
            else
                printf 'Config script not found. Run --update to fetch it.\n'
                return 1
            fi
            return 0
            ;;
        --changelog)
            _show_current_changelog
            return 0
            ;;
        --location)
            _location_realtime_handler
            return 0
            ;;
        --schedule)
            _schedule_display_handler
            return 0
            ;;
        --tocket)
            _tocket_handler
            return 0
            ;;
        --profile)
            _profile_handler
            return 0
            ;;
        *)
            printf 'zsh: command not found: %s\n' "$1"
            return 127
            ;;
    esac
}

LOCATION_FILE="$HOME/.termux/location.json"
SCHEDULE_FILE="$HOME/.termux/schedule.json"
TEMP_DIR="$HOME/.termux/tmp"
SOUND_DIR="$TERMUX_CONFIG_DIR/sound"
ALARM_PID_FILE="$HOME/.termux/alarm_pids.txt"
ALARM_FLAG_FILE="$HOME/.termux/alarm_scheduled_date"
LOCK_FILE="$HOME/.termux/.location.lock"

mkdir -p "$TEMP_DIR" 2>/dev/null
mkdir -p "$SOUND_DIR" 2>/dev/null

_find_praytimes() {
    if [[ -f "$HOME/.termux/praytimes/PrayTimes.js" ]]; then
        echo "$HOME/.termux/praytimes/PrayTimes.js"
    elif [[ -f "$HOME/PrayTimes.js" ]]; then
        echo "$HOME/PrayTimes.js"
    else
        echo ""
    fi
}

_notify() {
    local title="$1"
    local message="$2"
    if command -v termux-notification >/dev/null 2>&1; then
        termux-notification --title "$title" --content "$message" --sound --priority high 2>/dev/null || true
    elif command -v termux-tts-speak >/dev/null 2>&1; then
        termux-tts-speak "$message" 2>/dev/null || true
    else
        printf '\a'
    fi
}

_ensure_sound_files() {
    local base="https://raw.githubusercontent.com/neveerlabs/Termux-Config/main/sound"
    local files=("alarm.mp3" "sapa.mp3" "adzan.mp3")
    for f in "${files[@]}"; do
        if [[ ! -f "$SOUND_DIR/$f" ]]; then
            curl -fsSL --max-time 20 --retry 2 --retry-delay 1 -o "$SOUND_DIR/$f" "$base/$f" 2>/dev/null || true
        fi
    done
}

_play_mp3() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        return 1
    fi
    if command -v termux-media-player >/dev/null 2>&1; then
        termux-media-player play "$file" 2>/dev/null
        sleep 1
        while termux-media-player info 2>/dev/null | grep -q "playing"; do
            sleep 1
        done
        return 0
    elif command -v play >/dev/null 2>&1; then
        play -q "$file" 2>/dev/null
        return $?
    elif command -v mpv >/dev/null 2>&1; then
        mpv --no-terminal --really-quiet "$file" 2>/dev/null
        return $?
    else
        return 1
    fi
}

_kill_old_alarms() {
    if [[ -f "$ALARM_PID_FILE" ]]; then
        while read pid; do
            kill "$pid" 2>/dev/null || true
        done < "$ALARM_PID_FILE"
        rm -f "$ALARM_PID_FILE"
    fi
}

_schedule_prayer_alarms() {
    if [[ ! -f "$SCHEDULE_FILE" ]]; then
        return 1
    fi
    _ensure_sound_files

    local now_ts=$(date +%s)
    local schedule_json=$(cat "$SCHEDULE_FILE" 2>/dev/null)
    if [[ -z "$schedule_json" ]]; then
        return 1
    fi
    local date_sched=$(echo "$schedule_json" | node -e "process.stdout.write(JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).date)" 2>/dev/null)
    local today=$(date +%Y-%m-%d)

    if [[ "$date_sched" != "$today" ]]; then
        return 1
    fi

    if [[ -f "$ALARM_FLAG_FILE" ]]; then
        local saved_date=$(cat "$ALARM_FLAG_FILE" 2>/dev/null)
        if [[ "$saved_date" == "$today" ]]; then
            return 0
        fi
    fi

    _kill_old_alarms
    echo "$today" > "$ALARM_FLAG_FILE"

    local prayers=("fajr" "dhuhr" "asr" "maghrib" "isha")
    local prayer_names=("Subuh" "Zuhur" "Ashar" "Maghrib" "Isya")

    for i in {1..5}; do
        local key="${prayers[$i]}"
        local name="${prayer_names[$i]}"
        local time_str=$(echo "$schedule_json" | node -e "
            const t = JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).times;
            process.stdout.write(t['$key']);
        " 2>/dev/null)
        if [[ -z "$time_str" ]]; then
            continue
        fi
        local target_ts=$(date -d "$today $time_str" +%s 2>/dev/null || echo 0)
        if (( target_ts <= now_ts )); then
            continue
        fi

        local alarm15_ts=$(( target_ts - 900 ))
        local sapa_ts=$(( target_ts - 30 ))
        local adzan_ts=$target_ts

        if (( alarm15_ts > now_ts )); then
            (
                sleep $(( alarm15_ts - now_ts ))
                _notify "Alarm sebelum adzan $name" "Beberapa saat lagi akan masuk waktu adzan $name, berhentilah sejenak untuk beristirahat dan menunaikan ibadah sholat $name"
                _play_mp3 "$SOUND_DIR/alarm.mp3"
            ) &
            echo $! >> "$ALARM_PID_FILE" 2>/dev/null
        fi

        if (( sapa_ts > now_ts )); then
            (
                sleep $(( sapa_ts - now_ts ))
                _play_mp3 "$SOUND_DIR/sapa.mp3"
            ) &
            echo $! >> "$ALARM_PID_FILE" 2>/dev/null
        fi

        if (( adzan_ts > now_ts )); then
            (
                sleep $(( adzan_ts - now_ts ))
                _notify "Waktunya sholat $name!" "STOP!!! Angkat tangan kamu dari ponsel, sekarang sudah masuk waktunya sholat!"
                _play_mp3 "$SOUND_DIR/adzan.mp3"
            ) &
            echo $! >> "$ALARM_PID_FILE" 2>/dev/null
        fi
    done
}

_fetch_location() {
    local THRESHOLD=10
    local MAX_TRIES=5
    local SLEEP_INTERVAL=1
    local lat="" lon="" acc=999
    local best_lat="" best_lon="" best_acc=999
    local address_json=""

    mkdir -p "$HOME/.termux" 2>/dev/null

    for ((i=1; i<=MAX_TRIES; i++)); do
        local location_json
        location_json=$(termux-location 2>/dev/null) || true
        if [[ -z "$location_json" ]]; then
            sleep "$SLEEP_INTERVAL"
            continue
        fi
        local parsed
        parsed=$(node -e "
            const d = JSON.parse(require('fs').readFileSync('/dev/stdin','utf8'));
            if (d.error) { console.log('ERROR:' + d.error); process.exit(1); }
            console.log(d.latitude + ',' + d.longitude + ',' + (d.accuracy || 999));
        " <<< "$location_json" 2>/dev/null) || continue
        IFS=',' read -r lat lon acc <<< "$parsed"
        if [[ -z "$lat" || -z "$lon" ]]; then
            continue
        fi
        if (( $(echo "$acc < $best_acc" | bc -l) )); then
            best_lat="$lat"
            best_lon="$lon"
            best_acc="$acc"
        fi
        if (( $(echo "$acc < $THRESHOLD" | bc -l) )); then
            break
        fi
        sleep "$SLEEP_INTERVAL"
    done

    if [[ -z "$best_lat" ]]; then
        _notify "Gagal mendapatkan lokasi!" "Tidak dapat mengambil lokasi anda! Pastikan GPS anda aktif dan terkoneksi ke internet."
        return 1
    fi

    lat="$best_lat"
    lon="$best_lon"
    acc="$best_acc"

    address_json=$(curl -sS --max-time 10 --retry 2 --retry-delay 1 "https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lon}&addressdetails=1&accept-language=id" 2>/dev/null || echo '{}')

    local kelurahan="" kecamatan="" kota=""
    kelurahan=$(echo "$address_json" | node -e "const d=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')); const a=d.address||{}; process.stdout.write(a.village||a.suburb||a.neighbourhood||a.hamlet||'')" 2>/dev/null)
    kecamatan=$(echo "$address_json" | node -e "const d=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')); const a=d.address||{}; process.stdout.write(a.county||a.city_district||a.district||'')" 2>/dev/null)
    kota=$(echo "$address_json" | node -e "const d=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')); const a=d.address||{}; process.stdout.write(a.city||a.town||a.municipality||'')" 2>/dev/null)

    node -e "
        const addr = JSON.parse(require('fs').readFileSync('/dev/stdin','utf8'));
        const loc = {
            latitude: $lat,
            longitude: $lon,
            accuracy: $acc,
            timestamp: new Date().toISOString(),
            address: addr.address || {}
        };
        require('fs').writeFileSync('$LOCATION_FILE', JSON.stringify(loc, null, 2));
    " <<< "$address_json" 2>/dev/null

    _notify "Berhasil mendapatkan lokasi" "Lokasi anda saat ini: ${kelurahan}, ${kecamatan} ${kota} dengan accuracy ${acc}m! Tabel akan segera disesuaikan."
    return 0
}

_generate_schedule() {
    local PRAYTIMES_JS=$(_find_praytimes)
    if [[ -z "$PRAYTIMES_JS" ]]; then
        _notify "Terjadi kesalahan!" "Error: PrayTimes.js tidak ditemukan."
        return 1
    fi

    if [[ ! -f "$LOCATION_FILE" ]]; then
        _notify "Terjadi kesalahan!" "Error: location.json not found."
        return 1
    fi

    mkdir -p "$HOME/.termux" 2>/dev/null

    local lat lon
    lat=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$LOCATION_FILE','utf8')).latitude)" 2>/dev/null)
    lon=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$LOCATION_FILE','utf8')).longitude)" 2>/dev/null)

    if [[ -z "$lat" || -z "$lon" ]]; then
        _notify "Terjadi kesalahan!" "Error: Invalid location data."
        return 1
    fi

    local offset_hours=$(date +%z | sed 's/^+//; s/^-//; s/^0*//' | awk '{print $1/100}')
    [[ $(date +%z) == -* ]] && offset_hours="-$offset_hours"

    local year=$(date +%Y) month=$(date +%m) day=$(date +%d)

    local temp_pt="$TEMP_DIR/praytimes_$$.js"
    cat "$PRAYTIMES_JS" > "$temp_pt" 2>/dev/null
    echo '; module.exports = PrayTime;' >> "$temp_pt" 2>/dev/null

    local times_json
    times_json=$(node -e "
        const PrayTime = require('$temp_pt');
        const pt = new PrayTime('MWL');
        pt.location([$lat, $lon]);
        pt.utcOffset($offset_hours);
        pt.format('24h');
        const t = pt.times([$year, $month, $day]);
        console.log(JSON.stringify({ fajr: t.fajr, dhuhr: t.dhuhr, asr: t.asr, maghrib: t.maghrib, isha: t.isha }));
    " 2>/dev/null) || {
        rm -f "$temp_pt" 2>/dev/null
        _notify "Terjadi kesalahan!" "Error: Failed to calculate prayer times."
        return 1
    }

    rm -f "$temp_pt" 2>/dev/null

    node -e "
        const loc = JSON.parse(require('fs').readFileSync('$LOCATION_FILE','utf8'));
        const times = JSON.parse('$times_json');
        const sched = {
            date: '$year-$month-$day',
            generated_at: new Date().toISOString(),
            location: loc,
            times: times
        };
        require('fs').writeFileSync('$SCHEDULE_FILE', JSON.stringify(sched, null, 2));
    " 2>/dev/null

    local kelurahan="" kecamatan="" kota=""
    kelurahan=$(node -e "const a=JSON.parse(require('fs').readFileSync('$LOCATION_FILE','utf8')).address||{}; process.stdout.write(a.village||a.suburb||a.neighbourhood||a.hamlet||'')" 2>/dev/null)
    kecamatan=$(node -e "const a=JSON.parse(require('fs').readFileSync('$LOCATION_FILE','utf8')).address||{}; process.stdout.write(a.county||a.city_district||a.district||'')" 2>/dev/null)
    kota=$(node -e "const a=JSON.parse(require('fs').readFileSync('$LOCATION_FILE','utf8')).address||{}; process.stdout.write(a.city||a.town||a.municipality||'')" 2>/dev/null)

    _notify "Jadwal sholat berhasil dibuat!" "Jadwal adzan untuk ${kelurahan}, ${kecamatan} ${kota} berhasil dibuat!"
    return 0
}

_auto_update_schedule() {
    if ! command -v termux-location >/dev/null 2>&1 || ! command -v node >/dev/null 2>&1 || ! command -v curl >/dev/null 2>&1; then
        return 1
    fi

    local PRAYTIMES_JS=$(_find_praytimes)
    if [[ -z "$PRAYTIMES_JS" ]]; then
        return 1
    fi

    if [[ -f "$LOCK_FILE" ]]; then
        local lock_pid=$(cat "$LOCK_FILE" 2>/dev/null)
        if [[ -n "$lock_pid" ]] && kill -0 "$lock_pid" 2>/dev/null; then
            return 0
        fi
    fi
    echo $$ > "$LOCK_FILE" 2>/dev/null

    local today=$(date +%Y-%m-%d)
    local need_update=1

    if [[ -f "$SCHEDULE_FILE" ]]; then
        local saved_date=$(node -e "console.log(JSON.parse(require('fs').readFileSync('$SCHEDULE_FILE','utf8')).date)" 2>/dev/null)
        if [[ "$saved_date" == "$today" ]]; then
            need_update=0
        fi
    fi

    if (( need_update )); then
        _fetch_location && _generate_schedule
    fi

    _schedule_prayer_alarms
    rm -f "$LOCK_FILE" 2>/dev/null
}

_tocket_handler() {
    local TOCKET_DIR="$HOME/Tocket"
    local MAIN_PY="$TOCKET_DIR/Tocket/main.py"
    local REQ_FILE="$TOCKET_DIR/Tocket/requirements.txt"
    local VENV_DIR=""
    local PYTHON_BIN=""
    local PIP_BIN=""

    if [[ ! -d "$TOCKET_DIR" ]]; then
        printf 'Cloning Tocket repository...\n'
        if ! git clone --quiet https://github.com/neveerlabs/Tocket.git "$TOCKET_DIR" 2>/dev/null; then
            printf 'Error: Failed to clone Tocket repository.\n'
            return 1
        fi
        printf 'Clone complete.\n'
    fi

    if [[ ! -f "$MAIN_PY" ]]; then
        printf 'Error: %s not found. The repository might be incomplete.\n' "$MAIN_PY"
        return 1
    fi

    if [[ -n "$VIRTUAL_ENV" && -x "$VIRTUAL_ENV/bin/python" ]]; then
        VENV_DIR="$VIRTUAL_ENV"
        PYTHON_BIN="$VENV_DIR/bin/python"
        PIP_BIN="$VENV_DIR/bin/pip"
        printf 'Using virtual environment: %s\n' "$VENV_DIR"
    elif [[ -d "$HOME/venv" && -x "$HOME/venv/bin/python" ]]; then
        VENV_DIR="$HOME/venv"
        PYTHON_BIN="$VENV_DIR/bin/python"
        PIP_BIN="$VENV_DIR/bin/pip"
        printf 'Using virtual environment: %s\n' "$VENV_DIR"
    else
        printf 'Creating virtual environment venv...\n'
        if ! python3 -m venv "$HOME/venv" 2>/dev/null; then
            printf 'Error: Failed to create virtual environment.\n'
            return 1
        fi
        VENV_DIR="$HOME/venv"
        PYTHON_BIN="$VENV_DIR/bin/python"
        PIP_BIN="$VENV_DIR/bin/pip"
        printf 'venv created.\n'
    fi

    if ! "$PYTHON_BIN" -m pip --version >/dev/null 2>&1; then
        printf 'Error: pip not found in environment.\n'
        return 1
    fi

    if [[ -f "$REQ_FILE" ]]; then
        printf 'Installing requirements...\n'
        if ! "$PYTHON_BIN" -m pip install -r "$REQ_FILE" --quiet 2>/dev/null; then
            printf 'Error: Failed to install requirements.\n'
            return 1
        fi
        printf 'Requirements installed.\n'
    else
        printf 'Warning: requirements.txt not found.\n'
    fi

    printf 'Launching Tocket...\n'
    if ! "$PYTHON_BIN" "$MAIN_PY"; then
        local exit_code=$?
        printf 'Error: Tocket exited with code %d.\n' "$exit_code"
        return 1
    fi
    return 0
}

_profile_handler() {
    local DEVICE_ID_FILE="$HOME/.termux/device_id"
    local device_id
    if [[ -f "$DEVICE_ID_FILE" ]]; then
        device_id=$(cat "$DEVICE_ID_FILE" 2>/dev/null)
        [[ -z "$device_id" ]] && device_id="Unknown"
    else
        if command -v node >/dev/null 2>&1; then
            device_id=$(node -e "console.log(String(Math.floor(Math.random()*1000000000000)).padStart(12,'0'))" 2>/dev/null)
            printf '%s\n' "$device_id" > "$DEVICE_ID_FILE" 2>/dev/null
        else
            device_id="000000000000"
        fi
    fi

    local os_version sdk_int release_id display_id incremental tags
    local manufacturer brand model product board hardware device_name abis

    os_version=$(getprop ro.build.version.release 2>/dev/null || echo "Unknown")
    sdk_int=$(getprop ro.build.version.sdk 2>/dev/null || echo "Unknown")
    release_id=$(getprop ro.build.id 2>/dev/null || echo "Unknown")
    display_id=$(getprop ro.build.display.id 2>/dev/null || echo "Unknown")
    incremental=$(getprop ro.build.version.incremental 2>/dev/null || echo "Unknown")
    tags=$(getprop ro.build.tags 2>/dev/null || echo "Unknown")

    manufacturer=$(getprop ro.product.manufacturer 2>/dev/null || echo "Unknown")
    brand=$(getprop ro.product.brand 2>/dev/null || echo "Unknown")
    model=$(getprop ro.product.model 2>/dev/null || echo "Unknown")
    product=$(getprop ro.product.name 2>/dev/null || echo "Unknown")
    board=$(getprop ro.product.board 2>/dev/null || echo "Unknown")
    hardware=$(getprop ro.hardware 2>/dev/null || echo "Unknown")
    device_name=$(getprop ro.product.device 2>/dev/null || echo "Unknown")
    abis=$(getprop ro.product.cpu.abilist 2>/dev/null || echo "Unknown")

    local ram_kb ram_gb ram_info
    ram_kb=$(grep MemTotal /proc/meminfo 2>/dev/null | awk '{print $2}')
    if [[ -n "$ram_kb" && "$ram_kb" -gt 0 ]]; then
        ram_gb=$(echo "scale=1; $ram_kb / 1048576" | bc 2>/dev/null || echo "?")
        ram_info="${ram_gb} GB"
    else
        ram_info="Unknown"
    fi

    local storage_info
    if df -h /data >/dev/null 2>&1; then
        storage_info=$(df -h /data | awk 'NR==2 {print $2}')
        [[ -z "$storage_info" ]] && storage_info="Unknown"
    else
        storage_info="Unknown"
    fi

    local ip_info
    if command -v ifconfig >/dev/null 2>&1; then
        ip_info=$(ifconfig wlan0 2>/dev/null | grep 'inet ' | awk '{print $2}')
        [[ -z "$ip_info" ]] && ip_info=$(ifconfig 2>/dev/null | grep 'inet ' | grep -v 127 | awk '{print $2}' | head -1)
    else
        ip_info="N/A"
    fi
    [[ -z "$ip_info" ]] && ip_info="N/A"

    _print_styled_header "Profile"

    printf 'Username   : %s\n' "$USER_NAME"
    printf 'Role       : root\n'
    printf 'DeviceID   : %s\n' "$device_id"
    printf 'Version    : %s\n' "$TERMUX_CONFIG_VERSION"

    _print_styled_header "Software"
    printf 'OS Version : %s\n' "$os_version"
    printf 'SDK INT    : %s\n' "$sdk_int"
    printf 'Release    : %s\n' "$os_version"
    printf 'ID         : %s\n' "$release_id"
    printf 'Display    : %s\n' "$display_id"
    printf 'Incremental: %s\n' "$incremental"
    printf 'Tags       : %s\n' "$tags"

    _print_styled_header "Hardware"
    printf 'Manufacturer : %s\n' "$manufacturer"
    printf 'Brand        : %s\n' "$brand"
    printf 'Model        : %s\n' "$model"
    printf 'Product      : %s\n' "$product"
    printf 'Board        : %s\n' "$board"
    printf 'Hardware     : %s\n' "$hardware"
    printf 'Device       : %s\n' "$device_name"
    printf 'Supported Abis : %s\n' "$abis"
    printf 'RAM          : %s\n' "$ram_info"
    printf 'Storage      : %s\n' "$storage_info"
    printf 'IP           : %s\n' "$ip_info"
    echo
}

_spinner() {
    local msg="$1"
    local chars="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
    while true; do
        for (( i=0; i<${#chars}; i++ )); do
            printf "\r%s %s" "${chars:$i:1}" "$msg"
            sleep 0.1
        done
    done
}

_location_realtime_handler() {
    if ! command -v termux-location >/dev/null 2>&1; then
        printf 'Error: termux-location not available. Please install Termux:API.\n'
        return 1
    fi
    if ! command -v curl >/dev/null 2>&1; then
        printf 'Error: curl not available.\n'
        return 1
    fi
    if ! command -v node >/dev/null 2>&1; then
        printf 'Error: node not available.\n'
        return 1
    fi

    local max_attempts=3
    local attempt=1
    local location_json=""
    local spinner_pid

    while [[ $attempt -le $max_attempts ]]; do
        _spinner "Fetching location (attempt $attempt/$max_attempts)..." &
        spinner_pid=$!

        location_json=$(termux-location 2>/dev/null) || true

        kill $spinner_pid 2>/dev/null
        wait $spinner_pid 2>/dev/null
        printf '\r\033[K'

        if [[ -n "$location_json" ]]; then
            if echo "$location_json" | node -e "JSON.parse(require('fs').readFileSync('/dev/stdin','utf8'));" 2>/dev/null; then
                break
            fi
        fi
        ((attempt++))
        sleep 1
    done

    if [[ -z "$location_json" ]]; then
        printf 'Error: Unable to fetch location after %d attempts. Ensure GPS is enabled and permissions are granted.\n' "$max_attempts"
        return 1
    fi

    local lat lon acc
    local parsed
    parsed=$(node -e "
        const d = JSON.parse(require('fs').readFileSync('/dev/stdin','utf8'));
        if (d.error) { console.log('ERROR:' + d.error); process.exit(1); }
        console.log(d.latitude + ',' + d.longitude + ',' + (d.accuracy || 999));
    " <<< "$location_json" 2>/dev/null) || {
        printf 'Error: Invalid location data received.\n'
        return 1
    }
    IFS=',' read -r lat lon acc <<< "$parsed"
    if [[ -z "$lat" || -z "$lon" ]]; then
        printf 'Error: Incomplete location data.\n'
        return 1
    fi

    _spinner "Reverse geocoding..." &
    spinner_pid=$!
    local address_json
    address_json=$(curl -sS --max-time 10 --retry 2 --retry-delay 1 "https://nominatim.openstreetmap.org/reverse?format=json&lat=${lat}&lon=${lon}&addressdetails=1&accept-language=id" 2>/dev/null || echo '{}')
    kill $spinner_pid 2>/dev/null
    wait $spinner_pid 2>/dev/null
    printf '\r\033[K'

    local road house_number village suburb county district city state country postcode
    road=$(echo "$address_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).address||{}; process.stdout.write(a.road||'')" 2>/dev/null)
    house_number=$(echo "$address_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).address||{}; process.stdout.write(a.house_number||'')" 2>/dev/null)
    village=$(echo "$address_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).address||{}; process.stdout.write(a.village||a.suburb||'')" 2>/dev/null)
    county=$(echo "$address_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).address||{}; process.stdout.write(a.county||a.district||'')" 2>/dev/null)
    city=$(echo "$address_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).address||{}; process.stdout.write(a.city||a.town||'')" 2>/dev/null)
    state=$(echo "$address_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).address||{}; process.stdout.write(a.state||'')" 2>/dev/null)
    country=$(echo "$address_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).address||{}; process.stdout.write(a.country||'')" 2>/dev/null)
    postcode=$(echo "$address_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).address||{}; process.stdout.write(a.postcode||'')" 2>/dev/null)

    _print_styled_header "Current Location"

    printf 'Coordinates : %s, %s\n' "$lat" "$lon"
    printf 'Accuracy    : %s m\n' "$acc"
    [[ -n "$road" ]] && printf 'Street      : %s %s\n' "$house_number" "$road"
    [[ -n "$village" ]] && printf 'Village     : %s\n' "$village"
    [[ -n "$county" ]] && printf 'District    : %s\n' "$county"
    [[ -n "$city" ]] && printf 'City        : %s\n' "$city"
    [[ -n "$state" ]] && printf 'Province    : %s\n' "$state"
    [[ -n "$country" ]] && printf 'Country     : %s\n' "$country"
    [[ -n "$postcode" ]] && printf 'Postal Code : %s\n' "$postcode"
    echo
}

_schedule_display_handler() {
    if [[ ! -f "$SCHEDULE_FILE" ]]; then
        printf 'Schedule not available yet. It will be generated automatically.\n'
        return 1
    fi

    local schedule_json
    schedule_json=$(cat "$SCHEDULE_FILE" 2>/dev/null)
    if [[ -z "$schedule_json" ]]; then
        printf 'Error: Unable to read schedule data.\n'
        return 1
    fi

    _print_styled_header "Prayer Times Schedule"

    local date_sched times fajr dhuhr asr maghrib isha
    date_sched=$(echo "$schedule_json" | node -e "process.stdout.write(JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).date)" 2>/dev/null)
    times=$(echo "$schedule_json" | node -e "const t=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).times; process.stdout.write(t.fajr+','+t.dhuhr+','+t.asr+','+t.maghrib+','+t.isha)" 2>/dev/null)
    IFS=',' read -r fajr dhuhr asr maghrib isha <<< "$times"

    printf 'Date        : %s\n' "$date_sched"
    printf 'Fajr        : %s\n' "$fajr"
    printf 'Dhuhr       : %s\n' "$dhuhr"
    printf 'Asr         : %s\n' "$asr"
    printf 'Maghrib     : %s\n' "$maghrib"
    printf 'Isha        : %s\n' "$isha"

    local road house_number village county city
    road=$(echo "$schedule_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).location.address||{}; process.stdout.write(a.road||'')" 2>/dev/null)
    house_number=$(echo "$schedule_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).location.address||{}; process.stdout.write(a.house_number||'')" 2>/dev/null)
    village=$(echo "$schedule_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).location.address||{}; process.stdout.write(a.village||a.suburb||'')" 2>/dev/null)
    county=$(echo "$schedule_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).location.address||{}; process.stdout.write(a.county||a.district||'')" 2>/dev/null)
    city=$(echo "$schedule_json" | node -e "const a=JSON.parse(require('fs').readFileSync('/dev/stdin','utf8')).location.address||{}; process.stdout.write(a.city||a.town||'')" 2>/dev/null)

    printf '\nLocation used for schedule:\n'
    [[ -n "$road" ]] && printf 'Street      : %s %s\n' "$house_number" "$road"
    [[ -n "$village" ]] && printf 'Village     : %s\n' "$village"
    [[ -n "$county" ]] && printf 'District    : %s\n' "$county"
    [[ -n "$city" ]] && printf 'City        : %s\n' "$city"
    echo
}