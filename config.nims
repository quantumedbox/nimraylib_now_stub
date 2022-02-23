import strutils

func `<<`(a, b: string): string = a & " " & b
func projectExtension(extension: string): string = projectName() & extension


task run_native, "run native application":
  setCommand "r"


task build_native, "build native application":
  setCommand "c"


task run_wasm, "run wasm server in browser":
  exec "nim build_wasm" << projectName()

  let exe =
    when defined(windows): "emrun.bat" else: "emrun"

  exec exe << projectExtension(".html")


task build_itch, "build emscripten application and then package it all for distribution to itch":
  exec "nim build_wasm" << projectName()
  exec "cp" << projectExtension(".html") << "index.html" # itch requires it
  exec "7z a -tzip" << projectExtension(".zip") << "index.html" << projectExtension(".js") << projectExtension(".wasm")
  exec "rm index.html"


task build_wasm, "build emscripten application":
  setCommand "c"

  --d:emscripten
  --os:linux
  --cpu:wasm32
  --cc:clang

  --gc:orc
  --exceptions:goto
  --define:noSignalHandler

  when defined(windows):
    --clang.exe:emcc.bat
    --clang.linkerexe:emcc.bat
    --clang.cpp.exe:emcc.bat
    --clang.cpp.linkerexe:emcc.bat
  else:
    --clang.exe:emcc
    --clang.linkerexe:emcc
    --clang.cpp.exe:emcc
    --clang.cpp.linkerexe:emcc
  --listCmd

  let
    pathToRaylib = block:
      let (path, code) = gorgeEx "nimble path nimraylib_now"
      assert code == 0, "nimble cannot report nimraylib_now, make sure it's installed"
      path.strip()

    linkerFlags =
      "-o" << projectExtension(".html") <<
      "-s USE_GLFW=3" <<
      "-DPLATFORM_WEB" <<
      "--shell-file" << pathToRaylib & "/csources/raylib_mangled/shell.html" <<
      "-s ASYNCIFY"

    compileFlags =
      "-I" << pathToRaylib & "/nimraylib_now/mangled"

  switch("passL", linkerFlags)
  switch("passC", compileFlags)
