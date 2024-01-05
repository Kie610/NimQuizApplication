import wNim

#################################################
#   型定義
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

type
  QuizInfo* = tuple
      ID : int
      Title : string
      Genre_Name : string
      Genre_Option_Count : int
      Difficulty_Name : string
      Question : string
      Correct_Option : string 
      Option1 : string
      Option2 : string
      Option3 : string
      Option4 : string
      Detail : string
      Done : bool
      Result : bool


#################################################
#   グローバル変数宣言
#################################################
var
  horizontal_line*: string = "\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="

  main_app*: wApp = App(wSystemDpiAware)
  main_frame*: wFrame = Frame(title="テスト", size=(1280, 720))

  genre_list*: seq[GenreInfo]
  difficulty_list*: seq[DifficultyInfo]
  quiz_list*: seq[QuizInfo]

  now_state*: MenuState = stDefault
  selected_genre*: int
  selected_difficulty*: int
  quiz_qty*: int
  quiz_progress*: int
  selected_option*: string

  stylePanel*: int = (wDoubleBuffered)
  styleStaticText*: int = (wAlignCenter + wAlignMiddle)
  styleTextCtrl*: int = (wTeReadOnly + wTeMultiLine + wTeRich)
  styleListBox*: int = (wLbSingle)