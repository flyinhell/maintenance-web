/**
 * User: wycai
 * Date: 2013/7/23
 * Time: 下午 7:12
 *  依據使用者勾選的資訊，顯示在圖表上方區塊
 */
var topicDisplayName = '';  //勾選主題名稱
var dimensionDisplayName = ''; //勾選維度名稱
var extraKeyword = ''; //自訂關鍵字
var sourceDisplayName = ''; //勾選來源名稱
var exculdeWebSiteName;   //sourceId中文名稱
var sourceHit;  //判斷是否有選取sourceId
var stop_ajax = null;  //停止ajax

//設定顯示在portlet的時間、來源、主題、關鍵字、維度等資訊
function setSearchCriteria() {
    //取得 勾選來源名稱
    var sourceLength = $("input[name=source_filter]:checked").length;
    sourceDisplayName = "";
    $("input[name=source_filter]:checked").each(function (index) {
        sourceDisplayName += $(this).parent("label").text();
        //判斷是否為最後一個
        if (index !== (sourceLength - 1)) {
            sourceDisplayName += ' ' + ',' + ' ';
        }
    });

    //取得 勾選主題名稱
    var topicLength = $("input[name=topic_filter]:checked").length;
    topicDisplayName = "";
    $("input[name=topic_filter]:checked").each(function (index) {
        topicDisplayName += $(this).parent("label").children("span").text();
        //判斷是否為最後一個
        if (index !== (topicLength - 1)) {
            topicDisplayName += ' ' + ',' + ' ';
        }
    });

    //取得 勾選維度名稱
    dimensionDisplayName = "";
    //判斷不為 維度頁面
    if ($("#dimension_filter option:first").attr("disabled") != "disabled") {

        dimensionDisplayName = $("#dimension_filter :selected").text();
        if (dimensionDisplayName == "不指定維度") {
            dimensionDisplayName = "";
        }
    }

    //取得 自訂關鍵字
    if (document.getElementById("keyword")) {
        extraKeyword = $('#keyword').val();
    }

    //顯示取消查詢的按鈕
    toggleSearchButton();
}

//取得並將時間、來源、主題、關鍵字、維度等資訊顯示在portlet上
function getSearchCriteria() {
    var pathName = location.pathname;
    var title = "";
    //判斷是否為文章列表  文章列表顯示查詢條件方式為和其他頁面不同
    if (pathName.indexOf("/View/List") != -1) {
        var portletDiv = $(".portlet").children("div").children("p");
        if (topicDisplayName != "" && topicDisplayName.length > 0) {
            portletDiv.append("/&nbsp;" + topicDisplayName);
            title += topicDisplayName;
        }
        if (sourceDisplayName.length > 0 && sourceDisplayName != "") {
            portletDiv.append("&nbsp;/" + sourceDisplayName);
            title += " /" + sourceDisplayName;
        }
        if (dimensionDisplayName != "" && dimensionDisplayName.length > 0) {
            portletDiv.append("&nbsp;/&nbsp;" + dimensionDisplayName);
            title += " /" + dimensionDisplayName;
        }
        if (extraKeyword.length > 0 && extraKeyword != "") {
            portletDiv.append("&nbsp;/&nbsp;" + extraKeyword);
            title += "/" + extraKeyword;
        }
        //若查詢條件過長，可以用title觀看
        portletDiv.attr("title", title);
    } else {
        //將勾選資訊 顯示在圖表上方
        $(".portlet").each(function () {
            var portletDiv = $(this).children("div").children("p");
            if (topicDisplayName != "" && topicDisplayName.length > 0) {
                portletDiv.append("主題：" + topicDisplayName);
            }
            if (dimensionDisplayName != "" && dimensionDisplayName.length > 0) {
                portletDiv.append("&nbsp;&nbsp; 維度：" + dimensionDisplayName);
            }
            if (extraKeyword.length > 0 && extraKeyword != "") {
                portletDiv.append("&nbsp;&nbsp; 關鍵字篩選：" + extraKeyword);
            }
        });
    }

    $(".portlet > div:nth-child(2)").each(function () {
        //判斷不為 文章列表頁面
        var pathName = location.pathname;
        if (pathName.indexOf("/View/List") == -1 && pathName.indexOf("SearchPortal") == -1) {
            var subFilterDiv = $(this).children("div:first-child");
            if (sourceDisplayName.length > 0 && sourceDisplayName != "") {
                subFilterDiv.append('<li>資料來源：</li><li>' + sourceDisplayName + '</li>');
            }
        }
    });
}

//加入排除網站
function addExcludeSite() {
    var excludeWebSiteId = $("#ddl_sourceId").val();
    if (excludeWebSiteId == null || excludeWebSiteId == '') {
        exculdeWebSiteName = "";
        sourceHit = false;
    } else {
        exculdeWebSiteName = "";
        $("#ddl_sourceId option:selected").each(function () {
            exculdeWebSiteName += $(this).text() + "、";
        });
        exculdeWebSiteName = exculdeWebSiteName.substring(0, exculdeWebSiteName.length - 1);
        sourceHit = true;
        return excludeWebSiteId;
    }
}

//截斷顯示用的篩選網站選單中的網站名稱
function splitIdOption() {
    if (sourceHit == true) {
        $("#ddl_sourceId").parent("li").hide();
        $(".lockSID").parent("li").show();
    }
    $(".lockSID").attr("title", exculdeWebSiteName);
    if (exculdeWebSiteName.length > 40) {
        $(".lockSID").text(exculdeWebSiteName.substr(0, 40) + "...");
    } else {
        $(".lockSID").text(exculdeWebSiteName);
    }

}

//切換查詢or取消查詢判斷
function toggleSearchButton() {
    if ($("#search").hasClass("cancel")) {
        $("#search").text("查 詢")
    } else {
        $("#search").text("取 消")
    }
    $("#search").toggleClass("cancel");
}

//終止AJAX執行
function stopAJAX() {
    if (stop_ajax != null) {
        stop_ajax.abort();
    }
    $("#temp_porlet").remove();
    $("#temp_porlet1").remove();
    $("#temp_porlet2").remove();
    $("#temp_porlet3").remove();
    $("#newsFinder").hide();
    $("#searchSection").hide();
    $("#filterSiteDiv").hide();
}