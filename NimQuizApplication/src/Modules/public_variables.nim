import wNim

#################################################
#   構造体定義
#################################################
type
    MenuState* {.byref.} = enum
      stMainMenu = "MainMenu"
      stSetting = "Setting"
      stAddQuiz = "AddQuiz"
      stCredit = "Credit"
      stDifMenu = "DifMenu"
      stQuiz = "Quiz"
      stSingleResult = "sResult"
      stAllResult = "aResult"
      stDefault = "Default"

type
  MenuObject* {.byref.} = object
    state : MenuState
    prev_state : MenuState
    next_state : MenuState
    menu_frame : wFrame
    menu_panel : wPanel
    title : string
    font_point : int
    style : int
    layout_string : string

type
  GenreInfo* = tuple
    name : string
    detail : string
    genre : int
    genre_option_count : int

type
  DifficultyInfo* = tuple
    name : string
    detail : string
    difficulty : int


#################################################
#   グローバル変数宣言
#################################################
var
  main_app*: wApp = App(wSystemDpiAware)
  main_frame*: wFrame = Frame(title="テスト", size=(1280, 720))

  now_state*: MenuState = stDefault

  styleStaticText*: int = (wAlignCenter + wAlignMiddle)
  styleTextCtrl*: int = (wTeReadOnly + wTeMultiLine + wTeRich)