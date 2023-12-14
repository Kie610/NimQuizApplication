#ライブラリのインポート
import db_connector/db_sqlite
var db: DbConn

proc db_open*() =
  echo("Open DB")
  let db = open("Data/QUIZ_DATABASE.db", "", "", "")

  db.exec(
    sql"""CREATE TABLE IF NOT EXISTS QUIZ_TABLE (
      id    INTEGER PRIMARY KEY,
      name  VARCHAR(50) NOT NULL,
      i     INT(11),
      f     DECIMAL(18, 10)
    )"""
  )

proc db_close*() =
  echo("Close DB")
  db.close()