#メインモジュールのインポート
import ../NimQuizApplication as NQA

#ライブラリのインポート
import slappy

proc Start*() =
  echo("Sound")

  slappyInit()

  slappyClose()