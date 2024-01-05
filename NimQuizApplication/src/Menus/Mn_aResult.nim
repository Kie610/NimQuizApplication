import wNim
import ../NimQuizApplication
import ../Modules/public_variables

const my_state*: MenuState = stAllResult
const prev_state*: MenuState = stSingleResult
const next_state*: MenuState = stMainMenu

var
  conPanel*: wPanel
  conTitle*: wStaticText
  conNext*: wButton

proc init*() =
  echo($my_state & " init")
  conPanel = Panel(main_frame, style=stylePanel)
  conTitle = StaticText(conPanel, label=($my_state & " TITLE"), style=styleStaticText)
  conNext = Button(conPanel, label=($my_state & " next"))

const layout_string: string = """
        HV:|[conPanel]|
        H:|-[conTitle,BOTTOM]-|
        V:|-[conTitle]-[BOTTOM(20%)]-|
        
        H:[BOTTOM:~[conNext(30%)]]"""

proc layout*(state: MenuState): wPanel {.discardable.} =
  echo($my_state & " layout" & horizontal_line)

  if my_state != now_state:
    var
      quiz_count: int = 0
      correct_count: int = 0
      quiz_all_result: string

    for quiz in quiz_list:
      if quiz.Result == true:
        correct_count = correct_count + 1
      
      quiz_count = quiz_count + 1

      echo($correct_count & " / " & $quiz_count & " 正解")

    quiz_all_result = $correct_count & " / " & $quiz_qty & " 正解"

    conTitle.setTitle(quiz_all_result)
    now_state = my_state

  echo(layout_string & horizontal_line)
  main_frame.autolayout(layout_string)
  return conPanel

proc event*() =
  echo($my_state & " event load")

  conNext.wEvent_Button do ():
    echo($my_state & " next")
    callMenu(next_state)