import wNim
import ../Modules/public_variables
import main

const layout_string*: string = "spacing:" & $layout_spacing & """
        H:|-[title]-|
        V:|-[title]-|"""

proc layout*() =
  echo(getTitle(frame))
  setTitle(frame, "doumo")
  echo(getTitle(frame))

proc event*() =
  panel.wEvent_Size do ():
    echo("Size_Event")
    #panel.autolayout(layout_string)