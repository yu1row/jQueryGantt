/*

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
 */
var definition, furikaeHoliday, getHolidaysOf, happyMonday, holidays, kokuminHoliday, shubun, shunbun, simpleHoliday;

Date.prototype.getShifted = function(year, mon, day, hour, min, sec, msec) {
  var res;
  res = new Date();
  res.setTime(this.getTime() + ((((day != null ? day : 0) * 24 + (hour != null ? hour : 0)) * 60 + (min != null ? min : 0)) * 60 + (sec != null ? sec : 0)) * 1000 + (msec != null ? msec : 0));
  res.setFullYear(res.getFullYear() + (year != null ? year : 0) + Math.floor((res.getMonth() + (mon != null ? mon : 0)) / 12));
  res.setMonth(((res.getMonth() + (mon != null ? mon : 0)) % 12 + 12) % 12);
  return res;
};


/*
    ƒwƒ‹ƒpŠÖ”
 */

simpleHoliday = function(month, day) {
  return function(year) {
    return new Date(year, month - 1, day);
  };
};

happyMonday = function(month, nth) {
  return function(year) {
    var first, monday;
    monday = 1;
    first = new Date(year, month - 1, 1);
    return first.getShifted(0, 0, (7 - (first.getDay() - monday)) % 7 + (nth - 1) * 7);
  };
};

shunbun = function(year) {
  var date;
  date = new Date();
  date.setTime(-655910271894.040039 + 31556943676.430065 * (year - 1949) + 24 * 3600 * 1000 / 2);
  return new Date(year, date.getMonth(), date.getDate());
};

shubun = function(year) {
  var date;
  date = new Date();
  date.setTime(-671361740118.508301 + 31556929338.445450 * (year - 1948) + 24.3 * 3600 * 1000 / 2);
  return new Date(year, date.getMonth(), date.getDate());
};


/*
    ‹x“úƒf[ƒ^
    https://ja.wikipedia.org/wiki/%E5%9B%BD%E6%B0%91%E3%81%AE%E7%A5%9D%E6%97%A5
 */

definition = [["Œ³’U", simpleHoliday(1, 1), 1949], ["¬l‚Ì“ú", simpleHoliday(1, 15), 1949, 1999], ["¬l‚Ì“ú", happyMonday(1, 2), 2000], ["Œš‘‹L”O‚Ì“ú", simpleHoliday(2, 11), 1967], ["º˜a“Vc‚Ì‘å‘r‚Ì—ç", simpleHoliday(2, 24), 1989, 1989], ["t•ª‚Ì“ú", shunbun, 1949], ["–¾me‰¤‚ÌŒ‹¥‚Ì‹V", simpleHoliday(4, 10), 1959, 1959], ["“Vc’a¶“ú", simpleHoliday(4, 29), 1949, 1988], ["‚İ‚Ç‚è‚Ì“ú", simpleHoliday(4, 29), 1989, 2006], ["º˜a‚Ì“ú", simpleHoliday(4, 29), 2007], ["Œ›–@‹L”O“ú", simpleHoliday(5, 3), 1949], ["‚İ‚Ç‚è‚Ì“ú", simpleHoliday(5, 4), 2007], ["‚±‚Ç‚à‚Ì“ú", simpleHoliday(5, 5), 1949], ["“¿me‰¤‚ÌŒ‹¥‚Ì‹V", simpleHoliday(6, 9), 1993, 1993], ["ŠC‚Ì“ú", simpleHoliday(7, 20), 1996, 2002], ["ŠC‚Ì“ú", happyMonday(7, 3), 2003], ["R‚Ì“ú", simpleHoliday(8, 11), 2016], ["Œh˜V‚Ì“ú", simpleHoliday(9, 15), 1966, 2002], ["Œh˜V‚Ì“ú", happyMonday(9, 3), 2003], ["H•ª‚Ì“ú", shubun, 1948], ["‘Ìˆç‚Ì“ú", simpleHoliday(10, 10), 1966, 1999], ["‘Ìˆç‚Ì“ú", happyMonday(10, 2), 2000], ["•¶‰»‚Ì“ú", simpleHoliday(11, 3), 1948], ["‘¦ˆÊ‚Ì—ç³“a‚Ì‹V", simpleHoliday(11, 12), 1990, 1990], ["‹Î˜JŠ´Ó‚Ì“ú", simpleHoliday(11, 23), 1948], ["“Vc’a¶“ú", simpleHoliday(12, 23), 1989]];

