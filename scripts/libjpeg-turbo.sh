#!/bin/bash

wget https://github.com/libjpeg-turbo/libjpeg-turbo/archive/2.0.4.tar.gz
tar xf 2.0.4.tar.gz
cd libjpeg-turbo-2.0.4
mkdir build && cd build

emconfigure cmake .. -DBUILD_SHARED_LIBS=OFF -DCMAKE_INSTALL_PREFIX=$EMSCRIPTEN/system

emmake make -j
emmake make -j install

cd ../..
rm 2.0.4.tar.gz
rm -rf libjpeg-turbo-2.0.4*
