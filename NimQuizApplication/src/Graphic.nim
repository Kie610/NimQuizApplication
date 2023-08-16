#ライブラリのインポート
import wNim

proc Start*() =
  echo("Graphic")

  const
    UseAutoLayout = not defined(legacy)
    Title = if UseAutoLayout: "Autolayout Example 1" else: "Layout Example 1"

  type
    MenuID = enum idLayout1 = wIdUser, idExit

  let app = App(wSystemDpiAware)
  let frame = Frame(title=Title, size=(400, 300))

  let panel = Panel(frame)

  const style = wAlignCentre or wAlignMiddle or wBorderSimple
  let text1 = StaticText(panel, label="Text1", style=style)
  let text2 = StaticText(panel, label="Text2", style=style)
  let text3 = StaticText(panel, label="Text3", style=style)
  let text4 = StaticText(panel, label="Text4", style=style)
  let text5 = StaticText(panel, label="Text5", style=style)

  let menuBar = MenuBar(frame)
  let menu = Menu(menuBar, "Layout")
  menu.appendRadioItem(idLayout1, "Layout1").check()
  menu.appendSeparator()
  menu.append(idExit, "Exit")

  proc Genre() =
    panel.autolayout """
      spacing: 8
      H:|-[text1..2]-[text3..5(text1)]-|
      V:|-[text1]-[text2(text1)]-|
      V:|-[text3(text4,text5)]-[text4]-[text5]-|
    """

  proc layout() =
    Genre()

  frame.idLayout1 do (): layout()
  frame.idExit do (): frame.close()
  panel.wEvent_Size do (): layout()

  layout()
  frame.center()
  frame.show()
  app.mainLoop()
