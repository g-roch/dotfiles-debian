
DOTFILES=$(patsubst dotfiles/%,%,$(wildcard dotfiles/*))

install-dotfiles: $(patsubst %,$(HOME)/.%,$(DOTFILES)) $(HOME)/.vim

$(HOME)/.%: $(PWD)/dotfiles/%
	ln -rs $< $@

$(HOME)/.vim: $(HOME)/.vimrc
	mkdir -p "$@"
	git clone https://github.com/VundleVim/Vundle.vim.git "$@/bundle/Vundle.vim"
	vim +PluginInstall +qall


.PHONY: install-dotfiles
