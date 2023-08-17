#ライブラリのインポート
import wNim

when isMainModule:
  const
    Title = "クイズ出題アプリ"

  let
    app = App(wSystemDpiAware)
    frame = Frame(title=Title, size=(400, 300))
    panel = Panel(frame)
    listbox = ListBox(panel, style=wBorderSimple or wLbNeededScroll)

  var
    label = TextCtrl(panel, value="Label", style=wTeReadOnly)

  listbox.wEvent_ContextMenu do ():
    let menu = Menu()
    menu.append(wIdClear, "&Clear")
    listbox.popupMenu(menu)

  frame.wIdClear do ():
    listbox.clear()

  proc add(self: wListBox, text: string) =
    self.ensureVisible(self.append(text))

  for i in 0..10:
    listbox.add "Button" & $i

  proc layout() =
    panel.autolayout "spacing: 8 \nH:|-[label(40%)]-[listbox]-| \nV:|-[label,listbox]-|"

  panel.wEvent_Size do ():
    layout()

  listbox.wEvent_ListBox do ():
    label.setValue($(listbox.getSelection()))
    echo $(listbox.getSelection())

  layout()
  frame.center()
  frame.show()
  app.mainLoop()