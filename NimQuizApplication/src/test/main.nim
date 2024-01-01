import wNim

var
  Title: string = "テスト"
  app: wApp = App(wSystemDpiAware)
  frame {.global.}: wFrame
  
frame = Frame(title=Title, size=(1280, 720))

export app, frame

import PageTemplate

when isMainModule:
  PageTemplate.layout()

  frame.center()
  frame.show()
  app.mainLoop()