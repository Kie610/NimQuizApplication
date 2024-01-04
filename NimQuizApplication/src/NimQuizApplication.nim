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

var
  genre_list: seq[GenreInfo]
  difficulty_list: seq[DifficultyInfo]

#################################################
#   プロシージャ前方宣言
#################################################
proc init()
proc initMenu()
proc callMenu*(state: MenuState, change: bool = true, quiz_genre_name: string = "2択問題")
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

  echo(get_quiz_data(2, 2, 10))


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
proc callMenu*(state: MenuState, change: bool = true, quiz_genre_name: string = "2択問題") =
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

    case quiz_genre_name:
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

  echo("now_state: " & $now_state & "\n")
