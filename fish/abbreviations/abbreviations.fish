#vim
abbr vim nvim

#shell
abbr .sh 'source ~/.config/fish/config.fish'
abbr esh 'nvim ~/.config/'
abbr k 'exa -al'

#docker-compose
abbr dc docker-compose

# git
abbr g git

abbr ga 'git add'
abbr gaa 'git add --all'
abbr gapa 'git add --patch'
abbr gau 'git add --update'
abbr gav 'git add --verbose'
abbr gap 'git apply'
abbr gapt 'git apply --3way'

abbr gb 'git branch'
abbr gba 'git branch -a'
abbr gbd 'git branch -d'
abbr gbda 'git branch --no-color --merged | command grep -vE "^(\+|\*|\s*((git_main_branch)|development|develop|devel|dev)\s*$)" | command xargs -n 1 git branch -d'
abbr gbD 'git branch -D'
abbr gbl 'git blame -b -w'
abbr gbnm 'git branch --no-merged'
abbr gbr 'git branch --remote'
abbr gbs 'git bisect'
abbr gbsb 'git bisect bad'
abbr gbsg 'git bisect good'
abbr gbsr 'git bisect reset'
abbr gbss 'git bisect start'

abbr gc 'git commit -v'
abbr gc! 'git commit -v --amend'
abbr gcn! 'git commit -v --no-edit --amend'
abbr gca 'git commit -v -a'
abbr gca! 'git commit -v -a --amend'
abbr gcan! 'git commit -v -a --no-edit --amend'
abbr gcans! 'git commit -v -a -s --no-edit --amend'
abbr gcam 'git commit -a -m'
abbr gcsm 'git commit -s -m'
abbr gcb 'git checkout -b'
abbr gcf 'git config --list'
abbr gcl 'git clone --recurse-submodules'
abbr gclean 'git clean -id'
abbr gpristine 'git reset --hard && git clean -dffx'
abbr gcm 'git checkout (git_main_branch)'
abbr gcd 'git checkout development'
abbr gcmsg 'git commit -m'
abbr gco 'git checkout'
abbr gcount 'git shortlog -sn'
abbr gcp 'git cherry-pick'
abbr gcpa 'git cherry-pick --abort'
abbr gcpc 'git cherry-pick --continue'
abbr gcs 'git commit -S'

abbr gd 'git diff'
abbr gdca 'git diff --cached'
abbr gdcw 'git diff --cached --word-diff'
abbr gdct 'git describe --tags (git rev-list --tags --max-count 1)'
abbr gds 'git diff --staged'
abbr gdt 'git diff-tree --no-commit-id --name-only -r'
abbr gdw 'git diff --word-diff'

abbr gf 'git fetch'
abbr gfa 'git fetch --all --prune'
abbr gfo 'git fetch origin'

abbr gfg 'git ls-files | grep'

abbr gg 'git gui citool'
abbr gga 'git gui citool --amend'

abbr ggpur ggu
abbr ggpull 'git pull origin "(git_current_branch)"'
abbr ggpush 'git push origin "(git_current_branch)"'

abbr ggsup 'git branch --set-upstream-to origin/(git_current_branch)'
abbr gpsup 'git push --set-upstream origin (git_current_branch)'

abbr ghh 'git help'

abbr gignore 'git update-index --assume-unchanged'
abbr gignored 'git ls-files -v | grep "^[[:lower:]]"'
abbr git-svn-dcommit-push 'git svn dcommit && git push github (git_main_branch):svntrunk'

abbr gk '\gitk --all --branches'
abbr gke '\gitk --all (git log -g --pretty %h)'

abbr gl 'git pull'
abbr glg 'git log --stat'
abbr glgp 'git log --stat -p'
abbr glgg 'git log --graph'
abbr glgga 'git log --graph --decorate --all'
abbr glgm 'git log --graph --max-count 10'
abbr glo 'git log --oneline --decorate'
abbr glol "git log --graph --pretty '%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
abbr glols "git log --graph --pretty '%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"
abbr glod "git log --graph --pretty '%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
abbr glods "git log --graph --pretty '%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date short"
abbr glola "git log --graph --pretty '%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
abbr glog 'git log --oneline --decorate --graph'
abbr gloga 'git log --oneline --decorate --graph --all'
abbr glp _git_log_prettily

