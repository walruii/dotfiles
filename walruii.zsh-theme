# Optimized Nerd Font Symbols
ICON_GIT_BRANCH=" "
ICON_GIT_DIRTY="󱓎 "
ICON_GIT_CLEAN="󰄬 "
ICON_DIR_LOCKED="󰌾 "
ICON_DIR_OPEN=" "
ICON_JOB="⚙ "
ICON_TIMER="󱎫 "

# Define return status indicator
local return_status="%{$fg[red]%}%(?..⏎ )%{$reset_color%}"

# --- NEW/OLD FUNCTION: Git Time Since Commit ---
function git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
            now=`date +%s`
            seconds=$((now-last_commit))
            MINUTES=$((seconds / 60))
            HOURS=$((seconds / 3600))
            DAYS=$((seconds / 86400))
            
            # Set Color based on age
            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$MINUTES" -gt 30 ]; then COLOR="%{$fg[red]%}"
                elif [ "$MINUTES" -gt 10 ]; then COLOR="%{$fg[yellow]%}"
                else COLOR="%{$fg[green]%}"; fi
            else
                COLOR="%{$fg[cyan]%}"
            fi

            if [ "$HOURS" -gt 24 ]; then echo "[$COLOR${DAYS}d$((HOURS%24))h%{$reset_color%}]"
            elif [ "$MINUTES" -gt 60 ]; then echo "[$COLOR${HOURS}h$((MINUTES%60))m%{$reset_color%}]"
            else echo "[$COLOR${MINUTES}m%{$reset_color%}]"; fi
        else
            echo "[%{$fg[cyan]%}~%{$reset_color%}]"
        fi
    fi
}

# 1. Device Context & SSH Identity
function prompt_context() {
  local user_host="%m"
  if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
    echo "%{$fg_bold[cyan]%}%U${user_host}%u%{$reset_color%} "
  else
    echo "%{$fg[yellow]%}${user_host}%{$reset_color%} "
  fi
}

# 2. Directory Deep-End (Read-only check)
function prompt_dir() {
  local dir_icon=$ICON_DIR_OPEN
  [[ ! -w . ]] && dir_icon=$ICON_DIR_LOCKED
  echo "%{$fg[red]%}${dir_icon} %(5~|%-1~/…/%3~|%4~)%{$reset_color%}"
}

# 3. Background Jobs Indicator
function prompt_jobs() {
  echo "%(1j.%{$fg[cyan]%}${ICON_JOB}%j .)"
}

# 4. Sudo/Root Visual Feedback
function prompt_char() {
  if [[ $UID -eq 0 ]]; then
    echo "%{$fg_bold[yellow]%}󱐋 ROOT:%{$reset_color%}"
  else
    echo "%{$fg[red]%}悪流威:%{$reset_color%}"
  fi
}

# 5. Command Duration Logic
zmodload zsh/datetime
function preexec() {
  timer=${timer:-$EPOCHREALTIME}
}
function precmd() {
  if [ $timer ]; then
    timer_show=$(( EPOCHREALTIME - timer ))
    if (( $timer_show > 3 )); then 
      printf -v timer_format "%.2fs" $timer_show
      RPROMPT_DURATION="%{$fg[magenta]%}${ICON_TIMER}${timer_format}%{$reset_color%} "
    else
      RPROMPT_DURATION=""
    fi
    unset timer
  fi
}

# Git Formatting
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}on %{$fg[magenta]%}${ICON_GIT_BRANCH}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ${ICON_GIT_DIRTY}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ${ICON_GIT_CLEAN}"

# Layout Construction
PROMPT='$(prompt_context)$(prompt_dir) $(prompt_jobs)$(git_prompt_info)
$(prompt_char) '

# ADDED $(git_time_since_commit) back in
RPROMPT='${return_status}${RPROMPT_DURATION}$(git_time_since_commit)$(git_prompt_status)%{$reset_color%}'
