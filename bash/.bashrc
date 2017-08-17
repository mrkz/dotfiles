# Use global profile when available
if [ -f /usr/share/defaults/etc/profile ]; then
	. /usr/share/defaults/etc/profile
fi
# allow admin overrides
if [ -f /etc/profile ]; then
	. /etc/profile
fi

# user setup

# load global shell setup
if [ -d ${HOME}/.shrc/ ]; then
  for i in ${HOME}/.shrc/* ; do
    . $i
  done
  unset i
fi

# setup git prompt show
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWDIRTYSTATE=1

# setup prompt
export PS1="\[\033[38;5;255m\][\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;10m\]\u\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;255m\]@\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;27m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;255m\]->\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;255m\]\W\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] $(__git_ps1 " (%s)") ] \[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"



