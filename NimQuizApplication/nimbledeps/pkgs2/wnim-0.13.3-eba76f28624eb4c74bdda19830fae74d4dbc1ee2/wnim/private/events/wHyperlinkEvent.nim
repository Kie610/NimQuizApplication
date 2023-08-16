#====================================================================
#
#               wNim - Nim's Windows GUI Framework
#                 (c) Copyright 2017-2021 Ward
#
#====================================================================

## This event is generated by wHyperlinkCtrl.
#
## :Superclass:
##   `wCommandEvent <wCommandEvent.html>`_
#
## :Seealso:
##   `wHyperlinkCtrl <wHyperlinkCtrl.html>`_
#
## :Events:
##   ==============================  =============================================================
##   wHyperlinkEvent                 Description
##   ==============================  =============================================================
##   wEvent_Hyperlink                The hyperlink was clicked.
##   ==============================  =============================================================

# forward declaration
# method getEventVisited(self: wWindow, index: int): bool {.base.}

include ../pragma
import ../wBase

wEventRegister(wHyperlinkEvent):
  wEvent_Hyperlink

method getIndex*(self: wHyperlinkEvent): int {.property, inline.} =
  ## Returns the index of the hyperlink.
  let pnmLink = cast[PNMLINK](self.mLparam)
  result = pnmLink.item.iLink

method getUrl*(self: wHyperlinkEvent): string {.property, inline.} =
  ## Returns the URL of the hyperlink.
  let pnmLink = cast[PNMLINK](self.mLparam)
  result = nullTerminated($$pnmLink.item.szUrl)

method getLinkId*(self: wHyperlinkEvent): string {.property, inline.} =
  ## Returns the link ID of the hyperlink.
  let pnmLink = cast[PNMLINK](self.mLparam)
  result = nullTerminated($$pnmLink.item.szID)

method getVisited*(self: wHyperlinkEvent): bool {.property, inline.} =
  ## Returns the visited state of the hyperlink.
  result = self.mVisited
