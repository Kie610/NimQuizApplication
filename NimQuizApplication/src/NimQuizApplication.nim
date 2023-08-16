import wNim, slappy, db_connector/db_sqlite

when isMainModule:
  echo("Hello, World!")

  let db = open("testdatabase.db", "", "", "")

  db.exec(sql"""CREATE TABLE IF NOT EXISTS my_table (
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