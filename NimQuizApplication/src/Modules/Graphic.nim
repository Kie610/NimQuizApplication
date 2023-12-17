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

  selected_option: uint8
  correct_answer: uint8


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

  title = StaticText(panel, label="スタジオララの名前", style=(wAlignCenter + wAlignMiddle))
  info = StaticText(panel, label="1/1", style=(wAlignCenter + wAlignMiddle))
  genre = StaticText(panel, label="〇×ゲーム", style=(wAlignCenter + wAlignMiddle))
  question = TextCtrl(panel, value="スタジオララ(旧:田中工務店)の正式名称は「Sutudio RaLa」である。\n〇か×か？", style=wTeReadOnly)
  option1 = Button(panel, label="〇")
  option2 = Button(panel, label="×")
  #options3 = Button(panel, label="options3")
  #options4 = Button(panel, label="options4")
  prev = Button(panel, label="prev")
  next = Button(panel, label="next")

  correct_answer = 2

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

  option1.wEvent_Button do ():
    selected_option = 1
    echo("Selected Button No." & $selected_option)

  option2.wEvent_Button do ():
    selected_option = 2
    echo("Selected Button No." & $selected_option)

  prev.wEvent_Button do ():
    echo("prev")
  
  next.wEvent_Button do ():
    echo("next")

    if correct_answer == selected_option:
      echo("correct")
      setValue(question, value="正解！")

    else:
      echo("incorrect")
      setValue(question, value="不正解！")