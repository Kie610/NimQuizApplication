import wNim
import ../Modules/public_variables

var
  app: wApp = App(wSystemDpiAware)
  frame*: wFrame = Frame(title="テスト", size=(1280, 720))
  panel*: wPanel = Panel(frame, style=wDoubleBuffered)
  title*: wStaticText = StaticText(panel, label="TITLE", style=(wAlignCenter + wAlignMiddle))

export frame, panel, title

import PageTemplate

when isMainModule:
  PageTemplate.layout()
  PageTemplate.event()


  frame.center()
  frame.show()
  app.mainLoop()