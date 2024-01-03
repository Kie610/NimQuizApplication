import wNim
import main
import public_const_variables

const my_state*: MenuState = stSetting
const prev_state*: MenuState = stCredit
const next_state*: MenuState = stCredit

var
  main_panel*: wPanel
  conTitle*: wStaticText
  conPrev*: wButton
  conNext*: wButton

proc init*() =
  echo("PageTemplate")
  main_panel = Panel(main_frame, style=wDoubleBuffered)
  conTitle = StaticText(main_panel, label="TITLE1", style=(wAlignCenter + wAlignMiddle))
  conPrev = Button(main_panel, label="prev1")
  conNext = Button(main_panel, label="next1")

  echo(getTitle(conTitle))

const layout_string: string = """
        HV:|[main_panel]|
        H:|-[conTitle,BOTTOM]-|
        V:|-[conTitle]-[BOTTOM(20%)]-|
        
        H:[BOTTOM:[conPrev(conNext,30%)]~[conNext]]"""

proc layout*(state: MenuState) =
  echo("layout1")

  if my_state != now_state:
    echo("component_refresh1")
    for p in main_frame.children:
      if p == main_panel:
        show(p)
      else:
        hide(p)

    now_state = my_state

  echo("autolayout1")
  echo(layout_string)
  main_frame.autolayout(layout_string)

proc event*() =
  echo("event1")

#  main_panel.wEvent_Size do ():
#    echo("size1")
#    layout(my_state)

  conPrev.wEvent_Button do ():
    echo("prev1")
    callMenu(prev_state)

  conNext.wEvent_Button do ():
    echo("next1")
    callMenu(next_state)