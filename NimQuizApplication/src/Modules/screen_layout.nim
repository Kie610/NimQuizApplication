proc get_string*(Layout_State: string): string =
  var space: uint8 = 8
  var layout_string: string

  case Layout_State
  of "TwoChoice":
    layout_string = "spacing: " & $space & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(20%)-[Question]-(20%)-|
        H:|-(10%)-[Options]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Question(40%)]-[Options]-[Fooder(10%)]-|

        H:[Header:-[title(80%)]-[info]-]

        H:[Question:[question]]
        H:[Options:[option1(option2)]-[option2]]

        H:[Fooder:[prev(20%)]-[genre]-[next(20%)]]"""

  of "FourChoice":
    layout_string = "spacing: " & $space & """
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

        H:[Fooder:[prev(20%)]-[genre]-[next(20%)]]"""

  else:
    layout_string = "spacing: " & $space & """
        H:|-[element["title"]]-|
        V:|-[element["title"]]-|"""

  return layout_string
