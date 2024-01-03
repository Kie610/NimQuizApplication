import wNim
import public_const_variables

const i_icon = staticRead(r"images/wNim.ico")
const i_ok = staticRead(r"images/ok.ico")
const i_cancel = staticRead(r"images/cancel.ico")
main_frame.icon = Icon(i_icon)

proc initMenu()
proc callMenu*(state: MenuState)
proc size_event()

when isMainModule:
  initMenu()

  callMenu(stSetting)
  size_event()

  main_frame.center()
  main_frame.show()
  main_app.mainLoop()

proc size_event() =
  main_frame.wEvent_Size do ():
    callMenu(now_state)

import
  SettingMenu
  ,CreditMenu

proc initMenu() =
  SettingMenu.init()
  SettingMenu.event()
  
  CreditMenu.init()
  CreditMenu.event()

proc callMenu*(state: MenuState) =
  case state
  of stSetting:
    SettingMenu.layout(state)

  of stCredit:
    CreditMenu.layout(state)

  else:
    echo("default state")