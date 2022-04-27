<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: kueihenglu
  Date: 2018/8/23
  Time: 下午 03:00
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

        //組索引名稱的搜尋條件
        function getErrorLogByDateTime_args() {
            var args = 'type=dateTime';
            var count = 0;

            var startTime = '';
            startTime = $("#errorLog_startTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#errorLog_endTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }

            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        $(document).ready(function () {

            $("#inline").fancybox({});
            $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});


            /*$(function () {
                $.ajax({
                    type: "POST",
                    url: '../monthly/errorLog_result.jsp',
                    success: function (html) {
                        $("#errorLog_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            })(jQuery);*/


            //傳送查詢條件
            $("#selectErrorLog").click(function () {
                var args = getErrorLogByDateTime_args();
                $.ajax({
                    type: "POST",
                    url: '../monthly/errorLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#errorLog_resultScope").html(html);
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
<%
    SimpleDateFormat startTimeDateFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
    SimpleDateFormat endTimeDateFormat = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
    Calendar fast = Calendar.getInstance();
    Calendar end = Calendar.getInstance();
    fast.add(Calendar.MONTH, 0);
    fast.set(Calendar.DAY_OF_MONTH, 1);
    end.set(Calendar.DAY_OF_MONTH, end.getActualMaximum(Calendar.DAY_OF_MONTH));
    String startTime = startTimeDateFormat.format(fast.getTime());
    String endTime = endTimeDateFormat.format(end.getTime());
%>
<body>
<table class="table table-hover">
    <tbody class="topicTableContent">
    <form>
        <tr>

            <td><a href="#" type="button" style="width:155px;"
                   class="btn btn-primary" id="selectErrorLog"><span>查詢</span></a></td>

            <td>錯誤時間(error_time)</td>
            <td colspan="2">
                <input type="text" style="width:150px;height:30px" class="textInput" value="<%=startTime%>"
                       id="errorLog_startTimeField">
                &nbsp;&nbsp;~&nbsp;
                <input type="text" style="width:150px;height:30px" class="textInput" value="<%=endTime%>"
                       id="errorLog_endTimeField"></td>

        </tr>
    </form>
    </tbody>
</table>
<div id="errorLog_resultScope"></div>

</body>
</html>
