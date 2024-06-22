''
#make login sessions (like tmux) source my bashrc
#https://unix.stackexchange.com/questions/320465/new-tmux-sessions-do-not-source-bashrc-file
# write content below into ~/.profile, or ~/.bash_profile
# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi
''
