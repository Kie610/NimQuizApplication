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

  conPanel = Panel(main_frame, style=stylePanel)
  conTitle = StaticText(conPanel, style=styleStaticText)

  conGenreList = ListBox(conPanel, style=styleListBox)
  conDetail = TextCtrl(conPanel, style=styleTextCtrl)
  conSetting = Button(conPanel)
  conAddQuiz = Button(conPanel)
  conCredit = Button(conPanel)

  conNext = Button(conPanel)

  conTitle.setTitle("Main Menu")
  conSetting.setTitle("Setting")
  conAddQuiz.setTitle("Add Quiz")
  conCredit.setTitle("Credit")
  conNext.setTitle("Confirm")

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
  echo($my_state & " layout" & horizontal_line)

  if my_state != now_state:
    now_state = my_state

  echo(layout_string & horizontal_line)
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