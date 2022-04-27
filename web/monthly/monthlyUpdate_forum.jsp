<%--
  Created by IntelliJ IDEA.
  User: kueihenglu
  Date: 2018/8/23
  Time: 下午 09:35
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
        $("#selectIndexConfig").click(function () {
            $.ajax({
                type: "POST",
                url: '../monthly/monthlyUpdate_result.jsp',
                success: function (html) {
                    $("#indexConfig_resultScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        $("#updateIndexConfig_machine").click(function () {
            var args = getUpdateMachine_args();
            $.ajax({
                type: "POST",
                url: '../monthly/monthlyUpdate_operate.jsp',
                data: args,
                success: function (html) {
                    $("#indexConfig_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        $("#updateIndexConfig_mapping").click(function () {
            var args = getUpdateMapping_args();
            $.ajax({
                type: "POST",
                url: '../monthly/monthlyUpdate_operate.jsp',
                data: args,
                success: function (html) {
                    $("#indexConfig_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        $("#updateIndexConfig_database").click(function () {
            var args = getUpdateDatabase_args();
            $.ajax({
                type: "POST",
                url: '../monthly/monthlyUpdate_operate.jsp',
                data: args,
                success: function (html) {
                    $("#indexConfig_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        //刪除
        $("#deleteIndexConfig").click(function () {
            var args = getDeleteIndexConfig_args();
            $.ajax({
                type: "POST",
                url: '../monthly/monthlyUpdate_operate.jsp',
                data: args,
                success: function (html) {
                    $("#indexConfig_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

    });

    function getUpdateMachine_args() {
        var args = 'type=updateMachine';
        var count = 0;

        var indexName = '';
        indexName = $("#indexConfig_indexNameField").val();
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

    function getUpdateMapping_args() {
        var args = 'type=updateMapping';
        var count = 0;

        var indexName = '';
        indexName = $("#indexConfig_indexNameField").val();
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

    function getUpdateDatabase_args() {
        var args = 'type=updateDatabase';
        var count = 0;

        var indexName = '';
        indexName = $("#indexConfig_indexNameField").val();
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

    function getDeleteIndexConfig_args() {
        var args = 'type=delete';
        var count = 0;

        var indexName = '';
        indexName = $("#indexConfig_indexNameField").val();
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
</script>


<body>
<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" id="updateIndexConfig_machine"><span>修改機器位置</span></a>
            </td>

            <td><a href="#" type="button" class="btn btn-primary"
                   id="updateIndexConfig_mapping"><span>修改Mapping設定</span></a></td>

            <td><a href="#" type="button" class="btn btn-primary"
                   id="updateIndexConfig_database"><span>修改資料庫設定</span></a></td>

            <td><a href="#" type="button" class="btn btn-primary" id="deleteIndexConfig"><span>刪除索引設定</span></a></td>

            <td colspan="5"><input type="text" style="width:180px;height:30px" class="textInput" placeholder="索引庫名稱"
                                   id="indexConfig_indexNameField"></td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
        </tr>
        </tbody>
    </table>
    <div id="indexConfig_operateScope"></div>
</form>


<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="selectIndexConfig"><span>跨月索引查詢</span></a></td>
        </tr>

        </tbody>

    </table>
    <div id="indexConfig_resultScope"></div>
</form>


</body>
</html>

