#################################################
#ライブラリのインポート
#################################################
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

  selected_option: uint8
  correct_answer: uint8

type
    MenuID = enum idLayout1 = wIdUser, idLayout2, idLayout3, idExit

#################################################
#   変数代入
#################################################
proc assignment() =
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

  title = StaticText(panel, label="スタジオ・ララ", style=(wAlignCenter + wAlignMiddle))
  info = StaticText(panel, label="1/1", style=(wAlignCenter + wAlignMiddle))
  genre = StaticText(panel, label="〇×ゲーム", style=(wAlignCenter + wAlignMiddle))
  question = TextCtrl(panel, value="スタジオララ(旧:田中工務店)の正式名称は「Sutudio RaLa」である。〇か×か？", style=(wTeReadOnly + wTeMultiLine))
  option1 = Button(panel, label="〇")
  option2 = Button(panel, label="×")
  option3 = Button(panel, label="option3")
  option4 = Button(panel, label="option4")
  prev = Button(panel, label="prev")
  next = Button(panel, label="next")

  correct_answer = 2

#################################################
#   メインプロシージャ
#################################################
proc main_loop() =
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
    selected_option = 1
    echo("Selected Button No." & $selected_option)

  option2.wEvent_Button do ():
    selected_option = 2
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