import wNim
import ../NimQuizApplication
import ../Modules/public_variables

const my_state*: MenuState = stSingleResult
const prev_state*: MenuState = stQuiz
const next_state*: MenuState = stAllResult

var
  conPanel*: wPanel
  conTitle*: wStaticText
  conPrev*: wButton
  conNext*: wButton

proc init*() =
  echo($my_state & " init")
  conPanel = Panel(main_frame, style=stylePanel)
  conTitle = StaticText(conPanel, label=($my_state & " TITLE"), style=styleStaticText)
  conPrev = Button(conPanel, label=($my_state & " prev"))
  conNext = Button(conPanel, label=($my_state & " next"))

const layout_string: string = """
        HV:|[conPanel]|
        H:|-[conTitle,BOTTOM]-|
        V:|-[conTitle]-[BOTTOM(20%)]-|
        
        H:[BOTTOM:[conPrev(conNext,30%)]~[conNext]]"""

proc layout*(state: MenuState): wPanel {.discardable.} =
  echo($my_state & " layout" & horizontal_line)

  if my_state != now_state:
    conTitle.setTitle(quiz_list[quiz_progress].Detail)
    now_state = my_state

  echo(layout_string & horizontal_line)
  main_frame.autolayout(layout_string)
  return conPanel

proc event*() =
  echo($my_state & " event load")

  conPrev.wEvent_Button do ():
    echo($my_state & " prev")
    callMenu(prev_state)

  conNext.wEvent_Button do ():
    echo($my_state & " next")

    quiz_progress = quiz_progress + 1

    if quiz_progress < quiz_qty:
      callMenu(prev_state)

    else:
      callMenu(next_state)