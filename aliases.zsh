# ALIASES

# Android emulator
alias emulator="$HOME/Library/Android/sdk/emulator/emulator"

# PHP CLI
alias composer='/Applications/MAMP/bin/php/composer'

# TIDDLY WIKI
alias wiki-start="cd $HOME/Sites/TiddlyWiki && tiddlywiki GxWiki --listen"
alias wiki-stop="kill -9 $(lsof -ti tcp:8080)" # Tiddly node server don't have any method to stop the process
alias wiki-build="cd $HOME/Sites/TiddlyWiki && tiddlywiki GxWiki --rendertiddler $:/core/save/all index.html text/plain"

# HELPERS
