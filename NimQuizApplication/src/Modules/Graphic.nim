#ライブラリのインポート
import wNim

var
  app: wApp
  frame: wFrame
  panel: wPanel
  listbox: wListBox

proc Main*() =
  const
    Title = "クイズ出題アプリ"

  
  app = App(wSystemDpiAware)
  frame = Frame(title=Title, size=(400, 300))
  panel = Panel(frame)
  listbox = ListBox(panel, style=wBorderSimple or wLbNeededScroll)

  setFont(listbox, Font(20))

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

  echo("Show Window")
  frame.show()
  app.mainLoop()

proc window_close*() =
  echo("Close Window")
  frame.close()