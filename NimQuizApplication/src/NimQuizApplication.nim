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
proc layout_change()
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

    assignment()
    main_loop()

  finally:
    DB_Connection.db_close()
    Sound.disable_sound()

    window_close()


#################################################
#   構造体定義
#################################################
type
    MenuID = enum
      idTwoChoice = wIdUser, idManualChoice, idThreeChoice, idFourChoice, idOnlyTitle, idMainMenu, idExit

    MenuState = enum
      stMainMenu = 1
      stSetting = 2
      stCredit = 3
      stDifMenu = 4
      stQuiz = 5
      stSingleResult = 6
      stAllResult = 7

    QuizData {.pure.} = object
      title: string
      question: string
      correct_option: string
      option_array: seq[string]
      detail: string
      result: bool


#################################################
#   変数宣言
#################################################
var
  app: wApp
  frame: wFrame
  panel: wPanel
  menubar: wMenuBar

  menu: wMenu

  title: wStaticText
  genre_list: wListBox
  difficulty_list: wListBox
  quiz_qtyspinctrl: wSpinCtrl
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

  genre_table: seq[seq[string]]
  difficulty_table: seq[seq[string]]

  selected_genre: uint8
  selected_difficulty: uint8
  quiz_quantity: uint8

  quiz_data:seq[QuizData]

  now_state: MenuState


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
  menu.appendRadioItem(idManualChoice, "ManualChoice")
  menu.appendRadioItem(idTwoChoice, "TwoChoice")
  menu.appendRadioItem(idThreeChoice, "ThreeChoice")
  menu.appendRadioItem(idFourChoice, "FourChoice")
  menu.appendRadioItem(idOnlyTitle, "OnlyTitle").check()
  menu.appendRadioItem(idMainMenu, "MainMenu")
  menu.appendSeparator()
  menu.append(idExit, "Exit")

  title = StaticText(panel, label="MainMenu", style=(wAlignCenter + wAlignMiddle))
  genre_list = ListBox(panel, style=(wLbSingle))
  difficulty_list = ListBox(panel, style=(wLbSingle))
  quiz_qtyspinctrl = SpinCtrl(panel, value=10)
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

  now_state = stMainMenu

  genre_table = get_genre_info()

  for row in genre_table:
    genre_list.append(row[0])
  
  difficulty_table = get_difficulty_info()

  for row in difficulty_table:
    difficulty_list.append(row[0])


#################################################
#   メインプロシージャ
#################################################
proc main_loop() =
  reset_position()
  layout_change()
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
#   レイアウト変更時処理
#################################################
proc layout_change() =
  frame.idManualChoice do ():
    reset_position()
    choice_quiz_store()
    layout()
    showing()

  frame.idTwoChoice do ():
    reset_position()
    choice_quiz_store()
    layout()
    showing()

  frame.idThreeChoice do ():
    reset_position()
    choice_quiz_store()
    layout()
    showing()

  frame.idFourChoice do ():
    reset_position()
    choice_quiz_store()
    layout()
    showing()

  frame.idOnlyTitle do ():
    reset_position()
    layout()
    showing()

  frame.idMainMenu do ():
    reset_position()
    layout()
    showing()

  frame.idExit do (): frame.close()


#################################################
#   通常処理
#################################################
proc layout() =
  var
    font_size: float32 = (frame.getsize.width + frame.getsize.height)/200

  if menu.isChecked(idManualChoice):
    panel.autolayout(screen_layout.get_string("DifMenu"))

  elif menu.isChecked(idTwoChoice):
    panel.autolayout(screen_layout.get_string("TwoChoice"))

  elif menu.isChecked(idThreeChoice):
    panel.autolayout(screen_layout.get_string("ThreeChoice"))

  elif menu.isChecked(idFourChoice):
    panel.autolayout(screen_layout.get_string("FourChoice"))

  elif menu.isChecked(idOnlyTitle):
    panel.autolayout(screen_layout.get_string("default"))

  elif menu.isChecked(idMainMenu):
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

  quiz_data = get_quiz_data(uint8(rand(1..3)), uint8(rand(1..4)), 1)[0]

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

  panel.wEvent_KeyDown do (event: wEvent):
    echo("panelKeyEvent")
    echo wKey_M in event.getKeyStatus
    echo($event.getKeyStatus)

  genre_list.wEvent_ListBox do ():
    echo("SelectedItem" & $genre_list.getSelection())
    setTitle(detail, genre_table[genre_list.getSelection()][1])

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
  
  next.wEvent_Button do ():
    echo("決定")

    case now_state
    of stMainMenu:
      now_state = stDifMenu

      selected_genre = uint8(genre_list.getSelection())

    of stDifMenu:
      now_state = stQuiz
      
      selected_difficulty = uint8(difficulty_list.getSelection())
      quiz_quantity = uint8(quiz_qtyspinctrl.getValue())

      for quiz_row in get_quiz_data(uint8(selected_genre), uint8(selected_difficulty), quiz_quantity):
        var
          row_data: QuizData

        row_data.title = quiz_row[1]
        row_data.question = quiz_row[5]
        row_data.correct_option = quiz_row[6]
        row_data.option_array = @[quiz_row[6],quiz_row[7],quiz_row[8],quiz_row[9]]
        row_data.detail = quiz_row[10]
        row_data.result = false

        quiz_data.add(row_data)

      echo(quiz_data)

    of stQuiz:
      if correct_answer == selected_option:
        echo("correct")
        setValue(question, value="正解！")

      else:
        echo("incorrect")
        setValue(question, value="不正解！")

    else:
      echo("else")