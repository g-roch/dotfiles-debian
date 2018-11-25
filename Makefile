
DOTFILES=$(patsubst dotfiles/%,%,$(wildcard dotfiles/*))

install-dotfiles: $(patsubst %,$(HOME)/.%,$(DOTFILES)) $(HOME)/.vim
install-software-apt: 
	sudo apt update && sudo apt install pass git make tig vim vim-gtk3 meld\
	  	cryptsetup lvm2 git dirmngr powerline php-cli python-pip numlockx
	pip install powerline-gitstatus

$(HOME)/.%: $(PWD)/dotfiles/%
	if [ -d "$<" ]; then ./installdir "$<" "$@"; touch "$@"; else ln -rs "$<" "$@"; fi

$(HOME)/.vim: $(HOME)/.vimrc
	if [ -e "$@" ]; then touch "$@"; fi
	if [ ! -e "$@" ]; then \
	  mkdir -p "$@";\
	  git clone https://github.com/VundleVim/Vundle.vim.git "$@/bundle/Vundle.vim";\
	  vim +PluginInstall +qall ;\
  	  fi


.PHONY: install-dotfiles
