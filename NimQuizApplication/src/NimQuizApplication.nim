#################################################
#ライブラリのインポート
#################################################
import std/[random, strutils]
import wNim


#################################################
#モジュールのインポート
#################################################
import Modules/[screen_layout, Sound, DB_Connection]


#################################################
#   プロシージャ前方宣言
#################################################
proc main_loop()
proc assignment()
proc window_close()
proc reset_position()
proc choice_quiz_store()
proc layout()
proc showing()
proc event()


#################################################
#   メインモジュール記述
#################################################
when isMainModule:
  try:
    DB_Connection.db_open()
    Sound.enable_sound()

    get_genre_info()
    get_Difficulty_info()

    assignment()
    main_loop()

  finally:
    DB_Connection.db_close()
    Sound.disable_sound()

    window_close()


#################################################
#変数宣言
#################################################
var
  app: wApp
  frame: wFrame
  panel: wPanel
  menubar: wMenuBar

  menu: wMenu

  title: wStaticText
  genre_list: wListBox
  detail: wTextCtrl
  graphic_setting: wButton
  font_setting: wButton
  sound_setting: wButton
  credit: wButton

  info: wStaticText
  genre: wStaticText
  question: wTextCtrl
  option1: wButton
  option2: wButton
  option3: wButton
  option4: wButton
  prev: wButton
  next: wButton

  selected_option: string
  correct_answer: string

type
    MenuID = enum idLayout1 = wIdUser, idLayout2, idLayout3, idLayout4, idLayout5, idExit


#################################################
#   変数代入
#################################################
proc assignment() =
  const
    Title = "クイズ出題アプリ"
  app = App(wSystemDpiAware)
  frame = Frame(title=Title, size=(1280, 720))
  panel = Panel(frame, style=wDoubleBuffered)
  menubar = MenuBar(frame)

  menu = Menu(menubar, "layout")
  menu.appendRadioItem(idLayout1, "Layout1")
  menu.appendRadioItem(idLayout2, "Layout2")
  menu.appendRadioItem(idLayout3, "Layout3")
  menu.appendRadioItem(idLayout4, "Layout4")
  menu.appendRadioItem(idLayout5, "Layout5").check()
  menu.appendSeparator()
  menu.append(idExit, "Exit")

  title = StaticText(panel, label="MainMenu", style=(wAlignCenter + wAlignMiddle))
  genre_list = ListBox(panel)
  detail = TextCtrl(panel, style=(wTeReadOnly + wTeMultiLine + wTeRich))
  graphic_setting = Button(panel, label="Graphic")
  font_setting = Button(panel, label="Font")
  sound_setting = Button(panel, label="Sound")
  credit = Button(panel, label="Credit")

  info = StaticText(panel, label="1/1", style=(wAlignCenter + wAlignMiddle))
  genre = StaticText(panel, style=(wAlignCenter + wAlignMiddle))
  question = TextCtrl(panel, style=(wTeReadOnly + wTeMultiLine + wTeRich))
  option1 = Button(panel)
  option2 = Button(panel)
  option3 = Button(panel)
  option4 = Button(panel)
  prev = Button(panel, label="prev")
  next = Button(panel, label="next")


#################################################
#   メインプロシージャ
#################################################
proc main_loop() =
  reset_position()
  layout()
  showing()
  event()
  frame.center()

  echo("Show Window")
  frame.show()
  app.mainLoop()


#################################################
#   ウィンドウを閉じる処理
#################################################
proc window_close() =
  echo("Close Window")
  frame.close()


#################################################
#   通常処理
#################################################
proc layout() =
  var font_size = (frame.getsize.width + frame.getsize.height)/200

  if menu.isChecked(idLayout1):
    panel.autolayout(screen_layout.get_string("TwoChoice"))

  elif menu.isChecked(idLayout2):
    panel.autolayout(screen_layout.get_string("ThreeChoice"))

  elif menu.isChecked(idLayout3):
    panel.autolayout(screen_layout.get_string("FourChoice"))

  elif menu.isChecked(idLayout4):
    panel.autolayout(screen_layout.get_string("default"))

  elif menu.isChecked(idLayout5):
    panel.autolayout(screen_layout.get_string("MainMenu"))

  for child in getChildren(panel):
    setFont(child, Font(font_size))

proc reset_position() =
  for child in getChildren(panel):
    setPosition(child, x=0, y=0)

proc showing() =
  for child in getChildren(panel):
    if getPosition(child).x == 0:
      hide(child)
    else:
      show(child)

proc choice_quiz_store() =
  var
    quiz_data: seq[string]
    option_array: seq[string]

  quiz_data = get_quiz_data(uint8(rand(1..3)), uint8(rand(1..4)), 1)

  setTitle(title, quiz_data[1])
  setTitle(genre, quiz_data[2])
  setTitle(question, quiz_data[5])

  for i in countup(6, 6 + parseInt(quiz_data[3]) - 1):
    option_array.add(quiz_data[i])

  shuffle(option_array)

  for i in countup(6 + parseInt(quiz_data[3]), 6 + 4 - 1):
    option_array.add("")

  setTitle(option1, option_array[0])
  setTitle(option2, option_array[1])
  setTitle(option3, option_array[2])
  setTitle(option4, option_array[3])

  correct_answer = quiz_data[6]


#################################################
#   イベント処理
#################################################
proc event() =
  panel.wEvent_Size do ():
    layout()

#  frame.wEvent_KeyDown do (event: wEvent):
#    echo("KeyEvent")
#    echo wKey_M in event.getKeyStatus
#    echo($event.getKeyStatus)

  frame.idLayout1 do ():
    reset_position()
    choice_quiz_store()
    layout()
    showing()

  frame.idLayout2 do ():
    reset_position()
    choice_quiz_store()
    layout()
    showing()

  frame.idLayout3 do ():
    reset_position()
    choice_quiz_store()
    layout()
    showing()

  frame.idLayout4 do ():
    reset_position()
    layout()
    showing()

  frame.idLayout5 do ():
    reset_position()
    layout()
    showing()

  frame.idExit do (): frame.close()

  option1.wEvent_Button do ():
    selected_option = getTitle(option1)
    echo("Selected Button No." & $selected_option)

  option2.wEvent_Button do ():
    selected_option = getTitle(option2)
    echo("Selected Button No." & $selected_option)

  option3.wEvent_Button do ():
    selected_option = getTitle(option3)
    echo("Selected Button No." & $selected_option)

  option4.wEvent_Button do ():
    selected_option = getTitle(option4)
    echo("Selected Button No." & $selected_option)

  prev.wEvent_Button do ():
    echo("戻る")

    for child in getChildren(panel):
      if getPosition(child).x == 0:
        show(child)
  
  next.wEvent_Button do ():
    echo("決定")

    for child in getChildren(panel):
      if getPosition(child).x == 0:
        hide(child)

    if correct_answer == selected_option:
      echo("correct")
      setValue(question, value="正解！")

    else:
      echo("incorrect")
      setValue(question, value="不正解！")