#!/bin/sh
docker run -it -v `pwd`/scripts:/src/scripts:ro -v `pwd`/xonotic:/src/xonotic:ro -v `pwd`/out:/src/out trzeci/emscripten /bin/bash
