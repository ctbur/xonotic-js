#!/bin/bash

cp -r xonotic xonotic-build
cd xonotic-build

cd source/d0_blind_id
./autogen.sh
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

CFLAGS_ADDITIONAL="-g4 -s ASSERTIONS=1 -s USE_SDL=2 -s USE_LIBPNG=1 -s USE_ZLIB=1 -s USE_OGG=1 -s USE_VORBIS=1 -s USE_FREETYPE=1 -s FETCH=1 -s LEGACY_GL_EMULATION=1 -DHAVE_STRLCAT=1 -DHAVE_STRLCPY=1 -DDP_FREETYPE_STATIC=1 -DLINK_TO_LIBVORBIS=1 -DLINK_TO_LIBPNG=1"
emmake make -j sdl-release DP_CRYPTO_STATIC_LIBDIR=$(pwd)/../d0_blind_id/.libs CFLAGS_ADDITIONAL="$CFLAGS_ADDITIONAL" DP_SOUND_API=NULL DP_CDDA=disabled DP_VIDEO_CAPTURE=disabled DP_LINK_ZLIB=shared DP_LINK_JPEG=shared DP_LINK_ODE=shared DP_LINK_CRYPTO=shared DP_LINK_CRYPTO_RIJNDAEL=shared
#emmake make -j sv-release DP_CRYPTO_STATIC_LIBDIR=$(pwd)/../d0_blind_id/.libs CFLAGS_COMMON="$CFLAGS_COMMON" DP_SOUND_API=NULL DP_CDDA=disabled
#emmake make -j cl-release DP_CRYPTO_STATIC_LIBDIR=$(pwd)/../d0_blind_id/.libs CFLAGS_COMMON="$CFLAGS_COMMON" DP_SOUND_API=NULL DP_CDDA=disabled

cp darkplaces-sdl.{js,html,wasm,wasm.map,data} /src/out

cd ..
#rm xonotic-build

