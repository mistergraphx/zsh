# https://santacloud.dev/posts/optimizing-zsh-startup-performance/#initial-zsh-config

# Profiling start
if [ $PROFILING_MODE -ne 0 ]; then
    zmodload zsh/zprof
    zsh_start_time=$(python3 -c 'import time; print(int(time.time() * 1000))')
fi

# compile zsh file, and source them - first run is slower
zsource() {
  local file=$1
  local zwc="${file}.zwc"
  if [[ -f "$file" && (! -f "$zwc" || "$file" -nt "$file") ]]; then
    zcompile "$file"
  fi
  source "$file"
}

# general settings
export ZSH=$(readlink -f $DOT_FILES_PATH/zsh)
export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

# Env (paths, etc …)
zsource $ZSH/env.zsh



# Keyboard shortcuts or overides
# https://www.justus.pw/posts/2023-03-10-useful-zsh-shortcuts.html
# use `bindkey -e` to restore temporaly Emacs keybindings



# Theme
zsource $ZSH/themes/minimal-falcon.zsh-theme

# Plugins

autoload -Uz compinit
ZSH_COMPDUMP="${ZSH}/.zcompdump"
compinit -C -d "$ZSH_COMPDUMP"

# Profile (alias, etc)
zsource $ZSH/aliases.zsh

# Profiling end
if [ $PROFILING_MODE -ne 0 ]; then
  zprof
  zsh_end_time=$(python3 -c 'import time; print(int(time.time() * 1000))')
  echo "Shell init time: $((zsh_end_time - zsh_start_time)) ms"
fi