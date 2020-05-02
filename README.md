# Xonotic-JS

This repository contains the scripts to compile Xonotic for the web using Emscripten.
It builds on some changes to the latest release, all contained in the submodule `xonotic`, repository [here](https://gitlab.com/ctbur/xonotic).


## Build instructions

1. Clone this repository with `git clone --recursive https://github.com/ctbur/xonotic-js`.
1. Run `./emscripten-interactive.sh` within the repository. This drops you into a container that is set up for emscripten builds.
1. Within the container, run `./scripts/run-all.sh`. The built files will be in the directory `./out`.
1. `./run-test-server.sh` starts a local server to serve the files from the `./out` directory and makes them accessible at http://localhost:7000.


## Current issues

- In the current state the game performs poorly on the browser, the sound skips and the loading times are _very_ long. Use the console to see the files that are being loaded.
- Lighting for 3D objects does not seem to work, resulting in an almost black scene.
- There is code to emulate libcurl, but it does not work yet.
- The emscripten build is hacked into the build for SDL and currently breaks all other builds. Cleanup is neccessary to upstream the code.
- The same applies for some of the changes made to the source files in the submodule.


## Attribution

Some changes were taken from the fork [DarkPlacesRM](https://github.com/kasymovga/DarkPlacesRM).
