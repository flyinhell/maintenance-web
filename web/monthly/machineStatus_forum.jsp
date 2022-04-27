<%--
  Created by IntelliJ IDEA.
  User: kueihenglu
  Date: 2018/8/23
  Time: 下午 03:01
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
            $("#selectMachineStatus").click(function () {
                var args = "type=select";
                $.ajax({
                    type: "POST",
                    url: '../monthly/machineStatus_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#machineStatus_resultScope").html(html);
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
<table class="table table-hover">
    <tbody class="topicTableContent">
    <form>
        <tr>

            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                   id="selectMachineStatus"><span>查詢</span></a></td>

        </tr>
    </form>
    </tbody>
</table>
<div id="machineStatus_resultScope"></div>

</body>
</html>
