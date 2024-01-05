#################################################
#   モジュールのインポート
#################################################
import wNim
import Modules/[public_variables, DB_Connection, Sound]

#################################################
#   変数宣言
#################################################
const i_icon = staticRead(r"images/wNim.ico")
#const i_ok = staticRead(r"images/ok.ico")
#const i_cancel = staticRead(r"images/cancel.ico")
main_frame.icon = Icon(i_icon)

#################################################
#   プロシージャ前方宣言
#################################################
proc init()
proc quiz_reset*()
proc quiz_get*()
proc quiz_result_set*()
proc initMenu()
proc callMenu*(state: MenuState, change: bool = true)
proc size_event()
proc window_open()
proc window_close()

#################################################
#   メインモジュール
#################################################
when isMainModule:
  try:
    DB_Connection.db_open()
    Sound.enable_sound()

    init()
    quiz_reset()
    initMenu()
    callMenu(stMainMenu)
    size_event()
    
    window_open()

  finally:
    DB_Connection.db_close()
    Sound.disable_sound()

    window_close()

#################################################
#   メインモジュール初期化 
#################################################
proc init() =
  echo("main_module_init")

  genre_list = get_genre_info()
  difficulty_list = get_difficulty_info()
  
#################################################
#   クイズ関連情報初期化
#################################################
proc quiz_reset*() =
  echo("quiz_reset")

  selected_genre = -1
  selected_difficulty = -1
  quiz_qty = -1
  quiz_progress = 0
  selected_option = ""

#################################################
#   クイズ関連情報取得
#################################################
proc quiz_get*() =
  echo("quiz_get")

  quiz_list = get_quiz_data(selected_genre + 1, selected_difficulty + 1, quizqty)

#################################################
#   クイズ結果格納
#################################################
proc quiz_result_set*() =
  echo("quiz_get")
  echo("Selected: " & $selected_option)
  echo("Correct: " & $quiz_list[quiz_progress].Correct_Option)

  if selected_option == quiz_list[quiz_progress].Correct_Option:
    echo("CORRECT")
    quiz_list[quiz_progress].Result = true

  quiz_list[quiz_progress].Done = true

#################################################
#   サイズイベント
#################################################
proc size_event() =
  main_frame.wEvent_Size do ():
    callMenu(now_state, false)

#################################################
#   ウィンドウを開く処理
#################################################    
proc window_open() =
  main_frame.center()
  main_frame.show()
  main_app.mainLoop()
#################################################
#   ウィンドウを閉じる処理
#################################################
proc window_close() =
  echo("Close Window")
  main_frame.close()

#################################################
#   メニュー別モジュールインポート
#################################################
import Menus/[
  Mn_MainMenu
  ,Mn_Setting
  ,Mn_AddQuiz
  ,Mn_Credit
  ,Mn_sResult
  ,Mn_aResult
  ,Mn_DifMenu
  ,Mn_Default
  ]
import Menus/Quiz/[
  Mn_Quiz2Choice
  ,Mn_Quiz3Choice
  ,Mn_Quiz4Choice
  ]

#################################################
#   メニュー別モジュール初期化
#################################################
proc initMenu() =
  Mn_MainMenu.init()
  Mn_MainMenu.event()
  Mn_MainMenu.set_info()

  Mn_Setting.init()
  Mn_Setting.event()

  Mn_AddQuiz.init()
  Mn_AddQuiz.event()

  Mn_Credit.init()
  Mn_Credit.event()

  Mn_sResult.init()
  Mn_sResult.event()

  Mn_aResult.init()
  Mn_aResult.event()

  Mn_DifMenu.init()
  Mn_DifMenu.event()
  Mn_DifMenu.set_info()

  Mn_Default.init()
  Mn_Default.event()


  Mn_Quiz2Choice.init()
  Mn_Quiz2Choice.event()

  Mn_Quiz3Choice.init()
  Mn_Quiz3Choice.event()

  Mn_Quiz4Choice.init()
  Mn_Quiz4Choice.event()

#################################################
#   メニューモジュール呼び出し
#################################################
proc callMenu*(state: MenuState, change: bool = true) =
  var show_panel: wPanel

  echo("Cought State: " & $state)

  case state
  of stMainMenu:
    show_panel = Mn_MainMenu.layout(state)

  of stSetting:
    show_panel = Mn_Setting.layout(state)

  of stAddQuiz:
    show_panel = Mn_AddQuiz.layout(state)

  of stCredit:
    show_panel = Mn_Credit.layout(state)

  of stSingleResult:
    show_panel = Mn_sResult.layout(state)

  of stAllResult:
    show_panel = Mn_aResult.layout(state)

  of stDifMenu:
    show_panel = Mn_DifMenu.layout(state)


  of stQuiz:
    var genre_name: string = genre_list[selected_genre].name

    case genre_name:
    of "2択問題":
      show_panel = Mn_Quiz2Choice.layout(state)

    of "3択問題":
      show_panel = Mn_Quiz3Choice.layout(state)

    of "4択問題":
      show_panel = Mn_Quiz4Choice.layout(state)
    
    else:
      echo("No Such Name of Quiz")


  else:
    show_panel = Mn_Default.layout(state)

  if change:
    echo("component_refresh")
    
    show(show_panel)

    for p in main_frame.children:
      if p != show_panel:
        hide(p)
  
  var panel_size: wSize = show_panel.getSize()
  for child in show_panel.getChildren():
    child.setFont(Font((panel_size.height + panel_size.width) / 150))

  echo("now_state: " & $now_state & "\n")
