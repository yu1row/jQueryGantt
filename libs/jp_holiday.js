/*

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
    �w���p�֐�
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
    �x���f�[�^
    https://ja.wikipedia.org/wiki/%E5%9B%BD%E6%B0%91%E3%81%AE%E7%A5%9D%E6%97%A5
 */

definition = [["���U", simpleHoliday(1, 1), 1949], ["���l�̓�", simpleHoliday(1, 15), 1949, 1999], ["���l�̓�", happyMonday(1, 2), 2000], ["�����L�O�̓�", simpleHoliday(2, 11), 1967], ["���a�V�c�̑�r�̗�", simpleHoliday(2, 24), 1989, 1989], ["�t���̓�", shunbun, 1949], ["���m�e���̌����̋V", simpleHoliday(4, 10), 1959, 1959], ["�V�c�a����", simpleHoliday(4, 29), 1949, 1988], ["�݂ǂ�̓�", simpleHoliday(4, 29), 1989, 2006], ["���a�̓�", simpleHoliday(4, 29), 2007], ["���@�L�O��", simpleHoliday(5, 3), 1949], ["�݂ǂ�̓�", simpleHoliday(5, 4), 2007], ["���ǂ��̓�", simpleHoliday(5, 5), 1949], ["���m�e���̌����̋V", simpleHoliday(6, 9), 1993, 1993], ["�C�̓�", simpleHoliday(7, 20), 1996, 2002], ["�C�̓�", happyMonday(7, 3), 2003], ["�R�̓�", simpleHoliday(8, 11), 2016], ["�h�V�̓�", simpleHoliday(9, 15), 1966, 2002], ["�h�V�̓�", happyMonday(9, 3), 2003], ["�H���̓�", shubun, 1948], ["�̈�̓�", simpleHoliday(10, 10), 1966, 1999], ["�̈�̓�", happyMonday(10, 2), 2000], ["�����̓�", simpleHoliday(11, 3), 1948], ["���ʂ̗琳�a�̋V", simpleHoliday(11, 12), 1990, 1990], ["�ΘJ���ӂ̓�", simpleHoliday(11, 23), 1948], ["�V�c�a����", simpleHoliday(12, 23), 1989]];

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
    wo_furikae[holiday] = "�����̋x��";
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
      w_furikae[[m, d]] = "�U�֋x��";
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