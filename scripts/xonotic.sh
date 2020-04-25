#!/bin/bash

unzip scripts/xonotic-0.8.2.zip
cd Xonotic

cd source/d0_blind_id
emconfigure ./configure --enable-static --disable-shared --prefix=$EMSCRIPTEN/system --without-openssl
emmake make -j
emmake make -j install

# QuakeC compile needs to be compiled natively
cd ../gmqcc
make -j
cp gmqcc /usr/local/bin

cd ../qcsrc
emmake make -j

cd ../darkplaces
rm /usr/bin/strip
ln -s /bin/true /usr/bin/strip
CFLAGS_COMMON="-s USE_SDL=2 -s USE_LIBPNG=1 -s USE_ZLIB=1 -s USE_OGG=1 -DHAVE_STRLCAT=1 -DHAVE_STRLCPY=1"
emmake make -j sv-release DP_CRYPTO_STATIC_LIBDIR=$(pwd)/../d0_blind_id/.libs CFLAGS_COMMON="$CFLAGS_COMMON" DP_SOUND_API=NULL DP_CDDA=disabled
emmake make -j cl-release DP_CRYPTO_STATIC_LIBDIR=$(pwd)/../d0_blind_id/.libs CFLAGS_COMMON="$CFLAGS_COMMON" DP_SOUND_API=NULL DP_CDDA=disabled
emmake make -j sdl-release DP_CRYPTO_STATIC_LIBDIR=$(pwd)/../d0_blind_id/.libs CFLAGS_COMMON="$CFLAGS_COMMON" DP_SOUND_API=NULL DP_CDDA=disabled

cd ..
#rm -rf Xonotic
