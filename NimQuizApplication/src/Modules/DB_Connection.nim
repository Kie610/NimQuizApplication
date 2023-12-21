#ライブラリのインポート
import db_connector/db_sqlite
var db: DbConn

proc db_open*() =
  echo("Open DB")
  db = open("Data/QUIZ_DATABASE.db", "", "", "")

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
  var genre_name: seq[Row]
  
  genre_name = db.getAllRows(sql"SELECT Genre_Name,Genre_Detail,Genre FROM M_GENRE_MASTER")

  for row in genre_name:
    for item in row:
      echo(item)

proc get_Difficulty_name*() =
  var difficulty_name: seq[Row]
  
  difficulty_name = db.getAllRows(sql"SELECT Difficulty_Name,Difficulty_Detail,Difficulty FROM M_DIFFICULTY_MASTER")

  for row in difficulty_name:
    for item in row:
      echo(item)
