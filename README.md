# refgo.nvim

This plugin helps you copy and jump to line references. A line reference can be
expressed as a file and a line (e.g. `path/to/file:99`).

* Copy a line reference to clipboard with `:RefCopy`
* Go to a reference with `:RefGo`

## Installing

Goto requires Neovim and follows the standard runtime package structure. 
It is possible to install it with all popular package managers:

* [vim-plug](https://github.com/junegunn/vim-plug)
  * `Plug 'prichrd/refgo.nvim'`
* [packer](https://github.com/wbthomason/packer.nvim)
  * `use 'prichrd/refgo.nvim'`

## Usage

The documentation can be found at [doc/refgo.txt](doc/refgo.txt). You can 
also use the `:help refgo` command inside of Neovim.
