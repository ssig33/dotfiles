zstyle ':zim:zmodule' use 'degit'
export ZIM_HOME="${HOME}/.cache/zim"
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  echo "Installing zim..."
  mkdir -p ${ZIM_HOME}
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

autoload -Uz compinit && compinit

alias ls='ls --color=auto'

export EDITOR='code --wait'
export LANG='ja_JP.UTF-8'

