# Brew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH
# Macport
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# MAMP
PHP_VERSION='8.3.28'
export PATH="/Applications/MAMP/Library/bin:$PATH"
export PATH="/Applications/MAMP/bin/php/php$PHP_VERSION/bin:$PATH"

# LOCALHOST SCRIPTS
export PATH="$HOME/Sites/bin:$PATH"
# Setup fzf
# ---------
if [[ ! "$PATH" == *$ZSH/plugins/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$ZSH/plugins/fzf/bin"
fi
