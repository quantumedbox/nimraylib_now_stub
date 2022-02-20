# Nimraylib_now! stub
Stub for building nimraylib_now library for different targets, be it native or wasm

## Preparation
Make sure that following is done:
- Emscripten compiler is in PATH
- Nimraylib_now! is installed via nimble. If not, - just run `$ nimble install nimraylib_now` in your shell

## Usage
All commands are defined in config.nims tasks and have following logic:
- First comes action: `run` or `build`
- Second comes target: `native` or `wasm
- Last comes input file name, you can test it by `main.nim` supplied with this repo

Example of usage:

`$ nim build_wasm main.nim` to build for wasm

`$ nim run_wasm main.nim` to run wasm that is already built

`$ nim build_native main.nim` to build exe

`$ nim run_native main.nim` to run exe
