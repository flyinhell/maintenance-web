<%--
  Created by IntelliJ IDEA.
  User: zhenfuliao
  Date: 2020/5/19
  Time: 下午 02:09
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


            //外部程式呼叫
            $("#selectStandard").click(function () {
                if (confirm("確定要執行外部 kill SearchCommand嗎?")) {
                    var args = "type=selectStandard";
                    $.ajax({
                        type: "POST",
                        url: '../operate/killSearchCommand_execute_operate.jsp',
                        data: args,

                        success: function (html) {
                            if (args == '') {
                            } else
                                alert("已呼叫執行外部 kill SearchCommand程序");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("Standard SearchCommand關閉失敗,請稍後再試..");
                        }
                    });
                }
            });


            //內部程式呼叫
            $("#selectStaff").click(function () {
                if (confirm("確定要執行內部 kill SearchCommand嗎?")) {
                    var args = "type=selectStaff";
                    $.ajax({
                        type: "POST",
                        url: '../operate/killSearchCommand_execute_operate.jsp',
                        data: args,

                        success: function (html) {
                            if (args == '') {
                            } else
                                alert("已呼叫執行內部 kill SearchCommand程序");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("Staff SearchCommand關閉失敗,請稍後再試..");
                        }
                    });
                }
            });
            //分流程式呼叫
            $("#selectAdvanced").click(function () {
                if (confirm("確定要執行分流 kill SearchCommand嗎?")) {
                    var args = "type=selectAdvanced";
                    $.ajax({
                        type: "POST",
                        url: '../operate/killSearchCommand_execute_operate.jsp',
                        data: args,

                        success: function (html) {
                            if (args == '') {
                            } else
                                alert("已呼叫執行分流 kill SearchCommand程序");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("分流SearchCommand關閉失敗,請稍後再試..");
                        }
                    });
                }
            });
            //Instant程式呼叫
            $("#selectInstant").click(function () {
                if (confirm("確定要執行Instant kill SearchCommand嗎?")) {
                    var args = "type=selectInstant";
                    $.ajax({
                        type: "POST",
                        url: '../operate/killSearchCommand_execute_operate.jsp',
                        data: args,

                        success: function (html) {
                            if (args == '') {
                            } else
                                alert("已呼叫執行Instant kill SearchCommand程序");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("Instant SearchCommand關閉失敗,請稍後再試..");
                        }
                    });
                }
            });


        });
    </script>
</head>


<body>
<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" id="selectStandard"><span>外部</span></a></td>
        </tr>
        </tbody>
    </table>

</form>

<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" id="selectStaff"><span>內部</span></a></td>
        </tr>
        </tbody>
    </table>

</form>

<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" id="selectAdvanced"><span>分流</span></a></td>
        </tr>
        </tbody>
    </table>

</form>

<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" id="selectInstant"><span>Instant</span></a></td>
        </tr>
        </tbody>
    </table>

</form>


<div id="killSC_resultScope"></div>
</body>
</html>
