echo "Welcome $USER. Happy hacking and don't forget to stay hydrated"

# Path for brew
test -d /usr/local/bin && export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# Load git completions
git_completion_script=/usr/local/etc/bash_completion.d/git-completion.bash
test -s $git_completion_script && source $git_completion_script

# PS1 is the variable for the prompt you see everytime you hit enter
PROMPT_COMMAND=$PROMPT_COMMAND'; PS1="${c_path}\W${c_reset}$(git_prompt) :> "'

# Use the superior editing experience as a default
export EDITOR=emacs

# A more colorful prompt
# \[\e[0m\] resets the color to default color
c_reset='\[\e[0m\]'
# \e[0;31m\ sets the color to red
c_path='\[\e[0;31m\]'
# \e[0;32m\ sets the color to green
c_git_clean='\[\e[0;32m\]'
# \e[0;31m\ sets the color to red
c_git_dirty='\[\e[0;31m\]'

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

# better ls
export LSCOLORS=ExGxFxdxCxDxDxaccxaeex
alias ls='ls -Gh'
alias ll='ls -al'

export GREP_OPTIONS='--color=always'

# useful system aliases
alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# erlang/elixir
export ERL_AFLAGS="-kernel shell_history enabled"
