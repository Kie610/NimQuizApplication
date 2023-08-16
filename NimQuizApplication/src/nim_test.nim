import wNim

when isMainModule:
  const
    Title = "クイズ出題アプリ"

  let
    app = App(wSystemDpiAware)
    frame = Frame(title=Title, size=(400, 300))
    panel = Panel(frame)
    
  var
    x = newSeq[wRadiobutton]()

  for i in 0..10:
    x.add(RadioButton(panel, label="Button" & $i))

  var
    button = RadioButton(panel, label="button")
    scroll = ScrollBar(panel, style=wSbVertical)

  scroll.setScrollbar(0, 1, 20)

  panel.wEvent_Size do ():
    panel.autolayout "spacing: 8 \nH:|-[button]-[scroll(30)]-| \nV:|-[button,scroll]-|"

  frame.center()
  frame.show()
  app.mainLoop()