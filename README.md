dotfiles
========

My dev setup (mostly vim, with some tmux and zsh). The vim setup was originally based on [pda](https://github.com/pda)'s.

Uses [homesick](https://github.com/technicalpickles/homesick) to manage symlinks.

Usage
-----

```
gem install homesick
homesick clone lsimoneau/dotfiles
homesick symlink lsimoneau/dotfiles
```

Ctags
-----

Ctag hooks are set up for git, so the ctags for a project will be re-indexed on commit, merge, rebase, and checkout. Ctags in Ruby's standard library are handled by vim-ruby, but if you want ctags on installed gems (and you should), install [gem-ctags](https://github.com/tpope/gem-ctags):

```
gem install gem-ctags
gem ctags
```
