#ライブラリのインポート
import wNim, slappy, db_connector/db_sqlite

#プログラムファイルのインポート
import Initialize

when isMainModule:
  Initialize.Start()

  echo("Hello, World!")

  let db = open("Data/QUIZ_DATABASE.db", "", "", "")

  db.exec(sql"""CREATE TABLE IF NOT EXISTS QUIZ_TABLE (
    id    INTEGER PRIMARY KEY,
    name  VARCHAR(50) NOT NULL,
    i     INT(11),
    f     DECIMAL(18, 10)
  )""")

  db.close()

  slappyInit()

  slappyClose()

  let app = App()
  let frame = Frame(title="Hello World", size=(1600, 900))

  frame.center()
  frame.show()
  app.mainLoop()