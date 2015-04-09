###

    ���{�̋x���� JavaScript �Ōv�Z���邽�߂̃��C�u����
                         Osamu Takeuchi <osamu@big.jp>

    ChangeLog
        2013.04.17 ���o
        2015.04.09 �R�̓��ǉ�

    Date �N���X�Ɉȉ��̊֐���ǉ�����

    **** Date::isHoliday(furikae = true)

    �w�肳�ꂽ�����x�����ǂ����𔻒肵�āA�x���Ȃ疼�O��Ԃ�
    �x���łȂ���� null ��Ԃ�
    furikae �� false ���w�肷��ƐU�֋x��������
    �����ł̓L���b�V�������l���g���Čv�Z���邽�ߌJ��Ԃ��Ă�
    �ۂɂ͂ƂĂ������ɓ��삷��
    
    JavaScript:

      today = new Date();
      holiday = today.isHoliday();
      if(holiday) {
          alert("������ " + holiday + " �ł�<br/>");
      } else {
          alert("�����͏j���ł͂���܂���<br/>");
      }


    **** Date.getHolidaysOf(year, furikae = true)
    
    �w�肳�ꂽ�N�̋x����z��ɂ��ĕԂ�
    �z��ɂ� {month:m, date:d, name:s} �̌`�ŕ\�킳�ꂽ�x�������t���ɕ���
    furikae �� false ���w�肷��ƁA�U�֋x������э����̋x��������

    JavaScript�F
    
    today = new Date();
    holidays = Date.getHolidaysOf( today.getFullYear() );
    for(holiday in holidays) {
        document.write(
            holiday.month + "��" + holiday.date + "���� " +
            holiday.name + " �ł�<br/>"
        );
    }


   **** Date::getShifted(year, mon, day, hour, min, sec, msec )

    ���̎�������w�莞�Ԃ������炵�������𐶐����ĕԂ�
    ���̐����w��ł���

    d = new Date();
    d.getShifted(1);        # �P�N��̎���
    d.getShifted(0, -10);   # �P�O�����O�̎���
    d.getShifted(0,0,0,1);  # �P���Ԍ�̎���

###

Date::getShifted = (year, mon, day, hour, min, sec, msec) ->
    # �܂��͓��t�ȉ��̕����� msec �ɒ����ď�������
    res = new Date()
    res.setTime( @getTime() + 
        (((( day ? 0 ) * 24 + ( hour ? 0 )) * 60 + ( min ? 0 )) * 60 + 
                                ( sec ? 0 )) * 1000 + ( msec ? 0 )
    )
    # �N�ƌ��͂�����Ɩʓ|�ȏ����ɂȂ�
    res.setFullYear res.getFullYear() + ( year ? 0 ) + 
       Math.floor( ( res.getMonth() + ( mon ? 0 ) ) / 12 )
    res.setMonth ( ( res.getMonth() + ( mon ? 0 ) ) % 12 + 12 ) % 12
    return res

###
    �w���p�֐�
###

# �N��^����Ǝw��̏j����Ԃ��֐����쐬
simpleHoliday = (month, day) ->
    (year) -> new Date(year, month-1, day)


# �N��^����Ǝw��̌��� nth ���j��Ԃ��֐����쐬
happyMonday = (month, nth) ->
    (year) ->
        monday = 1
        first = new Date(year, month-1, 1)
        first.getShifted( 0, 0,
            ( 7 - ( first.getDay() - monday ) ) % 7 + ( nth - 1 ) * 7
        )


# �N��^����Ət���̓���Ԃ�
shunbun = (year) ->
    date = new Date()
    date.setTime( -655910271894.040039 + 31556943676.430065 * (year-1949) + 24*3600*1000/2 )
    new Date(year, date.getMonth(), date.getDate())


# �N��^����ƏH���̓���Ԃ�
shubun = (year) ->
    date = new Date()
    date.setTime( -671361740118.508301 + 31556929338.445450 * (year-1948) + 24.3*3600*1000/2 )
    new Date(year, date.getMonth(), date.getDate())


###
    �x���f�[�^
    https://ja.wikipedia.org/wiki/%E5%9B%BD%E6%B0%91%E3%81%AE%E7%A5%9D%E6%97%A5
###

definition = [
    [ "���U",               simpleHoliday( 1,  1), 1949       ],
    [ "���l�̓�",           simpleHoliday( 1, 15), 1949, 1999 ],
    [ "���l�̓�",           happyMonday(   1,  2), 2000       ],
    [ "�����L�O�̓�",       simpleHoliday( 2, 11), 1967       ],
    [ "���a�V�c�̑�r�̗�", simpleHoliday( 2, 24), 1989, 1989 ],
    [ "�t���̓�",           shunbun,               1949       ],
    [ "���m�e���̌����̋V", simpleHoliday( 4, 10), 1959, 1959 ],
    [ "�V�c�a����",         simpleHoliday( 4, 29), 1949, 1988 ],
    [ "�݂ǂ�̓�",         simpleHoliday( 4, 29), 1989, 2006 ],
    [ "���a�̓�",           simpleHoliday( 4, 29), 2007       ],
    [ "���@�L�O��",         simpleHoliday( 5,  3), 1949       ],
    [ "�݂ǂ�̓�",         simpleHoliday( 5,  4), 2007       ],
    [ "���ǂ��̓�",         simpleHoliday( 5,  5), 1949       ],
    [ "���m�e���̌����̋V", simpleHoliday( 6,  9), 1993, 1993 ],
    [ "�C�̓�",             simpleHoliday( 7, 20), 1996, 2002 ],
    [ "�C�̓�",             happyMonday(   7,  3), 2003       ],
    [ "�R�̓�",             simpleHoliday( 8, 11), 2016       ],
    [ "�h�V�̓�",           simpleHoliday( 9, 15), 1966, 2002 ],
    [ "�h�V�̓�",           happyMonday(   9,  3), 2003       ],
    [ "�H���̓�",           shubun,                1948       ],
    [ "�̈�̓�",           simpleHoliday(10, 10), 1966, 1999 ],
    [ "�̈�̓�",           happyMonday(  10,  2), 2000       ],
    [ "�����̓�",           simpleHoliday(11,  3), 1948       ],
    [ "���ʂ̗琳�a�̋V",   simpleHoliday(11, 12), 1990, 1990 ],
    [ "�ΘJ���ӂ̓�",       simpleHoliday(11, 23), 1948       ],
    [ "�V�c�a����",         simpleHoliday(12, 23), 1989       ],
]


# �x����^����Ƃ��̐U�֋x����Ԃ�
# �U��ւ��x�����Ȃ���� null ��Ԃ�
furikaeHoliday = (holiday) ->
    # �U�֋x�����x����O �܂��� ���j���łȂ��ꍇ �U��ւ�����
    sunday = 0
    if holiday < new Date(1973, 4-1, 30-1) or holiday.getDay() != sunday
        return null
    # ���j���Ȃ̂ň�����炷
    furikae = holiday.getShifted(0, 0, 1)
    # ���炵�����j�����x���łȂ���ΐU�֋x��
    if !furikae.isHoliday(false)
        return furikae
    # ���U��ւ����x�ł͂P���ȏジ�炳�Ȃ�
    if holiday < new Date(2007, 1-1,  1)
        return null # ���Ԃ񂱂�ɊY��������͂Ȃ��͂��H
    loop
        # �U��ւ������ʂ��x����������P�������炷
        furikae = furikae.getShifted(0, 0, 1)
        if !furikae.isHoliday(false)
            return furikae


# �x����^����ƁA�����������̋x�����ǂ����𔻒肵�āA
# �����̋x���ł���΂��̓���Ԃ�
kokuminHoliday = (holiday) ->
    if holiday.getFullYear() < 1988 # ����O
        return null
    # �Q���オ�U��ւ��ȊO�̏j����
    if !holiday.getShifted(0, 0, 2).isHoliday(false)
        return null
    sunday = 0
    monday = 1
    kokumin = holiday.getShifted(0, 0, 1)
    if kokumin.isHoliday(false) or  # ���̓����j��
       kokumin.getDay()==sunday or  # ���̓������j
       kokumin.getDay()==monday     # ���̓������j�i�U�֋x���ɂȂ�j
        return null
    return kokumin


#
# holidays[furikae] = {
#    1999:
#      "1,1": "���U"
#      "1,15": "���l�̓�"
#      ...
# }
#
holidays = { true: {}, false: {} }

getHolidaysOf = (y, furikae) ->
    # �L���b�V������Ă���΂����Ԃ�
    furikae = if !furikae? or furikae then true else false
    cache = holidays[furikae][y]
    return cache if cache?
    # ����ĂȂ���Όv�Z���ăL���b�V��
    # �U�֋x�����v�Z����ɂ͐U�֋x���ȊO�̋x�����v�Z�����
    # ���Ȃ��ƃ_���Ȃ̂ŁA��Ɍv�Z����
    wo_furikae = {}
    for entry in definition
        continue if entry[2]? && y < entry[2]   # ����N�ȑO
        continue if entry[3]? && entry[3] < y   # �p�~�N�ȍ~
        holiday = entry[1](y)                   # �x�����v�Z
        continue unless holiday?                # �����ł���Ζ���
        m = holiday.getMonth()+1                # ���ʂ�o�^
        d = holiday.getDate()
        wo_furikae[ [m,d] ] = entry[0]
    holidays[false][y] = wo_furikae
    
    # �����̋x����ǉ�����
    kokuminHolidays = []
    for month_day of wo_furikae
        month_day = month_day.split(",")
        holiday = kokuminHoliday( new Date(y, month_day[0]-1, month_day[1] ) )
        if holiday?
            m = holiday.getMonth()+1            # ���ʂ�o�^
            d = holiday.getDate()
            kokuminHolidays.push([m,d])
    for holiday in kokuminHolidays
        wo_furikae[holiday] = "�����̋x��"
    
    # �U�֋x����ǉ�����
    w_furikae = {}
    for month_day, name of wo_furikae
        w_furikae[month_day] = name
        month_day = month_day.split(",")
        holiday = furikaeHoliday( new Date(y, month_day[0]-1, month_day[1] ) )
        if holiday?
            m = holiday.getMonth()+1            # ���ʂ�o�^
            d = holiday.getDate()
            w_furikae[ [m,d] ] = "�U�֋x��"
    holidays[true][y] = w_furikae               # ���ʂ�o�^
    return holidays[furikae][y]

Date.getHolidaysOf = (y, furikae) ->
    # �f�[�^�𐮌`����
    result = []
    for month_day, name of getHolidaysOf(y, furikae)
        result.push(
            month : parseInt(month_day.split(",")[0])
            date  : parseInt(month_day.split(",")[1])
            name  : name
        )
    # ���t���ɕ��ג���
    result.sort( (a,b)-> (a.month-b.month) or (a.date-b.date) )
    result

Date::isHoliday = (furikae) ->
    return getHolidaysOf(@getFullYear(), furikae)[ [@getMonth()+1, @getDate()] ]
