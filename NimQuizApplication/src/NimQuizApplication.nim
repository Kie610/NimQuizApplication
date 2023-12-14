#ライブラリのインポート
import std/os

#メインモジュールのアドレス取得
let cwd* = os.getCurrentDir()

#モジュールのインポート
import Modules/[Graphic, Sound, DB_connection]

when isMainModule:
  DB_connection.Start()
  Graphic.Main()
