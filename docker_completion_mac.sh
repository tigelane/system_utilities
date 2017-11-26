brew install bash-completion
brew upgrade bash-completion
brew tap homebrew/completions

cat >> ~/.bashrc <<EOL  
if [ -f $(brew --prefix)/etc/bash_completion ]; then  
. $(brew --prefix)/etc/bash_completion
fi  
EOL 

