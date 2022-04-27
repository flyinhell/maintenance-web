<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/9
  Time: 下午 06:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ include file="../include/html_head.jsp" %>
<html>
<head>
    <style type="text/css">
        .textInput, select {
            width: 250px
        }
    </style>

    <script>
        (function ($) {
            $(document).ready(function () {
                $(".COMPtheme, .COMPcenter, #scrollbar1").mCustomScrollbar({
                    theme: "dark"
                });
            });
        })(jQuery);

        $(document).ready(function () {

            $("#inline").fancybox({});
            $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});


            //傳送查詢條件
            $("#selectBuildFailRecords").click(function () {
                var args = "type=select";
                $.ajax({
                    type: "POST",
                    url: '../index/buildFailRecords_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#buildFailRecords_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //清除查詢條件
            $("#clearBuildFailRecords").click(function () {
                var args = "type=clear";
                $.ajax({
                    type: "POST",
                    url: '../index/buildFailRecords_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#buildFailRecords_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
        });
    </script>
</head>
<body>
<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">

        <tr>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="selectBuildFailRecords"><span>查詢失敗紀錄</span></a>
            </td>
            <td></td>
        </tr>

        <tr>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="clearBuildFailRecords"><span>清除失敗紀錄</span></a>
            </td>
            <td></td>
        </tr>

        </tbody>
    </table>
</form>

<div id="buildFailRecords_resultScope"></div>

</body>
</html>