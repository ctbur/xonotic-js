#!/bin/bash

wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.lz
tar xf gmp-6.1.2.tar.lz
cd gmp-6.1.2

sed -i '2igmp_asm_syntax_testing=no' configure

# have to set CONFIGURE_CC to emcc because of a bug in Emscripten 1.39.13 that causes it to use em++ for C code
CONFIGURE_CC=emcc emconfigure ./configure --disable-assembly --disable-shared --prefix=$EMSCRIPTEN/system ABI=32

echo '#define HAVE_MEMSET 1' >> config.h
echo '#define HAVE_STRNLEN 1' >> config.h
echo '#define HAVE_VSNPRINTF 1' >> config.h

emmake make -j
emmake make -j install

cd ..
rm -rf gmp-6.1.2*
