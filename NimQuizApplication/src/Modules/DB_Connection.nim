#ライブラリのインポート
import db_connector/db_sqlite
var db: DbConn

proc db_open*() =
  echo("Open DB")
  let db = open("Data/QUIZ_DATABASE.db", "", "", "")

  db.exec(sql"""CREATE TABLE IF NOT EXISTS T_QUIZ_TABLE (
      ID      INTEGER PRIMARY KEY AUTOINCREMENT
      ,Genre   INTEGER
      ,Difficulity    INTEGER
      ,Title          TEXT
      ,Question       TEXT
      ,Option1        TEXT
      ,Option2        TEXT
      ,Option3        TEXT
      ,Option4        TEXT
      ,Detail         TEXT
      ,AddDT        TIMESTAMP DEFAULT (DATETIME(CURRENT_TIMESTAMP,'localtime'))
      ,UpDT         TIMESTAMP
    )""")

proc db_close*() =
  echo("Close DB")
  db.close()

proc get_genre_name*() =
  getAllRows(db, """SELECT""")