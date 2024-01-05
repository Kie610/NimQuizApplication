#################################################
#   ライブラリのインポート
#################################################
import db_connector/db_sqlite
import public_variables
import std/[strutils, random]


#################################################
#   変数宣言
#################################################
var db: DbConn


#################################################
#   データベース接続
#################################################
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


#################################################
#   データベース切断
#################################################
proc db_close*() =
  echo("Close DB")
  db.close()


#################################################
#   ジャンル関連情報取得
#################################################
proc get_genre_info*(): seq[GenreInfo] =
  var
    genre_table: seq[seq[string]]
    genre_list: seq[GenreInfo]
  
  genre_table = db.getAllRows(sql"""
    SELECT
      Genre_Name
      ,Genre_Detail
      ,Genre
      ,Genre_Option_Count
    
    FROM
      M_GENRE_MASTER
    """)
  
  for row in genre_table:
    var
      genre_info: GenreInfo

    genre_info.name = row[0]
    genre_info.detail = row[1]
    genre_info.genre = parseInt(row[2])
    genre_info.genre_option_count = parseInt(row[3])
    
    genre_list.add(genre_info)
  
  echo(genre_list)

  return genre_list


#################################################
#   難易度関連情報取得
#################################################
proc get_difficulty_info*(): seq[DifficultyInfo] =
  var
    difficulty_table: seq[seq[string]]
    difficulty_list: seq[DifficultyInfo]
  
  difficulty_table = db.getAllRows(sql"""
    SELECT
      Difficulty_Name
      ,Difficulty_Detail
      ,Difficulty
    FROM
      M_DIFFICULTY_MASTER
    """)

  for row in difficulty_table:
    var
      difficulty_info: DifficultyInfo

    difficulty_info.name = row[0]
    difficulty_info.detail = row[1]
    difficulty_info.difficulty = parseInt(row[2])

    difficulty_list.add(difficulty_info)

  echo(difficulty_list)

  return difficulty_list


#################################################
#   クイズ情報取得
#################################################
proc get_quiz_data*(genre: int, difficulty: int, quiz_quantity: int): seq[QuizInfo] =
  randomize()
  var
    quiz_data: seq[seq[string]]
    quiz_list: seq[QuizInfo]

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
    LIMIT """

  quiz_data = db.getAllRows(sql(sql1 & $genre & sql2 & $difficulty & sql3 & $quiz_quantity))

  for row in quiz_data:
    var
      quiz_info: QuizInfo
      option_start: int = 6
      option_seq: seq[string]

    quiz_info.ID = parseInt(row[0])
    quiz_info.Title = row[1]
    quiz_info.Genre_Name = row[2]
    quiz_info.Genre_Option_Count = parseInt(row[3])
    quiz_info.Difficulty_Name = row[4]
    quiz_info.Question = row[5]
    quiz_info.Correct_Option = row[6]

    for i in countup(option_start, option_start + 4 - 1):
      option_seq.add(row[i])
      
      if i == option_start + quiz_info.Genre_Option_Count - 1:
        echo("shuffle")
        shuffle(option_seq)

      echo(option_seq)

    quiz_info.Option1 = option_seq[0]
    quiz_info.Option2 = option_seq[1]
    quiz_info.Option3 = option_seq[2]
    quiz_info.Option4 = option_seq[3]

    quiz_info.Detail = row[10]
    quiz_info.Done = false
    quiz_info.Result = false

    quiz_list.add(quiz_info)

  echo($quiz_list)

  return quiz_list