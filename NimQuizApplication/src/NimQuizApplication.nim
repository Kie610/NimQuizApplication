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

    get_genre_name()
    get_Difficulty_name()

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
    MenuID = enum idLayout1 = wIdUser, idLayout2, idLayout3, idExit

#################################################
#   変数代入
#################################################
proc assignment() =
  randomize()

  const
    Title = "クイズ出題アプリ"
  app = App(wSystemDpiAware)
  frame = Frame(title=Title, size=(1280, 720),)
  panel = Panel(frame, style=wDoubleBuffered)
  menubar = MenuBar(frame)

  menu = Menu(menubar, "layout")
  menu.appendRadioItem(idLayout1, "Layout1").check()
  menu.appendRadioItem(idLayout2, "Layout2")
  menu.appendRadioItem(idLayout3, "Layout3")
  menu.appendSeparator()
  menu.append(idExit, "Exit")

  title = StaticText(panel, style=(wAlignCenter + wAlignMiddle))
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
    panel.autolayout(screen_layout.get_string("FourChoice"))

  elif menu.isChecked(idLayout3):
    panel.autolayout(screen_layout.get_string("default"))

  for child in getChildren(panel):
    setFont(child, Font(font_size))

proc reset_position() =
  var
    quiz_data: seq[string]
    option_array: seq[string]
  
  quiz_data = get_quiz_data(uint8(rand(1..3)), uint8(rand(1..4)))

  setTitle(title, quiz_data[1])
  setTitle(genre, quiz_data[2])
  setTitle(question, quiz_data[5])

  for i in countup(6, 6 + parseInt(quiz_data[3]) - 1):
    option_array.add(quiz_data[i])

  echo(option_array)
  shuffle(option_array)
  echo(option_array)
  
  for i in countup(6 + parseInt(quiz_data[3]), 6 + 4 - 1):
    option_array.add("")
  
  echo(option_array)
  echo(option_array)

  setTitle(option1, option_array[0])
  setTitle(option2, option_array[1])
  setTitle(option3, option_array[2])
  setTitle(option4, option_array[3])


  correct_answer = quiz_data[6]

  for child in getChildren(panel):
    setPosition(child, x=0, y=0)

proc showing() =
  for child in getChildren(panel):
    if getPosition(child).x == 0:
      hide(child)
    else:
      show(child)


#################################################
#   イベント処理
#################################################
proc event() =
  frame.idLayout1 do ():
    reset_position()
    layout()
    showing()


  frame.idLayout2 do ():
    reset_position()
    layout()
    showing()

  frame.idLayout3 do ():
    reset_position()
    layout()
    showing()


  frame.idExit do (): frame.close()

  panel.wEvent_Size do ():layout()

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
    echo("prev")

    for child in getChildren(panel):
      if getPosition(child).x == 0:
        show(child)
  
  next.wEvent_Button do ():
    echo("next")

    for child in getChildren(panel):
      if getPosition(child).x == 0:
        hide(child)


    if correct_answer == selected_option:
      echo("correct")
      setValue(question, value="正解！")

    else:
      echo("incorrect")
      setValue(question, value="不正解！")