import wNim
import public_const_variables

proc initMenu()
proc callMenu*(state: MenuState)
proc size_event()

import
  SettingMenu
  ,CreditMenu

when isMainModule:
  initMenu()

  callMenu(stSetting)
  size_event()

  main_frame.center()
  main_frame.show()
  main_app.mainLoop()

proc initMenu() =
  SettingMenu.init()
  CreditMenu.init()

  SettingMenu.event()
  CreditMenu.event()

proc callMenu*(state: MenuState) =
  case state
  of stSetting:
    SettingMenu.layout(state)

  of stCredit:
    CreditMenu.layout(state)

  else:
    echo("default state")

proc size_event() =
  main_frame.wEvent_Size do ():
    callMenu(now_state)