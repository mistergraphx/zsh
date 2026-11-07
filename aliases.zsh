# ALIASES

# ask user validation before
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Android emulator
alias emulator="$HOME/Library/Android/sdk/emulator/emulator"

# PHP CLI
alias composer='/Applications/MAMP/bin/php/composer'

# TIDDLY WIKI
# launch node first
alias wiki-start="cd $HOME/Sites/TiddlyWiki ; nvm_load ; node -v ; tiddlywiki GxWiki --listen"
alias wiki-stop="kill_port 8080" # Tiddly node server don't have any method to stop the process
alias wiki-build="cd $HOME/Sites/TiddlyWiki ; nvm_load ; node -v ; tiddlywiki GxWiki --rendertiddler $:/core/save/all index.html text/plain"

# GIT
# delete local branches already merged into origin's default branch (master/main)
alias git-clean-merged='git fetch --prune && default=$(git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@") && git branch --merged "origin/$default" | grep -vE "^\*|^\s*${default}\$" | xargs git branch -d'

# HELPERS
