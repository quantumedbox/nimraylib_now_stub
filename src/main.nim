import nimraylib_now


proc render =
  beginDrawing:
    clearBackground(DarkGray)


proc loop =
  render()


proc main =
  initWindow(640, 480, "raylib is cool")

  while not windowShouldClose():
    loop()

  closeWindow()


when isMainModule:
  main()
