
exception Incorrect_locales of string

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

let locales_of_string = function
  | "af" -> Afrikaans
  | "ar-AE" -> Arabic_U_A_E
  | "ar-IQ" -> Arabic_Iraq
  | "ar" -> Arabic_Standard
  | "ar-BH" -> Arabic_Bahrain
  | "ar-DZ" -> Arabic_Algeria
  | "ar-EG" -> Arabic_Egypt
  | "ar-JO" -> Arabic_Jordan
  | "ar-KW" -> Arabic_Kuwait
  | "ar-LB" -> Arabic_Lebanon
  | "ar-LY" -> Arabic_Libya
  | "ar-MA" -> Arabic_Morocco
  | "ar-OM" -> Arabic_Oman
  | "ar-QA" -> Arabic_Qatar
  | "ar-SA" -> Arabic_Saudi_Arabia
  | "ar-SY" -> Arabic_Syria
  | "ar-TN" -> Arabic_Tunisia
  | "ar-YE" -> Arabic_Yemen
  | "as" -> Assamese
  | "ast" -> Asturian
  | "az" -> Azerbaijani
  | "be" -> Belarusian
  | "bg" -> Bulgarian
  | "bn" -> Bengali
  | "br" -> Breton
  | "bs" -> Bosnian
  | "ca" -> Catalan
  | "ce" -> Chechen
  | "ch" -> Chamorro
  | "co" -> Corsican
  | "cr" -> Cree
  | "cs" -> Czech
  | "cv" -> Chuvash
  | "da" -> Danish
  | "de" -> German_Standard
  | "de-AT" -> German_Austria
  | "de-CH" -> German_Switzerland
  | "de-DE" -> German_Germany
  | "de-LI" -> German_Liechtenstein
  | "de-LU" -> German_Luxembourg
  | "el" -> Greek
  | "en-AU" -> English_Australia
  | "en-BZ" -> English_Belize
  | "en" -> English
  | "en-CA" -> English_Canada
  | "en-GB" -> English_United_Kingdom
  | "en-IE" -> English_Ireland
  | "en-JM" -> English_Jamaica
  | "en-NZ" -> English_New_Zealand
  | "en-PH" -> English_Philippines
  | "en-TT" -> English_Trinidad_And_Tobago
  | "en-US" -> English_United_States
  | "en-ZA" -> English_South_Africa
  | "en-ZW" -> English_Zimbabwe
  | "eo" -> Esperanto
  | "et" -> Estonian
  | "eu" -> Basque
  | "fa" -> Persian
  | "fa-IR" -> Persian_Iran
  | "fi" -> Finnish
  | "fj" -> Fijian
  | "fo" -> Faeroese
  | "fr-CH" -> French_Switzerland
  | "fr-FR" -> French_France
  | "fr-LU" -> French_Luxembourg
  | "fr-MC" -> French_Monaco
  | "fr" -> French_Standard
  | "fr-BE" -> French_Belgium
  | "fr-CA" -> French_Canada
  | "fur" -> Friulian
  | "fy" -> Frisian
  | "ga" -> Irish
  | "gd-IE" -> Gaelic_Irish
  | "gd" -> Gaelic_Scots
  | "gl" -> Galacian
  | "gu" -> Gujurati
  | "he" -> Hebrew
  | "hi" -> Hindi
  | "hr" -> Croatian
  | "ht" -> Haitian
  | "hu" -> Hungarian
  | "hy" -> Armenian
  | "id" -> Indonesian
  | "is" -> Icelandic
  | "it-CH" -> Italian_Switzerland
  | "it" -> Italian_Standard
  | "iu" -> Inuktitut
  | "ja" -> Japanese
  | "ka" -> Georgian
  | "kk" -> Kazakh
  | "km" -> Khmer
  | "kn" -> Kannada
  | "ko" -> Korean
  | "ko-KP" -> Korean_North_Korea
  | "ko-KR" -> Korean_South_Korea
  | "ks" -> Kashmiri
  | "ky" -> Kirghiz
  | "la" -> Latin
  | "lb" -> Luxembourgish
  | "lt" -> Lithuanian
  | "lv" -> Latvian
  | "mi" -> Maori
  | "mk" -> FYRO_Macedonian
  | "ml" -> Malayalam
  | "mo" -> Moldavian
  | "mr" -> Marathi
  | "ms" -> Malay
  | "mt" -> Maltese
  | "my" -> Burmese
  | "nb" -> Norwegian_Bokmal
  | "ne" -> Nepali
  | "ng" -> Ndonga
  | "nl" -> Dutch_Standard
  | "nl-BE" -> Dutch_Belgian
  | "nn" -> Norwegian_Nynorsk
  | "no" -> Norwegian
  | "nv" -> Navajo
  | "oc" -> Occitan
  | "om" -> Oromo
  | "or" -> Oriya
  | "sq" -> Albanian
  | "tlh" -> Klingon
  | "zh-TW" -> Chinese_Taiwan
  | "zh" -> Chinese
  | "zh-CN" -> Chinese_PRC
  | "zh-HK" -> Chinese_Hong_Kong
  | "zh-SG" -> Chinese_Singapore
  | str -> raise (Incorrect_locales str)

