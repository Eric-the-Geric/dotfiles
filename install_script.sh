#!/bin/bash
rm -rf ~/.bashrc 
rm -rf ~/.config/nvim
rm -rf ~/.config/i3
rm -rf ~/.tmux.conf

ln -sf ~/dotfiles/.bashrc ~/.bashrc 
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/i3 ~/.config/i3
ln -sf ~/dotfiles/alacritty ~/.config/alacritty
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf


git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
