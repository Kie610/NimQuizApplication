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

  conBackground*: wStaticBitmap

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

  conBackground = StaticBitmap(conPanel, bitmap=Bitmap(imgBackground), style=styleStaticBitmap)

proc set_info*() =
  for genre in genre_list:
    conGenreList.append(genre.name)

const layout_string: string = """
        HV:|[conPanel]|
        HV:|[conBackground]|
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
    quiz_reset()
    conGenreList.deselect()
    conDetail.setTitle("")
    now_state = my_state

  echo(layout_string & horizontal_line)
  main_frame.autolayout(layout_string)
  return conPanel

proc event*() =
  echo($my_state & " event load")

  conGenreList.wEvent_ListBox do ():
    selected_genre = conGenreList.getSelection()

    if selected_genre >= 0:
      conDetail.setTitle(genre_list[selected_genre].detail)
      echo("選択ジャンル : " & $selected_genre & "番 : " & genre_list[selected_genre].name)

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

    if selected_genre < 0:
      MessageDialog(conPanel, "選択肢が選ばれていません").display
      
    else:
      echo(horizontal_line)
      echo("選択ジャンル : " & $selected_genre & "番 : " & genre_list[selected_genre].name)
      echo(horizontal_line)
      callMenu(next_state)