let string_of_locales = function
  | Afrikaans -> "af"
  | Arabic_U_A_E -> "ar-AE"
  | Arabic_Iraq -> "ar-IQ"
  | Arabic_Standard -> "ar"
  | Arabic_Bahrain -> "ar-BH"
  | Arabic_Algeria -> "ar-DZ"
  | Arabic_Egypt -> "ar-EG"
  | Aragonese -> "ar"
  | Arabic_Jordan -> "ar-JO"
  | Arabic_Kuwait -> "ar-KW"
  | Arabic_Lebanon -> "ar-LB"
  | Arabic_Libya -> "ar-LY"
  | Arabic_Morocco -> "ar-MA"
  | Arabic_Oman -> "ar-OM"
  | Arabic_Qatar -> "ar-QA"
  | Arabic_Saudi_Arabia -> "ar-SA"
  | Arabic_Syria -> "ar-SY"
  | Arabic_Tunisia -> "ar-TN"
  | Arabic_Yemen -> "ar-YE"
  | Assamese -> "as"
  | Asturian -> "ast"
  | Azerbaijani -> "az"
  | Belarusian -> "be"
  | Bulgarian -> "bg"
  | Bengali -> "bn"
  | Breton -> "br"
  | Bosnian -> "bs"
  | Catalan -> "ca"
  | Chechen -> "ce"
  | Chamorro -> "ch"
  | Corsican -> "co"
  | Cree -> "cr"
  | Czech -> "cs"
  | Chuvash -> "cv"
  | Danish -> "da"
  | German_Standard -> "de"
  | German_Austria -> "de-AT"
  | German_Switzerland -> "de-CH"
  | German_Germany -> "de-DE"
  | German_Liechtenstein -> "de-LI"
  | German_Luxembourg -> "de-LU"
  | Greek -> "el"
  | English_Australia -> "en-AU"
  | English_Belize -> "en-BZ"
  | English -> "en"
  | English_Canada -> "en-CA"
  | English_United_Kingdom -> "en-GB"
  | English_Ireland -> "en-IE"
  | English_Jamaica -> "en-JM"
  | English_New_Zealand -> "en-NZ"
  | English_Philippines -> "en-PH"
  | English_Trinidad_And_Tobago -> "en-TT"
  | English_United_States -> "en-US"
  | English_South_Africa -> "en-ZA"
  | English_Zimbabwe -> "en-ZW"
  | Esperanto -> "eo"
  | Estonian -> "et"
  | Basque -> "eu"
  | Persian -> "fa"
  | Farsi -> "fa"
  | Persian_Iran -> "fa-IR"
  | Finnish -> "fi"
  | Fijian -> "fj"
  | Faeroese -> "fo"
  | French_Switzerland -> "fr-CH"
  | French_France -> "fr-FR"
  | French_Luxembourg -> "fr-LU"
  | French_Monaco -> "fr-MC"
  | French_Standard -> "fr"
  | French_Belgium -> "fr-BE"
  | French_Canada -> "fr-CA"
  | Friulian -> "fur"
  | Frisian -> "fy"
  | Irish -> "ga"
  | Gaelic_Irish -> "gd-IE"
  | Gaelic_Scots -> "gd"
  | Galacian -> "gl"
  | Gujurati -> "gu"
  | Hebrew -> "he"
  | Hindi -> "hi"
  | Croatian -> "hr"
  | Haitian -> "ht"
  | Hungarian -> "hu"
  | Armenian -> "hy"
  | Indonesian -> "id"
  | Icelandic -> "is"
  | Italian_Switzerland -> "it-CH"
  | Italian_Standard -> "it"
  | Inuktitut -> "iu"
  | Japanese -> "ja"
  | Georgian -> "ka"
  | Kazakh -> "kk"
  | Khmer -> "km"
  | Kannada -> "kn"
  | Korean -> "ko"
  | Korean_North_Korea -> "ko-KP"
  | Korean_South_Korea -> "ko-KR"
  | Kashmiri -> "ks"
  | Kirghiz -> "ky"
  | Latin -> "la"
  | Luxembourgish -> "lb"
  | Lithuanian -> "lt"
  | Latvian -> "lv"
  | Maori -> "mi"
  | FYRO_Macedonian -> "mk"
  | Malayalam -> "ml"
  | Moldavian -> "mo"
  | Marathi -> "mr"
  | Malay -> "ms"
  | Maltese -> "mt"
  | Burmese -> "my"
  | Norwegian_Bokmal -> "nb"
  | Nepali -> "ne"
  | Ndonga -> "ng"
  | Dutch_Standard -> "nl"
  | Dutch_Belgian -> "nl-BE"
  | Norwegian_Nynorsk -> "nn"
  | Norwegian -> "no"
  | Navajo -> "nv"
  | Occitan -> "oc"
  | Oromo -> "om"
  | Oriya -> "or"
  | Albanian -> "sq"
  | Klingon -> "tlh"
  | Chinese_Taiwan -> "zh-TW"
  | Chinese -> "zh"
  | Chinese_PRC -> "zh-CN"
  | Chinese_Hong_Kong -> "zh-HK"
  | Chinese_Singapore -> "zh-SG"
