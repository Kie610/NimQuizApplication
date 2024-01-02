import wNim
import ../Modules/public_variables
import main

const my_state*: MenuState = stSetting
const prev_state*: MenuState = stCredit
const next_state*: MenuState = stCredit

const layout_string: string = "spacing:" & $layout_spacing & """
        H:|-[conTitle,BOTTOM]-|
        V:|-[conTitle]-[BOTTOM(20%)]-|
        
        H:[BOTTOM:[conPrev(conNext,30%)]~[conNext]]"""

proc layout*(state: MenuState)

proc init*() =
  echo("PageTemplate")

  echo(getTitle(conTitle))

proc layout*(state: MenuState) =
  echo("layout1")

  if my_state != now_state:
    echo("component_refresh")
    now_state = my_state

  
  main_panel.autolayout(layout_string)

proc event*() =
  echo("event1")

  main_panel.wEvent_Size do ():
    echo("size1")
    layout(my_state)

  conPrev.wEvent_Button do ():
    echo("prev1")
    callMenu(prev_state)

  conNext.wEvent_Button do ():
    echo("next1")
    callMenu(next_state)