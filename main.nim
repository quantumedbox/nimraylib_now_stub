import nimraylib_now

proc emscripten_set_main_loop(f: proc() {.cdecl.}, a: cint, b: bool) {.importc.}


const
  WindowWidth = 640
  WindowHeight = 480


proc render =
  beginDrawing:
    clearBackground(DarkGray)


proc loop {.cdecl.} =
  render()


proc main =
  initWindow(WindowWidth, WindowHeight, "raylib is cool")

  when defined(emscripten):
    emscriptenSetMainLoop(loop, 0, true)
  else:
    while not windowShouldClose():
      loop()

  closeWindow()


main()
