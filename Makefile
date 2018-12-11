
DOTFILES=$(patsubst dotfiles/%,%,$(wildcard dotfiles/*))
BINFILES=$(patsubst bin/%,%,$(wildcard bin/*))
DOTDIR=$(patsubst %/,%,$(filter %/,$(patsubst dotfiles/%,%,$(wildcard dotfiles/*/))))

install-file: install-dotfiles install-bin

install-dotfiles: touch-dir $(patsubst %,$(HOME)/.%,$(DOTFILES)) $(HOME)/.vim
install-bin: $(patsubst %,$(HOME)/bin/%,$(BINFILES))
install-software-apt: 
	sudo apt update && sudo apt install pass git make tig vim vim-gtk3 meld\
	  	cryptsetup lvm2 git dirmngr powerline php-cli python-pip numlockx i3 zsh
	pip install powerline-gitstatus

touch-dir:
	touch $(patsubst %,$(PWD)/dotfiles/%,$(DOTDIR))

$(HOME)/bin/%: $(PWD)/bin/%
	if [ -d "$<" ]; then ./installdir "$<" "$@"; touch "$@"; else ln -rs "$<" "$@"; fi

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
