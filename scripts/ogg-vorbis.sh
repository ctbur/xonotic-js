#!/bin/bash

wget https://github.com/emscripten-ports/Ogg/archive/version_1.tar.gz -O ogg.tar.gz
wget https://github.com/emscripten-ports/Vorbis/archive/version_1.tar.gz -O vorbis.tar.gz

tar -xf ogg.tar.gz
tar -xf vorbis.tar.gz

cd Ogg-version_1
./autogen.sh
emconfigure ./configure --enable-static --disable-shared --prefix=$EMSCRIPTEN/system
emmake make -j
emmake make -j install

cd ../Vorbis-version_1
./autogen.sh
emconfigure ./configure --enable-static --disable-shared --prefix=$EMSCRIPTEN/system
emmake make -j
emmake make -j install

cd ..
rm ogg.tar.gz vorbis.tar.gz
rm -rf Ogg-version_1 Vorbis-version_1
