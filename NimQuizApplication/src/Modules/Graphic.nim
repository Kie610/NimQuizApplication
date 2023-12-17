#################################################
#ライブラリのインポート
#################################################
import wNim
import screen_layout


#################################################
#変数宣言
#################################################
var
  app: wApp
  frame: wFrame
  panel: wPanel
  #listbox: wListBox
  #label: wTextCtrl

  title: wStaticText
  info: wStaticText
  genre: wStaticText
  question: wTextCtrl
  option1: wButton
  option2: wButton
  #options3: wButton
  #options4: wButton
  prev: wButton
  next: wButton


#################################################
#   プロシージャ前方宣言
#################################################
proc event()
proc layout()
#proc add(self: wListBox, text: string)


#################################################
#   変数代入
#################################################
proc assignment*() =
  const
    Title = "クイズ出題アプリ"
  app = App(wSystemDpiAware)
  frame = Frame(title=Title, size=(1280, 720))
  panel = Panel(frame)
  #listbox = ListBox(panel, style=wBorderSimple or wLbNeededScroll)
  #label = TextCtrl(panel, value="Label", style=wTeReadOnly)

  title = StaticText(panel, label="title", style=(wAlignCenter + wAlignMiddle))
  info = StaticText(panel, label="info", style=(wAlignCenter + wAlignMiddle))
  genre = StaticText(panel, label="genre", style=(wAlignCenter + wAlignMiddle))
  question = TextCtrl(panel, value="question", style=wTeReadOnly)
  option1 = Button(panel, label="option1")
  option2 = Button(panel, label="option2")
  #options3 = Button(panel, label="options3")
  #options4 = Button(panel, label="options4")
  prev = Button(panel, label="prev")
  next = Button(panel, label="next")

#################################################
#   メインプロシージャ
#################################################
proc main*() =
#  for i in 0..10:
#    listbox.add "Button" & $i

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
  var font_size = (frame.getsize.width + frame.getsize.height)/200

  panel.autolayout(screen_layout.get_string("two_choice"))

  setFont(title, Font(font_size))
  setFont(info, Font(font_size))
  setFont(genre, Font(font_size))
  setFont(question, Font(font_size))
  setFont(option1, Font(font_size))
  setFont(option2, Font(font_size))
  setFont(prev, Font(font_size))
  setFont(next, Font(font_size))

#proc add(self: wListBox, text: string) =
#  self.ensureVisible(self.append(text))


#################################################
#   イベント処理
#################################################
proc event() =
#  listbox.wEvent_ListBox do ():
#    label.setValue($(listbox.getSelection()))
#    echo $(listbox.getSelection())

  panel.wEvent_Size do ():
    layout()

#  frame.wIdClear do ():
#    listbox.clear()