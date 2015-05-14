#!/bin/bash
# Author: Yunkai Cui
# License: LICENSE
# Description:
# This script is used to setup a python development environment in vim
# Run the script by:
# $: ./vimsetup.sh [options]
# options:
# -c  Compile with llvm to have c family language auto completion support

# Get vundle
curl -L https://github.com/gmarik/Vundle.vim/archive/master.zip | tar xz -o vundle
mv -P vundle/ ~/.vim/bundle/vundle/
# Added the lines to vimrc to support python integration
cat vimconf >> ~/.vimrc

vim +PluginInstall +qall

# build YCM
mkdir ycm_build
if [ $# -eq 1 ] && [ "$1" = "-c" ]; then
  curl -L http://llvm.org/releases/3.6.0/clang+llvm-3.6.0-x86_64-linux-gnu-ubuntu-14.04.tar.xz | tar xz -o LLVM
  cd ycm_build
  cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=./LLVM . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
else
  cd ycm_build
  # with no c language semantic support
  cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
fi
make ycm_support_libs
cd ..

exit 0
