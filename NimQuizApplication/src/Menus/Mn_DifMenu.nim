import wNim
import ../NimQuizApplication
import ../Modules/public_variables

const my_state*: MenuState = stDifMenu
const prev_state*: MenuState = stMainMenu
const next_state*: MenuState = stQuiz

var
  conPanel*: wPanel
  conTitle*: wStaticText

  conLabel*: wStaticText
  conQtyCtrl*: wSpinCtrl
  conDifficultyList*: wListBox

  conPrev*: wButton
  conNext*: wButton

proc init*() =
  echo($my_state & " init")
  conPanel = Panel(main_frame, style=stylePanel)
  conTitle = StaticText(conPanel, style=styleStaticText)

  conLabel = StaticText(conPanel, style=styleStaticText)
  conQtyCtrl = SpinCtrl(conPanel)
  conDifficultyList = ListBox(conPanel, style=styleListBox)

  conPrev = Button(conPanel)
  conNext = Button(conPanel)

  conTitle.setTitle("Difficulty Select")
  conLabel.setTitle("問題数")
  conQtyCtrl.setValue(10)
  conQtyCtrl.setRange(min=1, max=100)
  conPrev.setTitle("キャンセル")
  conNext.setTitle("決定")

proc set_info*() =
  for difficulty in difficulty_list:
    conDifficultyList.append(difficulty.name)

const layout_string: string = """
        HV:|[conPanel]|
        H:|-(10%)-[HEADER]-(10%)-|
        H:|-(10%)-[QUIZ_QTY]-(10%)-|
        H:|-(10%)-[OPTIONS]-(10%)-|
        H:|-(10%)-[FOOTER]-(10%)-|
        V:|-[HEADER(10%)]-[QUIZ_QTY(10%)]-[OPTIONS]-[FOOTER(10%)]-|

        H:[HEADER:~[conTitle(80%)]~]

        H:[QUIZ_QTY:[conLabel(20%)]-[conQtyCtrl]]
        H:[OPTIONS:[conDifficultyList]]

        H:[FOOTER:[conPrev(20%)]~[conNext(20%)]]"""

proc layout*(state: MenuState): wPanel {.discardable.} =
  echo($my_state & " layout" & horizontal_line)

  if my_state != now_state:
    conDifficultyList.deselect()
    now_state = my_state

  echo(layout_string & horizontal_line)
  main_frame.autolayout(layout_string)
  return conPanel

proc event*() =
  echo($my_state & " event load")

  conDifficultyList.wEvent_ListBox do ():
    selected_difficulty = conDifficultyList.getSelection()

    if selected_difficulty >= 0:
      echo("選択難易度 : " & $selected_difficulty & "番 : " & difficulty_list[selected_difficulty].name)

  conPrev.wEvent_Button do ():
    echo($my_state & " prev")
    callMenu(prev_state)

  conNext.wEvent_Button do ():
    echo($my_state & " next")

    quiz_qty = conQtyCtrl.getValue()

    if selected_difficulty < 0:
      MessageDialog(conPanel, "選択肢が選ばれていません").display

    else:
      echo(horizontal_line)
      echo("選択ジャンル : " & $selected_genre & "番 : " & genre_list[selected_genre].name)
      echo("選択難易度 : " & $selected_difficulty & "番 : " & difficulty_list[selected_difficulty].name)
      echo("問題数 : " & $quiz_qty & " 問")
      echo(horizontal_line)
      quiz_get()

      callMenu(next_state)