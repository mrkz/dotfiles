OH_MY_ZSH_REPO="${HOME}/git/oh-my-zsh"

# load global shell setup
if [ -d ${HOME}/.shrc/ ]; then
  for i in ${HOME}/.shrc/* ; do
    . $i
  done
  unset i
fi

ZSH_THEME=terminalparty

if [ -d ${OH_MY_ZSH_REPO} ]; then
    export ZSH=${OH_MY_ZSH_REPO}
    plugins=( git )
    . ${ZSH}/oh-my-zsh.sh
fi

