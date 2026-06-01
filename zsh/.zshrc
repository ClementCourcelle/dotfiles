autoload -U add-zsh-hook
source <(docker completion zsh)

setopt append_history        # parallel zsh share new entries from history
setopt bang_hist             # perform textual history expansion
setopt hist_fcntl_lock       # lock on history file done with fctnl syscall
setopt hist_find_no_dups     # no duplicates (even not contiguous) when searching for history entries 
setopt hist_ignore_all_dups  # remove older similar entry when a new one is added to the history file
setopt hist_ignore_space     # ignore command line which start with space in the history file
setopt hist_reduce_blanks    # remove useless spaces in the history file
#setopt share_history         # import new commands from the history file

# zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
# zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=**'
zstyle ':completion:*:rm:*' ignore-line yes # avoid including the same file several times
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes


setopt auto_pushd            # cd - (stack)
setopt pushd_ignore_dups     # don't push multiple copies of the same directory onto the dir stack.
setopt pushd_silent          # do not print the directory stack after pushd or popd.
setopt pushd_to_home         # have pushd with no arguments act like `pushd $HOME'.
setopt prompt_subst          # enable some expansions in prompt
setopt extended_glob         # treat the `#', `~' and `^' characters as part of patterns
# setopt always_to_end         # move the cursor to the end of the word after a completion
setopt auto_list             # list choices on  an ambiguous completion
setopt globdots


# ENV VARIABLES
export PATH="$PATH:$HOME/.local/bin:/opt/nvim-linux-x86_64/bin"
export LD_LIBRARY_PATH="/usr/lib:/usr/local/lib"

[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh

# HISTORY AND COMPLETION
HISTFILE=~/.config/zsh/zsh_history
HISTSIZE=10000
SAVEHIST=10000



# KEYBINDINGS
declare -A keycodes
keycodes[shift_up]='^[[1;2A'
keycodes[shift_dn]='^[[1;2B'
keycodes[ctrl_r]='^[[1;5C'
keycodes[ctrl_l]='^[[1;5D'
keycodes[alt_1]='^[&'


bindkey $keycodes[ctrl_r] forward-word
bindkey $keycodes[ctrl_l] backward-word
bindkey ${keycodes[shift_up]}  history-beginning-search-backward
bindkey ${keycodes[shift_dn]}  history-beginning-search-forward
# bindkey -s '^F' ' ~/.local/scripts/tmux-sessionizer\n'

source $HOME/.config/zsh/zsh_aliases
[ -f ~/.config/zsh/local_aliases ] && source ~/.config/zsh/local_aliases

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# START IN MAIN TMUX SESSION
if [[ -z $TMUX ]]; then
  tmux new-session -A -s main -c $HOME -e SESS_ROOT=$HOME
fi

# PYTHON VENV
if [[ -d $SESS_ROOT/.venv/"$(basename $SESS_ROOT)" ]]; then
  source $SESS_ROOT/.venv/"$(basename $SESS_ROOT)"/bin/activate
fi

# ROS
if [[ ! -n $SSH_CLIENT  ]]; then
  if [[ -f ./install/setup.zsh || ( -n $TMUX && -f $SESS_ROOT/install/setup.zsh ) ]]; then
    setopt local_options no_monitor
    local tmp_env="/tmp/ros_env_$$"
    local tmp_flag="/tmp/ros_ready_$$"
    async_sros $tmp_env $tmp_flag

    _ros_env_watcher() {
      if [[ -f "$tmp_flag" ]]; then
        source "$tmp_env"
        # not env variables so can't be done in background
        source /opt/ros/$ROS_DISTRO/share/ros2cli/environment/ros2-argcomplete.zsh
        export ROS_SETUP_DONE=1
        rm -rf $tmp_env $tmp_flag
        add-zsh-hook -d preexec _ros_env_watcher
      fi
    }
    add-zsh-hook preexec _ros_env_watcher
  fi
fi

# PROMPT
fpath+=($HOME/.config/zsh/pure)
autoload -U promptinit; promptinit

PURE_CMD_MAX_EXEC_TIME=60
PURE_PROMPT_SYMBOL=$

prompt pure

