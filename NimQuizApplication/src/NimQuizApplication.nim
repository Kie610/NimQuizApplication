#プログラムファイルのインポート
import Initialize, DB_Connection, Graphic, Sound

when isMainModule:
  Initialize.Start()
  DB_Connection.Start()
  Sound.Start()
  Graphic.Start()

  echo("Hello, World!")