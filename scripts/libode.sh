#!/bin/bash

wget https://bitbucket.org/odedevs/ode/downloads/ode-0.16.1.tar.gz
tar xf ode-0.16.1.tar.gz
cd ode-0.16.1

emconfigure ./configure --disable-assembly --disable-shared --prefix=$EMSCRIPTEN/system

emmake make -j
emmake make -j install

cd ..
rm -rf ode-0.16.1*
