# zsh/themes/minimal-falcon.zsh-theme
autoload -Uz colors && colors

# LS colors and such (8-bit color)
export CLICOLOR=1
export LSCOLORS=dxfxfxdxfxdedeacacad

# fzf
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color='dark\
,fg:#b4b4b9\
,bg:#000000\
,hl:#ffc552\
,fg+:#f8f8ff\
,bg+:#36363a\
,hl+:#ffc552\
,query:#f8f8ff\
,gutter:#020221\
,prompt:#ffc552\
,header:#ffd392\
,info:#bfdaff\
,pointer:#ffe8c8\
,marker:#ff3600\
,spinner:#bfdaff\
,border:#36363a'\
"

# Color variables for prompt
COLOR_DIR=245
COLOR_GIT=173
COLOR_ARROW=180

# prompt
function git_prompt() {
  git rev-parse --is-inside-work-tree &>/dev/null || return
  ref=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always)
  status_icon=""
  if [[ -n $(git status -s) ]]; then
    status_icon="*"
    git_color=173  # orange for modified
  else
    git_color=2    # green for clean
  fi
  echo "%F{$git_color}($ref)$status_icon%f"
}
setopt PROMPT_SUBST
PROMPT="%F{$COLOR_DIR}%1~%f\$(git_prompt) %F{$COLOR_ARROW}❯%f "