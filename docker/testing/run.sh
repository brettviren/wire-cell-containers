#!/bin/bash

git clone https://github.com/wirecell/wire-cell-build.git wct
cd wct
./switch-git-urls anon
git submodule init
git submodule update
./wcb configure --prefix=$HOME --with-jsonnet=/usr/local --with-eigen-include=/usr/include/eigen3 
./wcb --notests install
#./wcb --alltests
#./wcb clean




