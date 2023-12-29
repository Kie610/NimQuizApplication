#################################################
#ライブラリのインポート
#################################################
import std/[random, strutils]
import wNim


#################################################
#モジュールのインポート
#################################################
import Modules/[public_variables, screen_layout, Sound, DB_Connection]


#################################################
#   プロシージャ前方宣言
#################################################
proc main_loop()
proc assignment()
proc window_close()
proc reset_position()
proc quiz_reset()
proc set_quiz_data(quiz_number: int)
proc layout(state: MenuState, quiz_genre: string = "", quiz_number: int = -1)
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
    QuizData = object
      title: string
      genre_name: string
      genre_option_count: int
      difficulty_name: string
      question: string
      correct_option: string
      option_array: seq[string]
      detail: string
      result: bool
      done: bool


#################################################
#   変数宣言
#################################################
var
  app: wApp
  frame: wFrame
  panel: wPanel
  menubar: wMenuBar

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

  selected_genre: int
  selected_genre_name: string
  selected_difficulty: int
  selected_difficulty_name: string
  quiz_quantity: int

  quiz_data:seq[QuizData]
  quiz_progress: int

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

  title = StaticText(panel, label="MainMenu", style=(wAlignCenter + wAlignMiddle))
  genre_list = ListBox(panel, style=(wLbSingle))
  difficulty_list = ListBox(panel, style=(wLbSingle))
  quiz_qtyspinctrl = SpinCtrl(panel, value=10)
  quiz_qtyspinctrl.setRange(min=1, max=100)
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

  now_state = stDefault

  genre_table = get_genre_info()

  for row in genre_table:
    genre_list.append(row[0])
  
  difficulty_table = get_difficulty_info()

  for row in difficulty_table:
    difficulty_list.append(row[0])

proc quiz_reset() =
  selected_option = ""
  correct_answer = ""

  selected_genre = 0
  selected_genre_name = ""
  selected_difficulty = 0
  selected_difficulty_name = ""
  quiz_quantity = 0

  quiz_data = newSeq[QuizData]()
  quiz_progress = 0

  setTitle(detail, "")


#################################################
#   メインプロシージャ
#################################################
proc main_loop() =
  quiz_reset()
  reset_position()
  layout(stMainMenu)
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
proc layout(state: MenuState, quiz_genre: string = "", quiz_number: int = -1) =  
  if state != now_state:
    reset_position()
    if state == stMainMenu:
      quiz_reset()
    if quiz_number != -1:
      set_quiz_data(quiz_number)

  case state
  of stMainMenu:
    panel.autolayout(screen_layout.get_string(stMainMenu))

  of stSetting:
    panel.autolayout(screen_layout.get_string(stSetting))
    
  of stCredit:
    panel.autolayout(screen_layout.get_string(stCredit))
    
  of stDifMenu:
    panel.autolayout(screen_layout.get_string(stDifMenu))
    
  of stQuiz:
    case quiz_genre
    of "2択問題":
      panel.autolayout(screen_layout.get_string(stQuiz, "2択問題"))
    
    of "3択問題":
      panel.autolayout(screen_layout.get_string(stQuiz, "3択問題"))

    of "4択問題":
      panel.autolayout(screen_layout.get_string(stQuiz, "4択問題"))
    
  of stSingleResult:
    panel.autolayout(screen_layout.get_string(stSingleResult))
    
  of stAllResult:
    panel.autolayout(screen_layout.get_string(stAllResult))
    
  else:
    panel.autolayout(screen_layout.get_string(stDefault))
    
  if state != now_state:
    showing()

  now_state = state

  var
    font_size: float32 = (frame.getsize.width + frame.getsize.height)/200

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

proc set_quiz_data(quiz_number: int) =
  setTitle(title, quiz_data[quiz_number].title)
  setTitle(genre, quiz_data[quiz_number].genre_name)
  setTitle(question, quiz_data[quiz_number].question)

  setTitle(option1, quiz_data[quiz_number].option_array[0])
  setTitle(option2, quiz_data[quiz_number].option_array[1])
  setTitle(option3, quiz_data[quiz_number].option_array[2])
  setTitle(option4, quiz_data[quiz_number].option_array[3])
  echo(quiz_data[quiz_number].option_array)

  correct_answer = quiz_data[quiz_number].correct_option


