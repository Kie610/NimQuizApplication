import public_variables

proc get_string*(menu: MenuState, quiz_kinds: string = ""): string =
  var menu_string: string
  var layout_string: string
  
  menu_string = $menu & quiz_kinds
  layout_string = "spacing: 8"

  case menu_string
  of "MainMenu":
    layout_string = layout_string & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(10%)-[Genres(50%)]-[Options]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Genres,Options]-[Fooder(10%)]-|

        H:[Header:[title]]

        V:[Genres:[genre_list]]
        V:[Options:[detail]-[setting(add_quiz,credit,10%)]-[add_quiz]-[credit]]

        H:[Fooder:~[next(20%)]]"""

  of "Setting":
    layout_string = layout_string & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(10%)-[Body]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Body]-[Fooder(10%)]-|

        H:[Header:-[title(80%)]-]

        H:[Body:[detail]]

        H:[Fooder:[prev(20%)]~[next(20%)]]"""

  of "AddQuiz":
    layout_string = layout_string & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(10%)-[Body]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Body]-[Fooder(10%)]-|

        H:[Header:-[title(80%)]-]

        H:[Body:[detail]]

        H:[Fooder:[prev(20%)]~[next(20%)]]"""

  of "Credit":
    layout_string = layout_string & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(10%)-[Body]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Body]-[Fooder(10%)]-|

        H:[Header:-[title(80%)]-]

        H:[Body:[detail]]

        H:[Fooder:[prev(20%)]~[next(20%)]]"""

  of "DifMenu":
    layout_string = layout_string & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(10%)-[Quiz_Qty]-(10%)-|
        H:|-(10%)-[Options]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Quiz_Qty(10%)]-[Options]-[Fooder(10%)]-|

        H:[Header:-[title(80%)]-]

        H:[Quiz_Qty:[detail(20%)]-[quiz_qtyspinctrl]]
        H:[Options:[difficulty_list]]

        H:[Fooder:[prev(20%)]~[next(20%)]]"""

  of "Quiz2択問題":
    layout_string = layout_string & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(20%)-[Question]-(20%)-|
        H:|-(10%)-[Options]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Question(40%)]-[Options]-[Fooder(10%)]-|

        H:[Header:-[title(80%)]-[info]-]

        H:[Question:[question]]
        H:[Options:[option1(option2)]-[option2]]

        H:[Fooder:-(20%)-[genre]-[next(20%)]]"""

  of "Quiz3択問題":
    layout_string = layout_string & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(20%)-[Question]-(20%)-|
        H:|-(10%)-[Options]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Question(40%)]-[Options]-[Fooder(10%)]-|

        H:[Header:-[title(80%)]-[info]-]

        H:[Question:[question]]
        H:[Options:[option1(option2,option3)]-[option2]-[option3]]

        H:[Fooder:-(20%)-[genre]-[next(20%)]]"""

  of "Quiz4択問題":
    layout_string = layout_string & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(20%)-[Question]-(20%)-|
        H:|-(10%)-[Options]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Question(40%)]-[Options]-[Fooder(10%)]-|

        H:[Header:-[title(80%)]-[info]-]

        H:[Question:[question]]

        H:[Options:[OptionsL(OptionsR)]-[OptionsR]]
        V:[OptionsL:[option1(option3)]-[option3]]
        V:[OptionsR:[option2(option4)]-[option4]]

        H:[Fooder:-(20%)-[genre]-[next(20%)]]"""

  of "sResult":
    layout_string = layout_string & """
        H:|-(20%)-[Question]-(20%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-(10%)-[Question]-[Fooder(10%)]-|

        H:[Question:[title]]

        H:[Fooder:-[prev(20%)]-[genre]-[next(20%)]]"""

  of "aResult":
    layout_string = layout_string & """
        H:|-(20%)-[Question]-(20%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-(10%)-[Question]-[Fooder(10%)]-|
        
        H:[Question:[title]]
        
        H:[Fooder:-[prev(20%)]-[genre]-[next(20%)]]"""

  else:
    layout_string = layout_string & """
        H:|-[title]-|
        V:|-[title]-|"""

  return layout_string
