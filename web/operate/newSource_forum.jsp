<%--
  Created by IntelliJ IDEA.
  User: zhenfuliao
  Date: 2020/5/14
  Time: 下午 05:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ include file="../include/html_head.jsp" %>
<html>
<head>
    <title></title>
</head>
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
        $("#selectNewSource").click(function () {
            var args = getNewSource_args();
            $.ajax({
                type: "POST",
                url: '../operate/newSource_result.jsp',
                data: args,
                success: function (html) {
                    $("#newSource_resultScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        //新增新來源
        $("#insertNewSource").click(function () {
            var args = getInsertNewSource_args();
            $.ajax({
                type: "POST",
                url: '../operate/newSource_operate.jsp',
                data: args,
                success: function (html) {
                    $("#newSource_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });


        //刪除新來源
        $("#deleteNewSource").click(function () {
            var args = getDeleteNewSource_args();
            $.ajax({
                type: "POST",
                url: '../operate/newSource_operate.jsp',
                data: args,
                success: function (html) {
                    $("#newSource_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

    });

    function getInsertNewSource_args() {
        var args = 'type=insert';
        return args;
    }

    function getNewSource_args() {
        var args = 'type=select';
        var count = 0;

        var newSource = '';
        newSource = $("#task_newSourceField").val();
        if (newSource != "" && newSource != null) {
//            args += "&indexName=" + indexName;
            args += "&newSource=" + encodeURIComponent(newSource);
            count += 1;
        }

        //沒有下新來源名稱條件
        if (count <= 0) {
            args = "";
        }
        return args;
    }


    function getDeleteNewSource_args() {
        var args = 'type=delete';
        var count = 0;

        var newSource = '';
        newSource = $("#newSource_Field").val();
        if (newSource != "" && newSource != null) {
//            args += "&newSource=" + newSource;
            args += "&newSource=" + encodeURIComponent(newSource);
            count += 1;
        }

        //沒有下索引名稱條件
        if (count <= 0) {
            args = "";
        }
        return args;
    }
</script>


<body>
<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" id="insertNewSource"><span>新增新來源</span></a></td>
            <!--  <td><a href="#" type="button" class="btn btn-primary" id="deleteNewSource"><span>刪除新來源</span></a></td>
              <td colspan="5"><input type="text" style="width:180px;height:30px" class="textInput" placeholder="新來源名稱"
                                     id="newSource_Field"></td> -->
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
        </tr>
        </tbody>
    </table>
    <div id="newSource_operateScope"></div>
</form>


<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" id="selectNewSource"><span>新來源查詢</span></a></td>

            <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="新來源名稱確認"
                       id="task_newSourceField"></td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
        </tr>


        </tbody>

    </table>
    <div id="newSource_resultScope"></div>
</form>

</body>
</html>
