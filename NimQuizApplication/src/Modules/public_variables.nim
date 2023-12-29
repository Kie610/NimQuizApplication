#################################################
#   構造体定義
#################################################
type
    MenuState* = enum
      stMainMenu = "MainMenu"
      stSetting = "Setting"
      stAddQuiz = "AddQuiz"
      stCredit = "Credit"
      stDifMenu = "DifMenu"
      stQuiz = "Quiz"
      stSingleResult = "sResult"
      stAllResult = "aResult"
      stDefault = "Default"

#    QuizData = object
#      title: string
#      genre_name: string
#      genre_option_count: int
#      difficulty_name: string
#      question: string
#      correct_option: string
#      option_array: seq[string]
#      detail: string
#      result: bool
#      done: bool