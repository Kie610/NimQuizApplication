proc get_string*(layout_name: string): string =
  var space: uint8 = 8
  var layout_string: string

  case layout_name
  of "two_choice":
    layout_string = "spacing: " & $space & """
        H:|-(10%)-[Header]-(10%)-|
        H:|-(20%)-[Question]-(20%)-|
        H:|-(10%)-[Options]-(10%)-|
        H:|-(10%)-[Fooder]-(10%)-|
        V:|-[Header(10%)]-[Question(40%)]-[Options]-[Fooder(10%)]-|

        H:[Header:[title(50%)]-[info]-]

        H:[Question:[question]]
        H:[Options:[options1(options2)]-[options2]]

        H:[Fooder:[prev(20%)]-[genre]-[next(20%)]]"""

  else:
    layout_string = """
        spacing: 8
        H:|-[label(40%)]-[listbox]-|
        V:|-[label,listbox]-|"""

  return layout_string
