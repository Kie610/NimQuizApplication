import wNim

proc gInitialize*() =
  echo "gInitialize"

proc gTitle*(screen: string):string =
  echo "gTitle"
  
  var
    choose:string = ""

  case screen
  of "タイトル画面":
    echo "タイトル画面"

  of "ジャンル選択":
    echo "ジャンル選択"
    
  of "難易度選択":
    echo "難易度選択"

  of "4択クイズ":
    echo "4択クイズ"

  else: 
    echo "なんちょれ？"
  

  return choose