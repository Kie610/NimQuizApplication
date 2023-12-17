#################################################
#ライブラリのインポート
#################################################
import wNim


#################################################
#変数宣言
#################################################
var
  app: wApp
  frame: wFrame
  panel: wPanel
  listbox: wListBox
  label: wTextCtrl


#################################################
#   プロシージャ前方宣言
#################################################
proc event()
proc layout()
proc add(self: wListBox, text: string)


#################################################
#   変数代入
#################################################
proc assignment*() =
  const
    Title = "クイズ出題アプリ"
  app = App(wSystemDpiAware)
  frame = Frame(title=Title, size=(1280, 720))
  panel = Panel(frame)
  listbox = ListBox(panel, style=wBorderSimple or wLbNeededScroll)
  label = TextCtrl(panel, value="Label", style=wTeReadOnly)


  setFont(listbox, Font(20))


#################################################
#   メインプロシージャ
#################################################
proc main*() =
  for i in 0..10:
    listbox.add "Button" & $i

  layout()
  event()
  frame.center()

  echo("Show Window")
  frame.show()
  app.mainLoop()


#################################################
#   ウィンドウを閉じる処理
#################################################
proc window_close*() =
  echo("Close Window")
  frame.close()


#################################################
#   通常処理
#################################################
proc layout() =
  panel.autolayout "spacing: 8 \nH:|-[label(40%)]-[listbox]-| \nV:|-[label,listbox]-|"

proc add(self: wListBox, text: string) =
  self.ensureVisible(self.append(text))


#################################################
#   イベント処理
#################################################
proc event() =
  listbox.wEvent_ListBox do ():
    label.setValue($(listbox.getSelection()))
    echo $(listbox.getSelection())

  panel.wEvent_Size do ():
    layout()

  frame.wIdClear do ():
    listbox.clear()