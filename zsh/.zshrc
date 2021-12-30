OH_MY_ZSH_REPO="${HOME}/git/ohmyzsh"

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
    plugins=( git vi-mode rust docker docker-compose)
    . ${ZSH}/oh-my-zsh.sh
    # if vi-mode plugin is enabled, then let's be explicit
    # about the mode we're currently on the prompt for the
    # themes that don't do that.
    #
    # (thanks jcarlosv for the help on this one!)
    for p in $plugins[@] ; do
        if [[ "vi-modeX" == "${p}X" ]]; then
            # make vi mode transition faster (hundredths of a second)
            export KEYTIMEOUT=1
            # re-define MODE_INDICATOR variable
            export MODE_INDICATOR="<"
            # make sure RPS1 shows vi-mode
            if [[ ! ${RPS1} == *'$(vi_mode_prompt_info)'* ]] ; then
                export RPS1="\$(vi_mode_prompt_info) ${RPS1}"
            fi
        fi
    done
fi

alias luamake=/home/mesiment/git/lua-language-server/3rd/luamake/luamake
