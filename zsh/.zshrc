alias du="du -h"
alias da="du -bhd 1"
alias ls="ls -AF --color"
alias la="ls -lh"
alias e="$EDITOR"
alias grep="rg"
alias rm="rm -v"
alias rf="rm -rf"
alias lg="lazygit"
alias ng="nvim -c ':Neogit'"
alias goanime="Goanime"
alias idea="flatpak run com.jetbrains.IntelliJ-IDEA-Ultimate"
alias webstorm="flatpak run com.jetbrains.WebStorm"
alias emacs='/usr/local/bin/emacsclient -c -a ""'

export DISPLAY=:0.0
export LIBGL_ALWAYS_INDIRECT=1
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#e4e4ef,fg+:#f4f4ff,bg:#181818,bg+:#282828
  --color=hl:#f43841,hl+:#ff4f58,info:#96a6c8,marker:#73c936
  --color=prompt:#ffdd33,spinner:#f43841,pointer:#f43841,header:#c6a0f6
  --color=border:#282828,label:#95a99f,query:#f4f4ff
  --border="rounded" --border-label="" --preview-window="border-rounded" '


if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
	exec tmux new-session -A -s ${USER} >/dev/null 2>&1
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Created by newuser for 5.9
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
eval "$(/usr/bin/mise activate zsh)"

autoload -U compinit
compinit
# source <(COMPLETE=zsh jj)
