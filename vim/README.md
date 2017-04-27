# .vimrc for linux

## First things first...

In this directory do:

```
cp .vimrc ~/
```

## Installing Vundle

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Then, restart vim

## Installing Plugins

In vim, do:

```
:PluginInstall
```

which should install all the things.

## Installing the custom font for Lightline 

```
mkdir ~/.fonts
cp DejaVuSansMono-Powerline.ttf ~/.fonts
sudo fc-cache -f
```
In the terminal, Click Edit, Preferences, Appearance. Choose the font "DejaVu Sans Mono for Powerline Book"

## Installing the color theme

Download [this theme file](http://www.vim.org/scripts/download_script.php?src_id=13400), and relocate to `~/.vim/colors`

