
type t =
  | Afrikaans
  | Arabic_U_A_E
  | Arabic_Iraq
  | Arabic_Standard
  | Arabic_Bahrain
  | Arabic_Algeria
  | Arabic_Egypt
  | Aragonese
  | Arabic_Jordan
  | Arabic_Kuwait
  | Arabic_Lebanon
  | Arabic_Libya
  | Arabic_Morocco
  | Arabic_Oman
  | Arabic_Qatar
  | Arabic_Saudi_Arabia
  | Arabic_Syria
  | Arabic_Tunisia
  | Arabic_Yemen
  | Assamese
  | Asturian
  | Azerbaijani
  | Belarusian
  | Bulgarian
  | Bengali
  | Breton
  | Bosnian
  | Catalan
  | Chechen
  | Chamorro
  | Corsican
  | Cree
  | Czech
  | Chuvash
  | Danish
  | German_Standard
  | German_Austria
  | German_Switzerland
  | German_Germany
  | German_Liechtenstein
  | German_Luxembourg
  | Greek
  | English_Australia
  | English_Belize
  | English
  | English_Canada
  | English_United_Kingdom
  | English_Ireland
  | English_Jamaica
  | English_New_Zealand
  | English_Philippines
  | English_Trinidad_And_Tobago
  | English_United_States
  | English_South_Africa
  | English_Zimbabwe
  | Esperanto
  | Estonian
  | Basque
  | Persian
  | Farsi
  | Persian_Iran
  | Finnish
  | Fijian
  | Faeroese
  | French_Switzerland
  | French_France
  | French_Luxembourg
  | French_Monaco
  | French_Standard
  | French_Belgium
  | French_Canada
  | Friulian
  | Frisian
  | Irish
  | Gaelic_Irish
  | Gaelic_Scots
  | Galacian
  | Gujurati
  | Hebrew
  | Hindi
  | Croatian
  | Haitian
  | Hungarian
  | Armenian
  | Indonesian
  | Icelandic
  | Italian_Switzerland
  | Italian_Standard
  | Inuktitut
  | Japanese
  | Georgian
  | Kazakh
  | Khmer
  | Kannada
  | Korean
  | Korean_North_Korea
  | Korean_South_Korea
  | Kashmiri
  | Kirghiz
  | Latin
  | Luxembourgish
  | Lithuanian
  | Latvian
  | Maori
  | FYRO_Macedonian
  | Malayalam
  | Moldavian
  | Marathi
  | Malay
  | Maltese
  | Burmese
  | Norwegian_Bokmal
  | Nepali
  | Ndonga
  | Dutch_Standard
  | Dutch_Belgian
  | Norwegian_Nynorsk
  | Norwegian
  | Navajo
  | Occitan
  | Oromo
  | Oriya
  | Albanian
  | Klingon
  | Chinese_Taiwan
  | Chinese
  | Chinese_PRC
  | Chinese_Hong_Kong
  | Chinese_Singapore

val locales_of_string : string -> t

val string_of_locales : t -> string
