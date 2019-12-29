###################################
##### Personal Configurations #####
###################################

#### Python ####
export VIRTUALENVWRAPPER_PYTHON=`which python3`
export VIRTUAL_ENV_DISABLE_PROMPT=1
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PYENV_ROOT=$HOME/.pyenv

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

#### PATH ####
export PATH=$PATH:$PYENV_ROOT/bin
export PATH=$PATH:$HOME/.config/composer/vendor/bin
export PATH=$PATH:$HOME/go/bin
