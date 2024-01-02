import wNim
import ../Modules/public_variables
import main

const my_state*: MenuState = stCredit
const prev_state*: MenuState = stSetting
const next_state*: MenuState = stSetting

const layout_string2: string = "spacing:" & $layout_spacing & """
        H:|-[conTitle2,BOTTOM]-|
        V:|-[conTitle2]-[BOTTOM(20%)]-|
        
        H:[BOTTOM:[conPrev(conNext,30%)]~[conNext]]"""

proc layout*(state: MenuState)

proc init*() =
  echo("PageTemplate2")

  echo(getTitle(conTitle2))

proc layout*(state: MenuState) =
  echo("layout2")

  if my_state != now_state:
    echo("component_refresh")
    now_state = my_state

  
  main_panel.autolayout(layout_string2)

proc event*() =
  echo("event2")

  main_panel.wEvent_Size do ():
    echo("size2")
    layout(my_state)

  conPrev.wEvent_Button do ():
    echo("prev2")
    callMenu(prev_state)

  conNext.wEvent_Button do ():
    echo("next2")
    callMenu(next_state)