import wNim
import ../NimQuizApplication
import ../Modules/public_variables

const my_state*: MenuState = stMainMenu
const prev_state*: MenuState = stDefault
const next_state*: MenuState = stDifMenu
var
  conPanel*: wPanel
  conTitle*: wStaticText

  conGenreList*: wListBox
  conDetail*: wTextCtrl
  conSetting*: wButton
  conAddQuiz*: wButton
  conCredit*: wButton

  conNext*: wButton

proc init*() =
  echo($my_state & " init")

  conPanel = Panel(main_frame, style=wDoubleBuffered)
  conTitle = StaticText(conPanel, label="MainMenu", style=(wAlignCenter + wAlignMiddle))

  conGenreList = ListBox(conPanel, style=(wLbSingle))
  conDetail = TextCtrl(conPanel, style=(wTeReadOnly + wTeMultiLine + wTeRich))
  conSetting = Button(conPanel, label="Setting")
  conAddQuiz = Button(conPanel, label="Add Quiz")
  conCredit = Button(conPanel, label="Credit")

  conNext = Button(conPanel, label="next")

const layout_string: string = """
        HV:|[conPanel]|
        H:|-(10%)-[HEADER]-(10%)-|
        H:|-(10%)-[GENRES(50%)]-[OPTIONS]-(10%)-|
        H:|-(10%)-[FOOTER]-(10%)-|
        V:|-[HEADER(10%)]-[GENRES,OPTIONS]-[FOOTER(10%)]-|

        H:[HEADER:[conTitle]]

        V:[GENRES:[conGenreList]]
        V:[OPTIONS:[conDetail]-[conSetting(conAddQuiz,conCredit,10%)]-[conAddQuiz]-[conCredit]]

        H:[FOOTER:~[conNext(20%)]]"""

proc layout*(state: MenuState): wPanel {.discardable.} =
  echo($my_state & " layout\n------------------------------------")

  if my_state != now_state:
    now_state = my_state

  echo(layout_string & "\n------------------------------------")
  main_frame.autolayout(layout_string)
  return conPanel

proc event*() =
  echo($my_state & " event load")

  conSetting.wEvent_Button do ():
    echo($my_state & " SettingButton")
    callMenu(stSetting)

  conAddQuiz.wEvent_Button do ():
    echo($my_state & " AddQuizButton")
    callMenu(stAddQuiz)

  conCredit.wEvent_Button do ():
    echo($my_state & " CreditButton")
    callMenu(stCredit)

  conNext.wEvent_Button do ():
    echo($my_state & " nextButton")
    callMenu(next_state)