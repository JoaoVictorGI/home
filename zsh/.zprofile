PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games
export PATH HOME TERM
export PATH="$HOME/.local/bin:$HOME/.local/go/bin:$HOME/.cargo/bin:$HOME/.npm-global/bin:$HOME/.config/emacs/bin:$HOME/.cache/.bun/bin:$HOME/.config/composer/vendor/bin:$PATH"

export NPM_CONFIG_PREFIX=~/.npm-global

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
#export XDG_CURRENT_DESKTOP=wlroots
export XDG_RUNTIME_DIR="/tmp/1000"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
export XDG_DATA_DIRS="/home/joao/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"
export XDG_DATA_DIRS="/usr/share/:/usr/local/share/:$XDG_DATA_DIRS"

export ENV="$HOME/.kshrc"
export HISTSIZE=$((2 << 15))
export HISTFILE="$XDG_CACHE_HOME/${SHELL##*/}_history"
export HISTFILESIZE=$HISTSIZE

export EDITOR=nvim
#export BROWSER=ungoogled-chromium
#export TERMINAL=foot
export CFLAGS="-O3 -pipe -march=native -mtune=native"
export CXXFLAGS="$CFLAGS"
export MAKEFLAGS="-j$(nproc)"

export CHROME_FLAGS="--ozone-platform=wayland"
export GOPROXY=direct
export GOSUMDB=off
export GOTOOLCHAIN=local
export XZ_OPT="-T0"


mkdir -pm 0700 "$XDG_RUNTIME_DIR"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

ssh_pid=$(pidof ssh-agent)

# If the agent is not running, start it, and save the environment to a file
if [ "$ssh_pid" = "" ]; then
	ssh_env="$(ssh-agent -s)"
	echo "$ssh_env" | head -n 2 | tee ~/.ssh_agent_env >/dev/null
fi

# Load the environment from the file
if [ -f ~/.ssh_agent_env ]; then
	eval "$(cat ~/.ssh_agent_env)"
fi

test -r '/home/joao/.opam/opam-init/init.sh' && . '/home/joao/.opam/opam-init/init.sh' >/dev/null 2>/dev/null || true
eval $(opam env)

[ -f "/home/joao/.ghcup/env" ] && . "/home/joao/.ghcup/env" # ghcup-env

