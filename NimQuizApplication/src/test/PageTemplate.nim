import wNim
import ../Modules/public_variables
import main


var
  panel: wPanel = Panel(main.frame, style=wDoubleBuffered)
  title: wStaticText = StaticText(panel, label="TITLE", style=styleStaticText)

const layout_string = "spacing:" & $layout_spacing & """
        H:|-[title]-|
        V:|-[title]-|"""

proc layout*() =
  panel.autolayout(layout_string)

#panel.wEvent_Size do ():
#  layout()