### Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="/opt/homebrew/bin:$PATH"

### History
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

### Autocompletions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

### Prompt
git_branch_prompt_partial() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        return 0
    fi

    git_branch=$(git symbolic-ref --short HEAD 2> /dev/null)

    if ! git diff --quiet 2>/dev/null >&2; then
        git_color="red"
    elif [[ $(git ls-files --other --directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]]; then
        git_color="cyan"
    else
        git_color="green"
    fi

    echo " [%F{$git_color}$git_branch%f] "
}

setopt PROMPT_SUBST

PROMPT='%F{magenta}%1~%f$(git_branch_prompt_partial)%F{cyan}|>%f '

### asdf
. "$HOME/.asdf/asdf.sh"
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

### Aliases
alias ls='ls -Gh'
alias ll='ls -al'
alias gcmb="git branch --merged | grep -Ev '(^\*|master)' | xargs git branch -d"

### Backyard - Napurabad
get_govee_sensor_state() {
  echo "Fetching Govee Sensor Data for $1"
  curl -sS --location 'https://openapi.api.govee.com/router/api/v1/device/state' -H 'Govee-API-Key: $GOVEE_API_KEY' -H 'Content-Type: application/json' --data "{\"requestId\": \"uuid\", \"payload\": {\"sku\": \"H5100\", \"device\": \"$1\"}}" | jq .payload.capabilities
}
alias yardtemp='get_govee_sensor_state "2C:2B:34:30:38:C2:20:4E"'
alias cooptemp='get_govee_sensor_state "2F:07:34:30:38:D4:88:1E"'
alias shedtemp='get_govee_sensor_state "35:52:46:03:06:D1:AA:2D"'
alias broodtemp='get_govee_sensor_state "4A:43:86:01:06:D1:A4:7F"'

### Music
get_bird_sounds() {
  echo "fetching sound $1 from cornell ornithology lab"
  curl -o ~/birdsongs/$2.mp3 https://cdn.download.ams.birds.cornell.edu/api/v2/asset/$1/mp3
}