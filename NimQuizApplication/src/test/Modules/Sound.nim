#ライブラリのインポート
import slappy

proc enable_sound*() =
  echo("Enable Sound")
  slappyInit()

proc disable_sound*() =
  echo("Disable Sound")
  slappyClose()