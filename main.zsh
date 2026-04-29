# https://santacloud.dev/posts/optimizing-zsh-startup-performance/#initial-zsh-config
# https://www.youtube.com/watch?v=bTLYiNvRIVI

# Profiling start
if [ $PROFILING_MODE -ne 0 ]; then
  # setopt SOURCE_TRACE
  zmodload zsh/zprof
  zmodload zsh/datetime
  zsh_start_time=$EPOCHREALTIME
fi

# If ZSH is not defined, use the current script's directory.
[[ -n "$ZSH" ]] || export ZSH="${${(%):-%x}:a:h}"

# Set ZSH_CACHE_DIR to the path where cache files should be created
# or else we will use the default cache/
[[ -n "$ZSH_CACHE_DIR" ]] || ZSH_CACHE_DIR="$ZSH/.cache"

# Make sure $ZSH_CACHE_DIR is writable, otherwise use a directory in $HOME
# if [[ ! -w "$ZSH_CACHE_DIR" ]]; then
#   ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
# fi
# echo $ZSH_CACHE_DIR
# Create cache dir and add to $fpath
mkdir -p "$ZSH_CACHE_DIR"
(( ${fpath[(Ie)$ZSH_CACHE_DIR]} )) || fpath=("$ZSH_CACHE_DIR" $fpath)

# Env (paths, etc …)
source "${ZSH}/env.zsh"

# general settings
# History
# https://catonmat.net/the-definitive-guide-to-bash-command-line-history
export HISTFILE="$ZSH_CACHE_DIR/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
export HISTIGNORE="&:[ ]*:exit" # ignore duplicate commands, commands that begin with a space, and the 'exit' command
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups     # ignore duplicated commands history list
setopt hist_find_no_dups
setopt hist_ignore_space        # ignore commands that start with space
setopt hist_verify              # show previous command from history before executing
setopt share_history            # share command history data

# Directories
# https://zsh.sourceforge.io/Intro/intro_6.html
DIRSTACKSIZE=8
setopt cd_silent                # do not print path on cd (already print by Agnoster theme)
setopt auto_cd                  # got to path without using cd
setopt auto_pushd               # Add to directory stack witout using pushd command
setopt pushd_silent             # keeps the shell from printing the directory stack each time we do a cd
setopt pushd_ignore_dups        # ignore similar paths
setopt pushdminus               # swapped the meaning of cd +1 and cd -1

# Load prompt utilities/
# > prompt -a                   # list all available prompts
# https://github.com/rothgar/mastering-zsh/blob/master/docs/config/prompt.md
autoload -Uz promptinit
promptinit
setopt promptsubst               # allow prompt substitution like $(build_prompt) in Agnoster, if it's not defined in the theme

# Keyboard shortcuts or overides
# https://www.justus.pw/posts/2023-03-10-useful-zsh-shortcuts.html
# use `bindkey -e` to restore temporaly Emacs keybindings

# Theme
# Minimal
# source "${ZSH}/themes/minimal.zsh-theme"

# Agnoster (from github original repo !oh-my-zsh)
# ~~fix: double quote prompt break on MacOS~~
# ~~fix: iterm don't render powerline unicode signs (force LC_LOCAL)~~
source "${ZSH}/themes/agnoster-zsh-theme/agnoster.zsh-theme"

# https://github.com/ZYSzys/zys-zsh-theme
# 🌈 A ZSH theme similar with agnoster-zsh-theme.
# source "${ZSH}/themes/zys-zsh-theme/zys.zsh-theme"

# Spaceship
# https://spaceship-prompt.sh/config/intro/#Configure-your-prompt
# source $ZSH/themes/spaceship-prompt/spaceship.zsh-theme

# Typewritten
# fpath+=$ZSH/themes/typewritten
# autoload -U promptinit; promptinit
# prompt typewritten

# Plugins
source <(fzf --zsh)
source "${ZSH}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${ZSH}/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
# export NVM_AUTO_USE=false    # change or install node version using .nvmrc files from projects paths
# export NVM_COMPLETION=true
# export NVM_LAZY_LOAD=true
# source "${ZSH}/plugins/zsh-nvm/zsh-nvm.plugin.zsh"

# Autoload user functions
if [[ -d "${ZSH}/functions" ]]; then
  autoload -Uz ${ZSH}/functions/*(N:t)
fi

# Prepend plugin paths to fpath so that custom and plugin completions take precedence,
# then append the existing $fpath and user completions at the end.
fpath=(
  "${ZSH}/plugins/zsh-completions/src"
  "${ZSH}/plugins/git-completions"
  $fpath
  "${ZSH}/functions"
)

# Completion
# https://zsh.sourceforge.io/Doc/Release/Completion-System.html
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#b4b4b9"
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_COMPDUMP="${ZSH_CACHE_DIR}/.zcompdump"

# setopt menu_complete  # Automatically highlight first element of completion menu
setopt list_packed    # The completion menu takes less space

# Highlights menu selection
zstyle ':completion:*' menu select
# Sort by modification date for every completer
zstyle ':completion:*' file-sort modification
# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# git completion
zstyle ':completion:*:*:git:*' script $ZSH/plugins/git-completions/git-completion.bash

autoload -Uz compinit

if [[ ! -f $ZSH_COMPDUMP || -s $ZSH_COMPDUMP(#qN.mh+24) ]];then
  compinit -d $ZSH_COMPDUMP
  zcompile $ZSH_COMPDUMP
else
  compinit -C
fi

# iTerm shell integration
if [[ "$TERM_PROGRAM" = "iTerm.app" ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# Profile (alias, etc)
source "${ZSH}/aliases.zsh"

# Profiling end
if [ $PROFILING_MODE -ne 0 ]; then
  zprof
  zsh_end_time=$EPOCHREALTIME
  echo "Shell init time: $(printf "%.0f" $(( (zsh_end_time - zsh_start_time) * 1000 ))) ms"
fi