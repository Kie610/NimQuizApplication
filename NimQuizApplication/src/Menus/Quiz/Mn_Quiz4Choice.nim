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
  conOption4*: wButton

  conNext*: wButton

proc init*() =
  echo($my_state & " init")
  conPanel = Panel(main_frame, style=stylePanel)
  conTitle = StaticText(conPanel, label=($my_state & " TITLE"), style=styleStaticText)

  conInfo = StaticText(conPanel, label="1/1", style=styleStaticText)
  conGenre = StaticText(conPanel, style=styleStaticText)
  conQuestion = TextCtrl(conPanel, style=styleTextCtrl)
  conOption1 = Button(conPanel)
  conOption2 = Button(conPanel)
  conOption3 = Button(conPanel)
  conOption4 = Button(conPanel)

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
        H:[Options:[OPTIONSL(OPTIONSR)]-[OPTIONSR]]
        V:[OPTIONSL:[conOption1(conOption3)]-[conOption3]]
        V:[OPTIONSR:[conOption2(conOption4)]-[conOption4]]

        H:[FOOTER:-(20%)-[conGenre]-[conNext(20%)]]"""

proc layout*(state: MenuState): wPanel {.discardable.} =
  echo($my_state & " layout" & horizontal_line)

  if my_state != now_state:
    now_state = my_state

  echo(layout_string & horizontal_line)
  main_frame.autolayout(layout_string)
  return conPanel

proc event*() =
  echo($my_state & " event load")

  conNext.wEvent_Button do ():
    echo($my_state & " next")
    callMenu(next_state)