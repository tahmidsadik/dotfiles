if status is-interactive
    # Commands to run in interactive sessions can go here
end

# setup volta
set -gx VOLTA_HOME $HOME/.volta

set -x BUN_INSTALL $HOME/.bun

# add binaries to path
set -x PATH /opt/homebrew/bin \
    /usr/local/bin \
    $BUN_INSTALL/bin \
    $HOME/.volta/bin \
    /Users/tahmid/go/bin \
    $HOME/.jb-tools/bin \
    $HOME/roc \
    /Users/tahmid/Library/Python/3.10/bin \
    $HOME/zig \
    $PATH


# set -gx PATH "/Users/tahmid/Library/Caches/fnm_multishells/60678_1673001795435/bin" $PATH;
# set -gx FNM_LOGLEVEL "info";
# set -gx FNM_MULTISHELL_PATH "/Users/tahmid/Library/Caches/fnm_multishells/60678_1673001795435";
# set -gx FNM_VERSION_FILE_STRATEGY "local";
# set -gx FNM_DIR "/Users/tahmid/Library/Application Support/fnm";
# set -gx FNM_ARCH "arm64";
# set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";
set -gx TERM "alacritty";

set -gx PATH "$HOME/.cargo/bin" $PATH;
zoxide init fish | source
source ~/.config/fish/abbreviations/abbreviations.fish

starship init fish | source
