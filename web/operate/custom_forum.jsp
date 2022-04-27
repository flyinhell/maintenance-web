<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/10
  Time: 上午 11:21
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
        $("#selectCustom").click(function () {
            $.ajax({
                type: "POST",
                url: '../operate/custom_result.jsp',
                success: function (html) {
                    $("#custom_resultScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        $("#insertCustom").click(function () {
            var args = getInsertCustom_args();
            $.ajax({
                type: "POST",
                url: '../operate/custom_operate.jsp',
                data: args,
                success: function (html) {
                    $("#custom_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        $("#updateCustom").click(function () {
            var args = getUpdateCustom_args();
            $.ajax({
                type: "POST",
                url: '../operate/custom_operate.jsp',
                data: args,
                success: function (html) {
                    $("#custom_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });
        //傳送查詢條件
        $("#deleteCustom").click(function () {
            var args = getDeleteCustom_args();
            $.ajax({
                type: "POST",
                url: '../operate/custom_operate.jsp',
                data: args,
                success: function (html) {
                    $("#custom_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

    });

    function getInsertCustom_args() {
        var args = 'type=insert';
        return args;
    }

    function getUpdateCustom_args() {
        var args = 'type=update';
        var count = 0;

        var indexName = '';
        indexName = $("#custom_indexNameField").val();
        if (indexName != "" && indexName != null) {
            args += "&indexName=" + encodeURIComponent(indexName);
            count += 1;
        }

        //沒有下索引名稱條件
        if (count <= 0) {
            args = "";
        }
        return args;
    }

    function getDeleteCustom_args() {
        var args = 'type=delete';
        var count = 0;

        var indexName = '';
        indexName = $("#custom_indexNameField").val();
        if (indexName != "" && indexName != null) {
            args += "&indexName=" + indexName;
            args += "&indexName=" + encodeURIComponent(indexName);
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
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="insertCustom"><span>新增客製索引排程</span></a></td>

            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="updateCustom"><span>修改客製索引排程</span></a></td>

            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="deleteCustom"><span>刪除客製索引排程</span></a></td>
            <td colspan="5"><input type="text" style="width:180px;height:30px" class="textInput" placeholder="索引庫名稱"
                                   id="custom_indexNameField"></td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
        </tr>
        </tbody>
    </table>
    <div id="custom_operateScope"></div>
</form>


<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="selectCustom"><span>客製索引排程查詢</span></a></td>
        </tr>

        </tbody>

    </table>
    <div id="custom_resultScope"></div>
</form>


</body>
</html>

