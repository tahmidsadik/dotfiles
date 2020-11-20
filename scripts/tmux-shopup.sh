#!/bin/zsh
# docker 
tmux new-session -d 'shopup'
tmux send-keys 'cd ~/projects/shopup/shopup-lite && npm run watch:backend:nodemon ' Enter
tmux split-window -fv
tmux send-keys 'cd ~/projects/shopup/auth && dc up -d && ./scripts/docker-entrypoint.dev.sh' Enter
tmux split-window -fv
tmux send-keys 'cd ~/projects/shopup/dockerized-dev-env && dc up' Enter 
tmux split-window -h
tmux send-keys 'cd ~/projects/shopup/shopup-lite && npm run watch:backend:ts' Enter
tmux split-window -h
tmux send-keys 'cd ~/projects/shopup/auth && yarn tsc -w' Enter
tmux select-pane -L
tmux resize-pane -L 10
tmux select-pane -L
tmux resize-pane -L 20
tmux select-pane -U 
tmux resize-pane -D 10
tmux select-pane -U 
tmux resize-pane -D 10

tmux new-window -n logs
tmux send-keys 'cd ~/projects/shopup/dockerized-dev-env && dc logs -f front-proxy' Enter
tmux split-window -fv
tmux send-keys 'cd ~/projects/shopup/dockerized-dev-env && dc logs -f web' Enter

tmux new-window -n eloan-backend
tmux send-keys 'cd ~/projects/shopup/eloan-backend && dc up' Enter
tmux split-window -fv
tmux send-keys 'cd ~/projects/shopup/eloan-backend && yarn start' Enter

tmux new-window -n eloan-frontend
tmux send-keys 'cd ~/projects/shopup/eloan-frontends && yarn shopup:start' Enter
tmux next-window
