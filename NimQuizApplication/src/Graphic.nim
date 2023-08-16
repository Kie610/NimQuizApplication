#ライブラリのインポート
import wNim

proc Start*() =
  echo("Graphic")

  let app = App()
  let frame = Frame(title="Hello World", size=(1600, 900))

  frame.center()
  frame.show()
  app.mainLoop()