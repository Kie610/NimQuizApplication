import wNim
import ../NimQuizApplication
import ../Modules/public_variables

const my_state*: MenuState = stDifMenu
const prev_state*: MenuState = stMainMenu
const next_state*: MenuState = stQuiz

var
  conPanel*: wPanel
  conTitle*: wStaticText

  conDetail*: wTextCtrl
  conQtyCtrl*: wSpinCtrl
  conDifficultyList*: wListBox

  conPrev*: wButton
  conNext*: wButton

proc init*() =
  echo($my_state & " init")
  conPanel = Panel(main_frame, style=wDoubleBuffered)
  conTitle = StaticText(conPanel, label=($my_state & " TITLE"), style=(wAlignCenter + wAlignMiddle))

  conDetail = TextCtrl(conPanel, style=(wTeReadOnly + wTeMultiLine + wTeRich))
  conQtyCtrl = SpinCtrl(conPanel, value=10)
  conQtyCtrl.setRange(min=1, max=100)
  conDifficultyList = ListBox(conPanel, style=(wLbSingle))

  conPrev = Button(conPanel, label=($my_state & " prev"))
  conNext = Button(conPanel, label=($my_state & " next"))

const layout_string: string = """
        HV:|[conPanel]|
        H:|-(10%)-[HEADER]-(10%)-|
        H:|-(10%)-[QUIZ_QTY]-(10%)-|
        H:|-(10%)-[OPTIONS]-(10%)-|
        H:|-(10%)-[FOOTER]-(10%)-|
        V:|-[HEADER(10%)]-[QUIZ_QTY(10%)]-[OPTIONS]-[FOOTER(10%)]-|

        H:[HEADER:~[conTitle(80%)]~]

        H:[QUIZ_QTY:[conDetail(20%)]-[conQtyCtrl]]
        H:[OPTIONS:[conDifficultyList]]

        H:[FOOTER:[conPrev(20%)]~[conNext(20%)]]"""

proc layout*(state: MenuState): wPanel {.discardable.} =
  echo($my_state & " layout\n------------------------------------")

  if my_state != now_state:
    now_state = my_state

  echo(layout_string & "\n------------------------------------")
  main_frame.autolayout(layout_string)
  return conPanel

proc event*() =
  echo($my_state & " event load")

  conPrev.wEvent_Button do ():
    echo($my_state & " prev")
    callMenu(prev_state)

  conNext.wEvent_Button do ():
    echo($my_state & " next")
    callMenu(next_state)