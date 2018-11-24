
DOTFILES=$(patsubst dotfiles/%,%,$(wildcard dotfiles/*))

install-dotfiles: $(patsubst %,$(HOME)/.%,$(DOTFILES))

$(HOME)/.%: $(PWD)/dotfiles/%
	ln -rs $< $@

.PHONY: install-dotfiles
