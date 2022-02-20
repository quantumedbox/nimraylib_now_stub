import strutils

func `<<`(a, b: string): string = a & " " & b


task run_native, "run native application":
  setCommand "r"


task build_native, "build native application":
  setCommand "c"


task run_wasm, "run server with built application":
  let exe =
    when defined(windows): "emrun.bat" else: "emrun"

  exec exe << projectName() & ".html"


task build_wasm, "build application on top of emscripten":
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
      "-o" << projectName() & ".html" <<
      "-s USE_GLFW=3" <<
      "-DPLATFORM_WEB" <<
      "--shell-file" << pathToRaylib & "/csources/raylib_mangled/shell.html"

    compileFlags =
      "-I" << pathToRaylib & "/nimraylib_now/mangled"

  switch("passL", linkerFlags)
  switch("passC", compileFlags)
