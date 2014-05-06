export PATH=/usr/local/bin:/usr/bin:$HOME/bin:/usr/local/mysql/bin:~/groupon-bin:/usr/local/share/npm/bin:/usr/local/heroku/bin:$PATH:$HOME/.rvm/bin

# Add bash completion so that Git commands can auto complete
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

export RUBY_HEAP_MIN_SLOTS=500000 
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000
export PGDATA=/usr/local/var/postgres
export BUNDLER_EDITOR=mvim
export PROMPT_COMMAND="history -a; ~/scripts/remove_dupes_in_history.rb; $PROMPT_COMMAND"

function _update_ps1() {
   export PS1="$(~/powerline-shell.py $?)"
}

export PROMPT_COMMAND="_update_ps1"

source "$HOME/.aliases"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
