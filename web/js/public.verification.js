// ryan : " <, >, ', ", &, #, %"
function verificationCharacters(obj, message) {
    if (obj.indexOf("<") != -1 || obj.indexOf(">") != -1 || obj.indexOf("'") != -1 || obj.indexOf('"') != -1
        || obj.indexOf('&') != -1 || obj.indexOf('#') != -1 || obj.indexOf('%') != -1) {

        alert(message + "< , > , ' , \" ,& ,# ,%");
        return false;
    }
    return true;
}

var searchMaxRange; //最大搜尋範圍限制的月份數
var searchSdate;    //DB設定的搜尋起始日
var searchEdate;    //DB設定的搜尋結束日
var inEnableEducationView; //教育用特殊可視範圍
var searchRangeType; //判別線上搜尋範圍的方式
var startDateFrom;   //組完最後的起始日期
var endDateTo;       //組完最後的結束日期

function getDateParameter() {
    var args = "";
    var sdate = new Date($('#from').val());
    var edate = new Date($('#to').val());
    var today = new Date();
    var monthAgo = new Date();
    var interval = (edate - sdate) / 86400000;  //計算天數差距，因搜尋區間不可超過三個月


    if (searchRangeType == "nMonth") {
        monthAgo.setFullYear(today.getFullYear());
        monthAgo.setMonth(today.getMonth() - searchMaxRange);  //扣掉最大月份的天數往前算，就是搜尋日期的底線
        monthAgo.setDate(1);
    } else if (searchRangeType == "onlySdate" || searchRangeType == "rangeDate") {
        monthAgo = new Date(searchSdate);
    }

    monthAgo.setHours(0, 0, 0, 0);

    if (!isNaN(sdate) && !isNaN(edate)) {
        if (interval > 92) {
            alert("查詢的資料區間最多只能在3個月內。");
            return null;
        }
        if (edate >= sdate && ( sdate <= today) &&
            ( edate <= today)) {
            args += "&sDate=" + $('#from').val() + "&eDate=" + $('#to').val();
        } else {
            alert('日期區間錯誤');
            return null;
        }
    }

    return args;
}

//驗證Email格式
function isEmail(email) {
    var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    return regex.test(email);
}


//計算小日曆的最小日期
function calculateMinDate() {
    var currentTime = new Date();
    var calculateTime = new Date();
    var calculateEndTime = new Date();
    calculateTime.setFullYear(currentTime.getFullYear());
    calculateTime.setMonth(currentTime.getMonth() - 3); //扣掉最大月份的天數往前算，就是搜尋日期的底線
    calculateTime.setDate(1);


    startDateFrom = new Date(calculateTime);  //組完最後的起始日期
    endDateTo = new Date(calculateEndTime);  //組完最後的結束日期
}
