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
    state: MenuState
    prev_state: MenuState
    next_state: MenuState
    menu_frame: wFrame
    menu_panel: wPanel
    title: string
    font_point: int
    style: int
    layout_string: string


#################################################
#   グローバル変数宣言
#################################################
var
  styleStaticText*: int = (wAlignCenter + wAlignMiddle)
  styleTextCtrl*: int = (wTeReadOnly + wTeMultiLine + wTeRich)

const
  layout_spacing*: int = 8