import wNim
import main
import public_const_variables

const my_state*: MenuState = stCredit
const prev_state*: MenuState = stSetting
const next_state*: MenuState = stSetting

var
  main_panel*: wPanel
  conTitle*: wStaticText
  conPrev*: wButton
  conNext*: wButton

proc init*() =
  echo("PageTemplate2")
  main_panel = Panel(main_frame, style=wDoubleBuffered)
  conTitle = StaticText(main_panel, label="TITLE2", style=(wAlignCenter + wAlignMiddle))
  conPrev = Button(main_panel, label="prev2")
  conNext = Button(main_panel, label="next2")

  echo(getTitle(conTitle))

const layout_string: string = """
        HV:|[main_panel]|
        H:|-[conTitle,BOTTOM]-|
        V:|-[conTitle]-[BOTTOM(20%)]-|
        
        H:[BOTTOM:[conPrev(conNext,30%)]~[conNext]]"""

proc layout*(state: MenuState) =
  echo("layout2")

  if my_state != now_state:
    echo("component_refresh2")
    for p in main_frame.children:
      if p == main_panel:
        show(p)
      else:
        hide(p)

    now_state = my_state

  echo("autolayout2")
  echo(layout_string)
  main_frame.autolayout(layout_string)

proc event*() =
  echo("event2")

#  main_panel.wEvent_Size do ():
#    echo("size2")
#    layout(my_state)

  conPrev.wEvent_Button do ():
    echo("prev2")
    callMenu(prev_state)

  conNext.wEvent_Button do ():
    echo("next2")
    callMenu(next_state)