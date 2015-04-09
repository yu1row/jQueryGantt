###

    “ú–{‚Ì‹x“ú‚ğ JavaScript ‚ÅŒvZ‚·‚é‚½‚ß‚Ìƒ‰ƒCƒuƒ‰ƒŠ
                         Osamu Takeuchi <osamu@big.jp>

    ChangeLog
        2013.04.17 ‰o
        2015.04.09 R‚Ì“ú’Ç‰Á

    Date ƒNƒ‰ƒX‚ÉˆÈ‰º‚ÌŠÖ”‚ğ’Ç‰Á‚·‚é

    **** Date::isHoliday(furikae = true)

    w’è‚³‚ê‚½“ú‚ª‹x“ú‚©‚Ç‚¤‚©‚ğ”»’è‚µ‚ÄA‹x“ú‚È‚ç–¼‘O‚ğ•Ô‚·
    ‹x“ú‚Å‚È‚¯‚ê‚Î null ‚ğ•Ô‚·
    furikae ‚É false ‚ğw’è‚·‚é‚ÆU‘Ö‹x“ú‚ğœ‚­
    “à•”‚Å‚ÍƒLƒƒƒbƒVƒ…‚µ‚½’l‚ğg‚Á‚ÄŒvZ‚·‚é‚½‚ßŒJ‚è•Ô‚µŒÄ‚Ô
    Û‚É‚Í‚Æ‚Ä‚à‚‘¬‚É“®ì‚·‚é
    
    JavaScript:

      today = new Date();
      holiday = today.isHoliday();
      if(holiday) {
          alert("¡“ú‚Í " + holiday + " ‚Å‚·<br/>");
      } else {
          alert("¡“ú‚Íj“ú‚Å‚Í‚ ‚è‚Ü‚¹‚ñ<br/>");
      }


    **** Date.getHolidaysOf(year, furikae = true)
    
    w’è‚³‚ê‚½”N‚Ì‹x“ú‚ğ”z—ñ‚É‚µ‚Ä•Ô‚·
    ”z—ñ‚É‚Í {month:m, date:d, name:s} ‚ÌŒ`‚Å•\‚í‚³‚ê‚½‹x“ú‚ª“ú•t‡‚É•À‚Ô
    furikae ‚É false ‚ğw’è‚·‚é‚ÆAU‘Ö‹x“ú‚¨‚æ‚Ñ‘–¯‚Ì‹x“ú‚ğœ‚­

    JavaScriptF
    
    today = new Date();
    holidays = Date.getHolidaysOf( today.getFullYear() );
    for(holiday in holidays) {
        document.write(
            holiday.month + "Œ" + holiday.date + "“ú‚Í " +
            holiday.name + " ‚Å‚·<br/>"
        );
    }


   **** Date::getShifted(year, mon, day, hour, min, sec, msec )

    Œ³‚Ì‚©‚çw’èŠÔ‚¾‚¯‚¸‚ç‚µ‚½‚ğ¶¬‚µ‚Ä•Ô‚·
    •‰‚Ì”‚àw’è‚Å‚«‚é

    d = new Date();
    d.getShifted(1);        # ‚P”NŒã‚Ì
    d.getShifted(0, -10);   # ‚P‚Oƒ–Œ‘O‚Ì
    d.getShifted(0,0,0,1);  # ‚PŠÔŒã‚Ì

###

Date::getShifted = (year, mon, day, hour, min, sec, msec) ->
    # ‚Ü‚¸‚Í“ú•tˆÈ‰º‚Ì•”•ª‚ğ msec ‚É’¼‚µ‚Äˆ—‚·‚é
    res = new Date()
    res.setTime( @getTime() + 
        (((( day ? 0 ) * 24 + ( hour ? 0 )) * 60 + ( min ? 0 )) * 60 + 
                                ( sec ? 0 )) * 1000 + ( msec ? 0 )
    )
    # ”N‚ÆŒ‚Í‚¿‚å‚Á‚Æ–Ê“|‚Èˆ—‚É‚È‚é
    res.setFullYear res.getFullYear() + ( year ? 0 ) + 
       Math.floor( ( res.getMonth() + ( mon ? 0 ) ) / 12 )
    res.setMonth ( ( res.getMonth() + ( mon ? 0 ) ) % 12 + 12 ) % 12
    return res

###
    ƒwƒ‹ƒpŠÖ”
###

# ”N‚ğ—^‚¦‚é‚Æw’è‚Ìj“ú‚ğ•Ô‚·ŠÖ”‚ğì¬
simpleHoliday = (month, day) ->
    (year) -> new Date(year, month-1, day)


# ”N‚ğ—^‚¦‚é‚Æw’è‚ÌŒ‚Ì nth Œ—j‚ğ•Ô‚·ŠÖ”‚ğì¬
happyMonday = (month, nth) ->
    (year) ->
        monday = 1
        first = new Date(year, month-1, 1)
        first.getShifted( 0, 0,
            ( 7 - ( first.getDay() - monday ) ) % 7 + ( nth - 1 ) * 7
        )


# ”N‚ğ—^‚¦‚é‚Æt•ª‚Ì“ú‚ğ•Ô‚·
shunbun = (year) ->
    date = new Date()
    date.setTime( -655910271894.040039 + 31556943676.430065 * (year-1949) + 24*3600*1000/2 )
    new Date(year, date.getMonth(), date.getDate())


# ”N‚ğ—^‚¦‚é‚ÆH•ª‚Ì“ú‚ğ•Ô‚·
shubun = (year) ->
    date = new Date()
    date.setTime( -671361740118.508301 + 31556929338.445450 * (year-1948) + 24.3*3600*1000/2 )
    new Date(year, date.getMonth(), date.getDate())


###
    ‹x“úƒf[ƒ^
    https://ja.wikipedia.org/wiki/%E5%9B%BD%E6%B0%91%E3%81%AE%E7%A5%9D%E6%97%A5
###

definition = [
    [ "Œ³’U",               simpleHoliday( 1,  1), 1949       ],
    [ "¬l‚Ì“ú",           simpleHoliday( 1, 15), 1949, 1999 ],
    [ "¬l‚Ì“ú",           happyMonday(   1,  2), 2000       ],
    [ "Œš‘‹L”O‚Ì“ú",       simpleHoliday( 2, 11), 1967       ],
    [ "º˜a“Vc‚Ì‘å‘r‚Ì—ç", simpleHoliday( 2, 24), 1989, 1989 ],
    [ "t•ª‚Ì“ú",           shunbun,               1949       ],
    [ "–¾me‰¤‚ÌŒ‹¥‚Ì‹V", simpleHoliday( 4, 10), 1959, 1959 ],
    [ "“Vc’a¶“ú",         simpleHoliday( 4, 29), 1949, 1988 ],
    [ "‚İ‚Ç‚è‚Ì“ú",         simpleHoliday( 4, 29), 1989, 2006 ],
    [ "º˜a‚Ì“ú",           simpleHoliday( 4, 29), 2007       ],
    [ "Œ›–@‹L”O“ú",         simpleHoliday( 5,  3), 1949       ],
    [ "‚İ‚Ç‚è‚Ì“ú",         simpleHoliday( 5,  4), 2007       ],
    [ "‚±‚Ç‚à‚Ì“ú",         simpleHoliday( 5,  5), 1949       ],
    [ "“¿me‰¤‚ÌŒ‹¥‚Ì‹V", simpleHoliday( 6,  9), 1993, 1993 ],
    [ "ŠC‚Ì“ú",             simpleHoliday( 7, 20), 1996, 2002 ],
    [ "ŠC‚Ì“ú",             happyMonday(   7,  3), 2003       ],
    [ "R‚Ì“ú",             simpleHoliday( 8, 11), 2016       ],
    [ "Œh˜V‚Ì“ú",           simpleHoliday( 9, 15), 1966, 2002 ],
    [ "Œh˜V‚Ì“ú",           happyMonday(   9,  3), 2003       ],
    [ "H•ª‚Ì“ú",           shubun,                1948       ],
    [ "‘Ìˆç‚Ì“ú",           simpleHoliday(10, 10), 1966, 1999 ],
    [ "‘Ìˆç‚Ì“ú",           happyMonday(  10,  2), 2000       ],
    [ "•¶‰»‚Ì“ú",           simpleHoliday(11,  3), 1948       ],
    [ "‘¦ˆÊ‚Ì—ç³“a‚Ì‹V",   simpleHoliday(11, 12), 1990, 1990 ],
    [ "‹Î˜JŠ´Ó‚Ì“ú",       simpleHoliday(11, 23), 1948       ],
    [ "“Vc’a¶“ú",         simpleHoliday(12, 23), 1989       ],
]


# ‹x“ú‚ğ—^‚¦‚é‚Æ‚»‚ÌU‘Ö‹x“ú‚ğ•Ô‚·
# U‚è‘Ö‚¦‹x“ú‚ª‚È‚¯‚ê‚Î null ‚ğ•Ô‚·
furikaeHoliday = (holiday) ->
    # U‘Ö‹x“ú§“x§’è‘O ‚Ü‚½‚Í “ú—j“ú‚Å‚È‚¢ê‡ U‚è‘Ö‚¦–³‚µ
    sunday = 0
    if holiday < new Date(1973, 4-1, 30-1) or holiday.getDay() != sunday
        return null
    # “ú—j“ú‚È‚Ì‚Åˆê“ú‚¸‚ç‚·
    furikae = holiday.getShifted(0, 0, 1)
    # ‚¸‚ç‚µ‚½Œ—j“ú‚ª‹x“ú‚Å‚È‚¯‚ê‚ÎU‘Ö‹x“ú
    if !furikae.isHoliday(false)
        return furikae
    # ‹ŒU‚è‘Ö‚¦§“x‚Å‚Í‚P“úˆÈã‚¸‚ç‚³‚È‚¢
    if holiday < new Date(2007, 1-1,  1)
        return null # ‚½‚Ô‚ñ‚±‚ê‚ÉŠY“–‚·‚é“ú‚Í‚È‚¢‚Í‚¸H
    loop
        # U‚è‘Ö‚¦‚½Œ‹‰Ê‚ª‹x“ú‚¾‚Á‚½‚ç‚P“ú‚¸‚Â‚¸‚ç‚·
        furikae = furikae.getShifted(0, 0, 1)
        if !furikae.isHoliday(false)
            return furikae


# ‹x“ú‚ğ—^‚¦‚é‚ÆA—‚“ú‚ª‘–¯‚Ì‹x“ú‚©‚Ç‚¤‚©‚ğ”»’è‚µ‚ÄA
# ‘–¯‚Ì‹x“ú‚Å‚ ‚ê‚Î‚»‚Ì“ú‚ğ•Ô‚·
kokuminHoliday = (holiday) ->
    if holiday.getFullYear() < 1988 # §’è‘O
        return null
    # ‚Q“úŒã‚ªU‚è‘Ö‚¦ˆÈŠO‚Ìj“ú‚©
    if !holiday.getShifted(0, 0, 2).isHoliday(false)
        return null
    sunday = 0
    monday = 1
    kokumin = holiday.getShifted(0, 0, 1)
    if kokumin.isHoliday(false) or  # Ÿ‚Ì“ú‚ªj“ú
       kokumin.getDay()==sunday or  # Ÿ‚Ì“ú‚ª“ú—j
       kokumin.getDay()==monday     # Ÿ‚Ì“ú‚ªŒ—jiU‘Ö‹x“ú‚É‚È‚éj
        return null
    return kokumin


#
# holidays[furikae] = {
#    1999:
#      "1,1": "Œ³’U"
#      "1,15": "¬l‚Ì“ú"
#      ...
# }
#
holidays = { true: {}, false: {} }

getHolidaysOf = (y, furikae) ->
    # ƒLƒƒƒbƒVƒ…‚³‚ê‚Ä‚¢‚ê‚Î‚»‚ê‚ğ•Ô‚·
    furikae = if !furikae? or furikae then true else false
    cache = holidays[furikae][y]
    return cache if cache?
    # ‚³‚ê‚Ä‚È‚¯‚ê‚ÎŒvZ‚µ‚ÄƒLƒƒƒbƒVƒ…
    # U‘Ö‹x“ú‚ğŒvZ‚·‚é‚É‚ÍU‘Ö‹x“úˆÈŠO‚Ì‹x“ú‚ªŒvZ‚³‚ê‚Ä
    # ‚¢‚È‚¢‚Æƒ_ƒ‚È‚Ì‚ÅAæ‚ÉŒvZ‚·‚é
    wo_furikae = {}
    for entry in definition
        continue if entry[2]? && y < entry[2]   # §’è”NˆÈ‘O
        continue if entry[3]? && entry[3] < y   # ”p~”NˆÈ~
        holiday = entry[1](y)                   # ‹x“ú‚ğŒvZ
        continue unless holiday?                # –³Œø‚Å‚ ‚ê‚Î–³‹
        m = holiday.getMonth()+1                # Œ‹‰Ê‚ğ“o˜^
        d = holiday.getDate()
        wo_furikae[ [m,d] ] = entry[0]
    holidays[false][y] = wo_furikae
    
    # ‘–¯‚Ì‹x“ú‚ğ’Ç‰Á‚·‚é
    kokuminHolidays = []
    for month_day of wo_furikae
        month_day = month_day.split(",")
        holiday = kokuminHoliday( new Date(y, month_day[0]-1, month_day[1] ) )
        if holiday?
            m = holiday.getMonth()+1            # Œ‹‰Ê‚ğ“o˜^
            d = holiday.getDate()
            kokuminHolidays.push([m,d])
    for holiday in kokuminHolidays
        wo_furikae[holiday] = "‘–¯‚Ì‹x“ú"
    
    # U‘Ö‹x“ú‚ğ’Ç‰Á‚·‚é
    w_furikae = {}
    for month_day, name of wo_furikae
        w_furikae[month_day] = name
        month_day = month_day.split(",")
        holiday = furikaeHoliday( new Date(y, month_day[0]-1, month_day[1] ) )
        if holiday?
            m = holiday.getMonth()+1            # Œ‹‰Ê‚ğ“o˜^
            d = holiday.getDate()
            w_furikae[ [m,d] ] = "U‘Ö‹x“ú"
    holidays[true][y] = w_furikae               # Œ‹‰Ê‚ğ“o˜^
    return holidays[furikae][y]

Date.getHolidaysOf = (y, furikae) ->
    # ƒf[ƒ^‚ğ®Œ`‚·‚é
    result = []
    for month_day, name of getHolidaysOf(y, furikae)
        result.push(
            month : parseInt(month_day.split(",")[0])
            date  : parseInt(month_day.split(",")[1])
            name  : name
        )
    # “ú•t‡‚É•À‚×’¼‚·
    result.sort( (a,b)-> (a.month-b.month) or (a.date-b.date) )
    result

Date::isHoliday = (furikae) ->
    return getHolidaysOf(@getFullYear(), furikae)[ [@getMonth()+1, @getDate()] ]
