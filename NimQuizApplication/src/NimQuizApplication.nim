#モジュールのインポート
import Modules/[Graphic, Sound, DB_Connection]

when isMainModule:
  
  try:
    DB_Connection.db_open()
    Sound.enable_sound()

    Graphic.assignment()
    Graphic.main()

  finally:
    DB_Connection.db_close()
    Sound.disable_sound()
    
    Graphic.window_close()