import wNim
import ../../NimQuizApplication
import ../../Modules/public_variables

const my_state*: MenuState = stQuiz
const prev_state*: MenuState = stDifMenu
const next_state*: MenuState = stSingleResult

var
  conPanel*: wPanel
  conTitle*: wStaticText

  conInfo*: wStaticText
  conGenre*: wStaticText
  conQuestion*: wTextCtrl
  conOption1*: wButton
  conOption2*: wButton
  conOption3*: wButton

  conNext*: wButton

proc init*() =
  echo($my_state & " init")
  conPanel = Panel(main_frame, style=wDoubleBuffered)
  conTitle = StaticText(conPanel, label=($my_state & " TITLE"), style=(wAlignCenter + wAlignMiddle))

  conInfo = StaticText(conPanel, label="1/1", style=(wAlignCenter + wAlignMiddle))
  conGenre = StaticText(conPanel, style=(wAlignCenter + wAlignMiddle))
  conQuestion = TextCtrl(conPanel, style=(wTeReadOnly + wTeMultiLine + wTeRich))
  conOption1 = Button(conPanel)
  conOption2 = Button(conPanel)
  conOption3 = Button(conPanel)

  conNext = Button(conPanel, label=($my_state & " next"))

const layout_string: string = """
        HV:|[conPanel]|
        H:|-(10%)-[HEADER]-(10%)-|
        H:|-(20%)-[QUESTION]-(20%)-|
        H:|-(10%)-[OPTIONS]-(10%)-|
        H:|-(10%)-[FOOTER]-(10%)-|
        V:|-[HEADER(10%)]-[QUESTION(40%)]-[OPTIONS]-[FOOTER(10%)]-|

        H:[HEADER:-[conTitle(80%)]-[conInfo]-]

        H:[QUESTION:[conQuestion]]
        H:[OPTIONS:[conOption1(conOption2,conOption3)]-[conOption2]-[conOption3]]

        H:[FOOTER:-(20%)-[conGenre]-[conNext(20%)]]"""

proc layout*(state: MenuState): wPanel {.discardable.} =
  echo($my_state & " layout\n------------------------------------")

  if my_state != now_state:
    now_state = my_state

  echo(layout_string & "\n------------------------------------")
  main_frame.autolayout(layout_string)
  return conPanel

proc event*() =
  echo($my_state & " event load")

  conNext.wEvent_Button do ():
    echo($my_state & " next")
    callMenu(next_state)