#ライブラリのインポート
import wNim
import nim_test_module as NTM

when isMainModule:
  NTM.gInitialize()
  const
    Title = "クイズ出題アプリ"

  let
    app = App(wSystemDpiAware)
    frame = Frame(title=Title, size=(400, 300))
    panel = Panel(frame)

  proc layout() =
    panel.autolayout "spacing: 8 \nH:|-[label(40%)]-[listbox]-| \nV:|-[label,listbox]-|"

  panel.wEvent_Size do ():
    layout()

  layout()
  frame.center()
  frame.show()
  app.mainLoop()



