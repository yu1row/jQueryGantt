


  function dateToRelative(localTime){
    var diff=new Date().getTime()-localTime;
    var ret="";

    var min=60000;
    var hour=3600000;
    var day=86400000;
    var wee=604800000;
    var mon=2629800000;
    var yea=31557600000;

    if (diff<-yea*2)
      ret ="in ## years".replace("##",(-diff/yea).toFixed(0));

    else if (diff<-mon*9)
      ret ="in ## months".replace("##",(-diff/mon).toFixed(0));

    else if (diff<-wee*5)
      ret ="in ## weeks".replace("##",(-diff/wee).toFixed(0));

    else if (diff<-day*2)
      ret ="in ## days".replace("##",(-diff/day).toFixed(0));

    else if (diff<-hour)
      ret ="in ## hours".replace("##",(-diff/hour).toFixed(0));

    else if (diff<-min*35)
      ret ="in about one hour";

    else if (diff<-min*25)
      ret ="in about half hour";

    else if (diff<-min*10)
      ret ="in some minutes";

    else if (diff<-min*2)
      ret ="in few minutes";

    else if (diff<=min)
      ret ="just now";

    else if (diff<=min*5)
      ret ="few minutes ago";

    else if (diff<=min*15)
      ret ="some minutes ago";

    else if (diff<=min*35)
      ret ="about half hour ago";

    else if (diff<=min*75)
      ret ="about an hour ago";

    else if (diff<=hour*5)
      ret ="few hours ago";

    else if (diff<=hour*24)
      ret ="## hours ago".replace("##",(diff/hour).toFixed(0));

    else if (diff<=day*7)
      ret ="## days ago".replace("##",(diff/day).toFixed(0));

    else if (diff<=wee*5)
      ret ="## weeks ago".replace("##",(diff/wee).toFixed(0));

    else if (diff<=mon*12)
      ret ="## months ago".replace("##",(diff/mon).toFixed(0));

    else
      ret ="## years ago".replace("##",(diff/yea).toFixed(0));

    return ret;
  }

  //override date format i18n
  
  Date.monthNames = ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"];
  // Month abbreviations. Change this for local month names
  Date.monthAbbreviations = ["1","2","3","4","5","6","7","8","9","10","11","12"];
  // Full day names. Change this for local month names
  Date.dayNames =["日曜","月曜","火曜","水曜","木曜","金曜","土曜"];
  // Day abbreviations. Change this for local month names
  Date.dayAbbreviations = ["日","月","火","水","木","金","土"];
  // Used for parsing ambiguous dates like 1/2/2000 - default to preferring 'American' format meaning Jan 2.
  // Set to false to prefer 'European' format meaning Feb 1
  Date.preferAmericanFormat = false;

  Date.firstDayOfWeek =0;
  Date.defaultFormat = "yyyy/MM/dd";


  Number.decimalSeparator = ".";
  Number.groupingSeparator = ",";
  Number.minusSign = "-";
  Number.currencyFormat = "##0.00";



  var millisInWorkingDay =36000000;
  var workingDaysPerWeek =5;
  var holidaysCache      ={};

  function isHoliday(date) {
    var friIsHoly =false;
    var satIsHoly =true;
    var sunIsHoly =true;

    pad = function (val) {
      val = "0" + val;
      return val.substr(val.length - 2);
    };

    var ymd = "#" + date.getFullYear() + "_" + pad(date.getMonth() + 1) + "_" + pad(date.getDate()) + "#";
    var day = date.getDay();
    var y = date.getFullYear();
    
    // build holidays of the specified year
    if ( !(y in holidaysCache) ) {
      var arr = [];
      var dateTmp = new Date(y, 0, 1);
      do {
        if (dateTmp.isHoliday()) {
          arr.push( y + "_" + pad(dateTmp.getMonth() + 1) + "_" + pad(dateTmp.getDate()) );
        }
        dateTmp.setDate(dateTmp.getDate() + 1);
      } while (dateTmp.getFullYear() == y);
      holidaysCache[y] = "#" + arr.join("#") + "#";
    }

    return  (day == 5 && friIsHoly) || (day == 6 && satIsHoly) || (day == 0 && sunIsHoly) || holidaysCache[y].indexOf(ymd) > -1;
  }


  
  var i18n = {
    FORM_IS_CHANGED:"編集が未保存です",
    YES:"はい",
    NO:"いいえ",
    FLD_CONFIRM_DELETE:"削除を行いますか？",
    INVALID_DATA:"挿入されたデータの形式が無効です。",
    ERROR_ON_FIELD:"フィールドエラー",
    CLOSE_ALL_CONTAINERS:"全て閉じますか？",



    DO_YOU_CONFIRM:"これでよろしいですか？"
  };

  