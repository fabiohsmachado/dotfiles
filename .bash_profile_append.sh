###################################
##### Personal Configurations #####
###################################

#### Python ####
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PATH:$PYENV_ROOT/bin

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

#### PATH ####
export PATH=$PATH:$HOME/.config/composer/vendor/bin
export PATH=$PATH:$HOME/go/bin
