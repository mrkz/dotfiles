# dotfiles
dotfiles with preferred settings

This files are supposed to be managed by [GNU Stow](https://www.gnu.org/software/stow/)

for more information about handling your dotfiles using stow, read
[this](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)
blog.

Additionally, the `setup.sh` as is runs several install commands to setup several stuff
like tmux, zsh, git repositories, rust + tooling, etc.

## usage
simply run the `setup.sh` script.
**note**: You may want to review the script and the dotfiles before
executing the script as they may touch sensible files
(~/.bashrc, ~/.zshrc, ~/.ssh among others) and install a bunch of stuff from repositories + wild Internet.

```
$ ./setup.sh
```

## License
The script and dotfiles of my own are licensed under the MIT license. However,
other repositories and scripts included (e.g: vim plugins, git-prompt.sh, etc)
may have their own licences. Please check them carefully.
