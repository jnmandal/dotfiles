echo "Welcome $USER. Happy hacking and don't forget to stay hydrated"

# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# Use the superior editing experience as a default
export EDITOR=emacs

# Export OS name for profile determination (mac/linux)
export UNAME=$(uname)

# Colors
export COLOR_NC='\e[0m' # No Color
export COLOR_WHITE='\e[1;37m'
export COLOR_BLACK='\e[0;30m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_GRAY='\e[0;30m'
export COLOR_LIGHT_GRAY='\e[0;37m'

# Color aliases for styling prompt
c_reset=$COLOR_NC
c_path=$COLOR_LIGHT_PURPLE
c_symbol=$COLOR_LIGHT_CYAN
c_git_clean=$COLOR_GREEN
c_git_dirty=$COLOR_RED

# determines if the git branch you are on is clean or dirty
git_prompt ()
{
  # Is this a git directory?
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    return 0
  fi
  # Grab working branch name
  git_branch=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
  # Clean or dirty branch
  if git diff --quiet 2>/dev/null >&2; then
    git_color="${c_git_clean}"
  else
    git_color=${c_git_dirty}
  fi
  echo " [$git_color$git_branch${c_reset}]"
}

# Useful prompt
symbol='|>'
define_prompt ()
{
  PS1="\[\e]0;\u@\h: \w\a\] ${c_path}\W${c_reset}$(git_prompt) ${c_symbol}${symbol}${c_reset} "
}

case $TERM_PROGRAM in
  "Apple_Terminal") PROMPT_COMMAND="${PROMPT_COMMAND}; define_prompt";;
  *) PROMPT_COMMAND="${PROMPT_COMMAND}define_prompt"
esac

# better ls
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex
alias ls='ls -Gh'
alias ll='ls -al'

export GREP_OPTIONS='--color=always'

# Useful system aliases
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# erlang/elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# Useful developer aliases
alias aconfig="atom ~/.atom"
