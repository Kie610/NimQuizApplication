import wNim
import ../Modules/public_variables

var
  now_state*: MenuState = stDefault

  main_app: wApp = App(wSystemDpiAware)
  main_frame*: wFrame = Frame(title="テスト", size=(1280, 720))
  main_panel*: wPanel = Panel(main_frame, style=wDoubleBuffered)
  conTitle*: wStaticText = StaticText(main_panel, label="TITLE", style=(wAlignCenter + wAlignMiddle))
  conTitle2*: wStaticText = StaticText(main_panel, label="TITLE2", style=(wAlignCenter + wAlignMiddle))
  conPrev = Button(main_panel, label="prev")
  conNext = Button(main_panel, label="next")

proc initMenu()
proc callMenu*(state: MenuState)

export main_frame, main_panel, conTitle, conPrev, conNext

import PageTemplate, PageTemplate2

when isMainModule:
  initMenu()

  callMenu(stSetting)

  main_frame.center()
  main_frame.show()
  main_app.mainLoop()

proc initMenu() =
  PageTemplate.init()
  PageTemplate2.init()

  PageTemplate.event()
  PageTemplate2.event()

proc callMenu*(state: MenuState) =
  case state
  of stSetting:
    PageTemplate.layout(state)

  of stCredit:
    PageTemplate2.layout(state)

  else:
    echo("default state")