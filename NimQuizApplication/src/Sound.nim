#ライブラリのインポート
import slappy

proc Start*() =
  echo("Sound")

  slappyInit()

  slappyClose()