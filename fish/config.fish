if status is-interactive
    # Commands to run in interactive sessions can go here
end

# setup volta
set -gx VOLTA_HOME $HOME/.volta

# add binaries to path
set -x PATH /usr/local/bin \
    $HOME/.volta/bin \
    /usr/local/go/bin \
    $HOME/.jb-tools/bin \
    $HOME/zig \
		$HOME/.local/bin \
		$GOPATH/bin \
    $PATH


# set -gx PATH "/Users/tahmid/Library/Caches/fnm_multishells/60678_1673001795435/bin" $PATH;
# set -gx FNM_LOGLEVEL "info";
# set -gx FNM_MULTISHELL_PATH "/Users/tahmid/Library/Caches/fnm_multishells/60678_1673001795435";
# set -gx FNM_VERSION_FILE_STRATEGY "local";
# set -gx FNM_DIR "/Users/tahmid/Library/Application Support/fnm";
# set -gx FNM_ARCH "arm64";
# set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist";

set -gx PATH "$HOME/.cargo/bin" $PATH;
zoxide init fish | source
source ~/.config/fish/abbreviations/functions/git_main_branch.fish
source ~/.config/fish/abbreviations/abbreviations.fish

starship init fish | source
