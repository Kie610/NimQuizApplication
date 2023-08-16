#ライブラリのインポート
import db_connector/db_sqlite

proc Start*() =
  echo("DB_Connection")

  let db = open("Data/QUIZ_DATABASE.db", "", "", "")

  db.exec(sql"""CREATE TABLE IF NOT EXISTS QUIZ_TABLE (
    id    INTEGER PRIMARY KEY,
    name  VARCHAR(50) NOT NULL,
    i     INT(11),
    f     DECIMAL(18, 10)
  )""")

  db.close()