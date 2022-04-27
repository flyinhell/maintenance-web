<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/3
  Time: 下午 12:06
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

        //        $('#indexPath').trigger("click");


        $(document).ready(function () {
            $("#inline").fancybox({});
            $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});
            //傳送查詢條件(未完成任務)
            $(function () {
                $.ajax({
                    type: "POST",
                    url: '../copy/indexPath_result.jsp',
                    success: function (html) {
                        $("#indexPath_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            })(jQuery);



        });
    </script>
</head>
<body>
<table class="table table-hover">
    <tbody class="topicTableContent">
    <form>
        <tr>
            <td colspan="6"><a href="#" type="button" style="width:155px;height:25px;font-size:14px" class="btn btn-primary"
                               id="indexPath" onclick="javascript:window.location.reload();"><span>刷新狀態</span></a></td>
        </tr>
    </form>

    </tbody>
</table>
<div id="indexPath_resultScope"></div>

</body>
</html>