furikaeHoliday = function(holiday) {
  var furikae, sunday;
  sunday = 0;
  if (holiday < new Date(1973, 4 - 1, 30 - 1) || holiday.getDay() !== sunday) {
    return null;
  }
  furikae = holiday.getShifted(0, 0, 1);
  if (!furikae.isHoliday(false)) {
    return furikae;
  }
  if (holiday < new Date(2007, 1 - 1, 1)) {
    return null;
  }
  while (true) {
    furikae = furikae.getShifted(0, 0, 1);
    if (!furikae.isHoliday(false)) {
      return furikae;
    }
  }
};

kokuminHoliday = function(holiday) {
  var kokumin, monday, sunday;
  if (holiday.getFullYear() < 1988) {
    return null;
  }
  if (!holiday.getShifted(0, 0, 2).isHoliday(false)) {
    return null;
  }
  sunday = 0;
  monday = 1;
  kokumin = holiday.getShifted(0, 0, 1);
  if (kokumin.isHoliday(false) || kokumin.getDay() === sunday || kokumin.getDay() === monday) {
    return null;
  }
  return kokumin;
};

holidays = {
  "true": {},
  "false": {}
};

getHolidaysOf = function(y, furikae) {
  var cache, d, entry, holiday, kokuminHolidays, m, month_day, name, w_furikae, wo_furikae, _i, _j, _len, _len1;
  furikae = (furikae == null) || furikae ? true : false;
  cache = holidays[furikae][y];
  if (cache != null) {
    return cache;
  }
  wo_furikae = {};
  for (_i = 0, _len = definition.length; _i < _len; _i++) {
    entry = definition[_i];
    if ((entry[2] != null) && y < entry[2]) {
      continue;
    }
    if ((entry[3] != null) && entry[3] < y) {
      continue;
    }
    holiday = entry[1](y);
    if (holiday == null) {
      continue;
    }
    m = holiday.getMonth() + 1;
    d = holiday.getDate();
    wo_furikae[[m, d]] = entry[0];
  }
  holidays[false][y] = wo_furikae;
  kokuminHolidays = [];
  for (month_day in wo_furikae) {
    month_day = month_day.split(",");
    holiday = kokuminHoliday(new Date(y, month_day[0] - 1, month_day[1]));
    if (holiday != null) {
      m = holiday.getMonth() + 1;
      d = holiday.getDate();
      kokuminHolidays.push([m, d]);
    }
  }
  for (_j = 0, _len1 = kokuminHolidays.length; _j < _len1; _j++) {
    holiday = kokuminHolidays[_j];
    wo_furikae[holiday] = "‘–¯‚Ì‹x“ú";
  }
  w_furikae = {};
  for (month_day in wo_furikae) {
    name = wo_furikae[month_day];
    w_furikae[month_day] = name;
    month_day = month_day.split(",");
    holiday = furikaeHoliday(new Date(y, month_day[0] - 1, month_day[1]));
    if (holiday != null) {
      m = holiday.getMonth() + 1;
      d = holiday.getDate();
      w_furikae[[m, d]] = "U‘Ö‹x“ú";
    }
  }
  holidays[true][y] = w_furikae;
  return holidays[furikae][y];
};

Date.getHolidaysOf = function(y, furikae) {
  var month_day, name, result, _ref;
  result = [];
  _ref = getHolidaysOf(y, furikae);
  for (month_day in _ref) {
    name = _ref[month_day];
    result.push({
      month: parseInt(month_day.split(",")[0]),
      date: parseInt(month_day.split(",")[1]),
      name: name
    });
  }
  result.sort(function(a, b) {
    return (a.month - b.month) || (a.date - b.date);
  });
  return result;
};

Date.prototype.isHoliday = function(furikae) {
  return getHolidaysOf(this.getFullYear(), furikae)[[this.getMonth() + 1, this.getDate()]];
};

// ---
// generated by coffee-script 1.9.0