#################################################
#   イベント処理
#################################################
proc event() =
  panel.wEvent_Size do ():
    layout(now_state)

  panel.wEvent_KeyDown do (event: wEvent):
    echo("panelKeyEvent")
    echo wKey_M in event.getKeyStatus
    echo($event.getKeyStatus)

  genre_list.wEvent_ListBox do ():
    echo("SelectedItem" & $genre_list.getSelection())
    echo("SelectedItemName" & genre_list.getText(genre_list.getSelection()))
    setTitle(detail, genre_table[genre_list.getSelection()][1])
  
  difficulty_list.wEvent_ListBox do ():
    echo("SelectedItem" & $difficulty_list.getSelection())
    echo("SelectedItemName" & difficulty_list.getText(difficulty_list.getSelection()))

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

    case now_state
    of stDifMenu:
      layout(stMainMenu)

    of stSingleResult:
      layout(stQuiz, selected_genre_name, quiz_progress)

    else:
      echo("nothing")
  
  next.wEvent_Button do ():
    echo("決定")

    case now_state
    of stMainMenu:
      if genre_list.getSelection() < 0:
        MessageDialog(panel, "クイズジャンルが選択されていません").display
        
      else:
        selected_genre = genre_list.getSelection() + 1
        echo("SelectedGenre:" & $selected_genre)

        selected_genre_name = genre_list.getText(genre_list.getSelection())
        echo(selected_genre_name)

        setTitle(detail, "問題数")

        layout(stDifMenu)

    of stDifMenu:
      if difficulty_list.getSelection() < 0:
        MessageDialog(panel, "難易度が選択されていません").display
        
      else:
        selected_difficulty = difficulty_list.getSelection() + 1
        echo("SelectedDifficulty:" & $selected_difficulty)

        selected_difficulty_name = difficulty_list.getText(difficulty_list.getSelection())
        echo(selected_difficulty_name)

        quiz_quantity = quiz_qtyspinctrl.getValue()
        echo("Quiz_Quantity:" & $quiz_qtyspinctrl.getValue())

        for quiz_row in get_quiz_data(selected_genre, selected_difficulty, quiz_quantity):
          var
            row_data: QuizData

          row_data.title = quiz_row[1]
          row_data.genre_name = quiz_row[2]
          row_data.genre_option_count = parseInt(quiz_row[3])
          row_data.difficulty_name = quiz_row[4]
          row_data.question = quiz_row[5]
          row_data.correct_option = quiz_row[6]

          var
            option_count: int = parseInt(quiz_row[3])
            option_array: seq[string]

          for i in countup(6, 6 + option_count - 1):
            option_array.add(quiz_row[i])

          shuffle(option_array)

          for i in countup(6 + option_count, 6 + 4 - 1):
            option_array.add("")

          setTitle(option1, option_array[0])
          setTitle(option2, option_array[1])
          setTitle(option3, option_array[2])
          setTitle(option4, option_array[3])
          echo(option_array)

          row_data.option_array = @[option_array[0], option_array[1], option_array[2], option_array[3]]
          row_data.detail = quiz_row[10]
          row_data.result = false
          row_data.done = false

          quiz_data.add(row_data)

        echo(quiz_data)
        quiz_quantity = quiz_data.len

        quiz_progress = 0
        layout(stQuiz, selected_genre_name, quiz_progress)

    of stQuiz:
      if quiz_data[quiz_progress].done == false and selected_option == "":
        MessageDialog(panel, "選択肢が選ばれていません").display
      
      else:
        layout(stSingleResult)

        if quiz_data[quiz_progress].done == false:
          quiz_data[quiz_progress].done = true

          echo("correct_option" & quiz_data[quiz_progress].correct_option)
          echo("selected_option" & selected_option)

          if quiz_data[quiz_progress].correct_option == selected_option:
            echo("correct")
            setTitle(title, "正解！")
            quiz_data[quiz_progress].result = true

          else:
            echo("incorrect")
            setTitle(title, "不正解！")
            quiz_data[quiz_progress].result = false

        else:
          if quiz_data[quiz_progress].result:
            echo("correct")
            setTitle(title, "正解！")

          else:
            echo("incorrect")
            setTitle(title, "不正解！")

    of stSingleResult:
      selected_option = ""
      quiz_progress = quiz_progress + 1

      if quiz_progress < quiz_quantity:
        echo($(quiz_progress) & " : " & $quiz_quantity)
        layout(stQuiz, selected_genre_name, quiz_progress)

        echo("quiz_progress:" & $quiz_progress)
      
      else:
        var
          correct_count: int = 0
          all_result: string
        
        for correction in quiz_data:
          echo("result" & $correction.result)
          if correction.result == true:
            correct_count = correct_count + 1

          echo($correct_count & " / " & $quiz_quantity)
        
        all_result = $correct_count & " / " & $quiz_quantity

        setTitle(title, all_result)
        layout(stAllResult)


    of stAllResult:
      layout(stMainMenu)


    else:
      echo("else")