abbr gm 'git merge'
abbr gmom 'git merge origin/(git_main_branch)'
abbr gmt 'git mergetool --no-prompt'
abbr gmtvim 'git mergetool --no-prompt --tool vimdiff'
abbr gmum 'git merge upstream/(git_main_branch)'
abbr gma 'git merge --abort'

abbr gp 'git push'
abbr gpd 'git push --dry-run'
abbr gpf 'git push --force-with-lease'
abbr gpf! 'git push --force'
abbr gpoat 'git push origin --all && git push origin --tags'
abbr gpu 'git push upstream'
abbr gpv 'git push -v'

abbr gr 'git remote'
abbr gra 'git remote add'
abbr grb 'git rebase'
abbr grba 'git rebase --abort'
abbr grbc 'git rebase --continue'
abbr grbd 'git rebase develop'
abbr grbi 'git rebase -i'
abbr grbm 'git rebase (git_main_branch)'
abbr grbs 'git rebase --skip'
abbr grev 'git revert'
abbr grh 'git reset'
abbr grhh 'git reset --hard'
abbr groh 'git reset origin/(git_current_branch) --hard'
abbr grm 'git rm'
abbr grmc 'git rm --cached'
abbr grmv 'git remote rename'
abbr grrm 'git remote remove'
abbr grs 'git restore'
abbr grset 'git remote set-url'
abbr grss 'git restore --source'
abbr grt 'cd "(git rev-parse --show-toplevel || echo .)"'
abbr gru 'git reset --'
abbr grup 'git remote update'
abbr grv 'git remote -v'

abbr gsb 'git status -sb'
abbr gsd 'git svn dcommit'
abbr gsh 'git show'
abbr gsi 'git submodule init'
abbr gsps 'git show --pretty short --show-signature'
abbr gsr 'git svn rebase'
abbr gss 'git status -s'
abbr gst 'git status'

abbr gstaa 'git stash apply'
abbr gstc 'git stash clear'
abbr gstd 'git stash drop'
abbr gstl 'git stash list'
abbr gstp 'git stash pop'
abbr gsts 'git stash show --text'
abbr gstu 'git stash --include-untracked'
abbr gstall 'git stash --all'
abbr gsu 'git submodule update'
abbr gsw 'git switch'
abbr gswc 'git switch -c'

abbr gts 'git tag -s'
abbr gtv 'git tag | sort -V'
abbr gtl 'gtl(){ git tag --sort -v:refname -n -l "${1}*" }; noglob gtl'

abbr gunignore 'git update-index --no-assume-unchanged'
abbr gunwip 'git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
abbr gup 'git pull --rebase'
abbr gupv 'git pull --rebase -v'
abbr gupa 'git pull --rebase --autostash'
abbr gupav 'git pull --rebase --autostash -v'
abbr glum 'git pull upstream (git_main_branch)'

abbr gwch 'git whatchanged -p --abbrev-commit --pretty medium'
abbr gwip 'git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'

abbr gam 'git am'
abbr gamc 'git am --continue'
abbr gams 'git am --skip'
abbr gama 'git am --abort'
abbr gamscp 'git am --show-current-patch'

# Cat
abbr cat bat

# Task management 
abbr todo nvim ~/.todo/todo.md

# terraform
abbr tf terraform
# kubernetes
abbr k8 kubectl
abbr pods 'kubectl get pods --sort-by=.status.startTime '
abbr kdev 'kubectl config use-context arn:aws:eks:eu-central-1:441212097967:cluster/DevelopmentBackendServices'
abbr ktest 'kubectl config use-context arn:aws:eks:eu-central-1:441212097967:cluster/TestingBackendServices'
abbr kprod 'kubectl config use-context arn:aws:eks:eu-central-1:441212097967:cluster/ProductionBackendServices'
abbr alc 'alacritty-colorscheme apply (alacritty-colorscheme list | fzf)'
