# Nimraylib_now! stub
Stub for building nimraylib_now library for different targets, be it native or wasm

## Preparation
Make sure that following is done:
- Nimraylib_now! is installed via nimble. If not, - just run `$ nimble install nimraylib_now` in your shell
- For wasm make sure that emscripten compiler is installed and is in your PATH
- Packaging for itch requires 7z and unix command line utilities available (via Mingw under Windows, for example)

## Usage
All commands are defined in config.nims tasks and have following logic:
- First comes action: `run` or `build`
- Second comes target: `native` / `wasm` or `itch`
- Last comes input file name, you can test it by `main.nim` supplied with this repo

Invocation examples:

`$ nim build_native main.nim` to build exe

`$ nim run_native main.nim` to run exe

`$ nim build_wasm main.nim` to build for wasm

`$ nim run_wasm main.nim` to compile with `build_wasm` and then run local server with automatic browser opening

`$ nim build_itch main.nim` to compile with `build_wasm` and package for uploading on itch
