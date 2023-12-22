#ライブラリのインポート
import std/random
import db_connector/db_sqlite

var db: DbConn
randomize()

proc db_open*() =
  echo("Open DB")
  db = open("Data/QUIZ_DATABASE.db", "", "", "")

  db.exec(sql"""CREATE TABLE IF NOT EXISTS T_QUIZ_TABLE (
      ID      INTEGER PRIMARY KEY AUTOINCREMENT
      ,Genre   INTEGER
      ,Difficulty    INTEGER
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
  
  genre_name = db.getAllRows(sql"""
    SELECT
      Genre_Name
      ,Genre_Detail
      ,Genre_Option_Count
      ,Genre
    
    FROM
      M_GENRE_MASTER
    """)

  for row in genre_name:
    echo(row)

proc get_Difficulty_name*() =
  var difficulty_name: seq[Row]
  
  difficulty_name = db.getAllRows(sql"""
    SELECT
      Difficulty_Name
      ,Difficulty_Detail
      ,Difficulty
    FROM
      M_DIFFICULTY_MASTER
    """)

  for row in difficulty_name:
    echo(row)

proc get_quiz_data*(genre: uint8, difficulty: uint8): seq[string] =
  var quiz_data: seq[string]

  var
    sql1: string
    sql2: string
    sql3: string

  sql1 = """
    SELECT
      T_QUIZ_TABLE.ID
      ,T_QUIZ_TABLE.Title
      ,M_GENRE_MASTER.Genre_Name
      ,M_GENRE_MASTER.Genre_Option_Count
      ,M_DIFFICULTY_MASTER.Difficulty_Name
      ,T_QUIZ_TABLE.Question
      ,T_QUIZ_TABLE.Option1
      ,T_QUIZ_TABLE.Option2
      ,T_QUIZ_TABLE.Option3
      ,T_QUIZ_TABLE.Option4
      ,T_QUIZ_TABLE.Detail

    FROM
      T_QUIZ_TABLE

    INNER JOIN M_GENRE_MASTER
      ON T_QUIZ_TABLE.Genre = M_GENRE_MASTER.Genre

    INNER JOIN M_DIFFICULTY_MASTER
      ON T_QUIZ_TABLE.Difficulty = M_DIFFICULTY_MASTER.Difficulty

    WHERE
      T_QUIZ_TABLE.Genre = """

  sql2 = """
      AND T_QUIZ_TABLE.Difficulty = """
    
  sql3 = """
    ORDER BY RANDOM()
    LIMIT 10"""

  quiz_data = db.getRow(sql(sql1 & $genre & sql2 & $difficulty & sql3))

  echo(quiz_data)
  
  return quiz_data