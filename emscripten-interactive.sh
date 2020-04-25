#!/bin/sh
docker run -it -v `pwd`/scripts:/src/scripts:ro trzeci/emscripten /bin/bash
