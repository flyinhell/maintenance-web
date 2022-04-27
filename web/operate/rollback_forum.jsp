<%@ page import="com.eland.dao.SourceDatabaseMappingDAO" %>
<%@ page import="com.eland.pojo.model.SourceDatabaseMappingEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %><%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/10
  Time: 上午 11:22
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
        $("#selectRollback").click(function () {
            $.ajax({
                type: "POST",
                url: '../operate/rollback_result.jsp',
                success: function (html) {
                    $("#rollback_resultScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });


        //新增回溯
        $("#insertRollback").click(function () {
            var args = getInsertRollback_args();
            $.ajax({
                type: "POST",
                url: '../operate/rollback_operate.jsp',
                data: args,
                success: function (html) {
                    $("#rollback_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        //刪除成功任務
        $("#deleteSuccessRollback").click(function () {
            var args = getDeleteSuccessRollback_args();
            $.ajax({
                type: "POST",
                url: '../operate/rollback_operate.jsp',
                data: args,
                success: function (html) {
                    $("#rollback_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        //傳送查詢條件
        $("#deleteRollback").click(function () {
            var args = getDeleteRollback_args();
            $.ajax({
                type: "POST",
                url: '../operate/rollback_operate.jsp',
                data: args,
                success: function (html) {
                    $("#rollback_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        //insertSourceRollback
        $("#insertSourceRollback").click(function () {
            var args = getSourceDateTime_args();
            $.ajax({
                type: "POST",
                url: '../operate/rollback_operate.jsp',
                data: args,
                success: function (html) {
                    $("#source_rollbackScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("請填入日期..");
                }
            });
        });

    });

    function getInsertRollback_args() {
        var args = 'type=insert';
        return args;
    }

    function getDeleteSuccessRollback_args() {
        var args = 'type=deleteSuccess';
        return args;
    }


    function getDeleteRollback_args() {
        var args = 'type=delete';
        var count = 0;

        var indexName = '';
        indexName = $("#rollback_indexNameField").val();
        if (indexName != "" && indexName != null) {
//            args += "&indexName=" + indexName;
            args += "&indexName=" + encodeURIComponent(indexName);
            count += 1;
        }

        //沒有下索引名稱條件
        if (count <= 0) {
            args = "";
        }
        return args;
    }

    function getSourceDateTime_args() {
        var args = 'type=SourceTimeRange';
        var count = 0;

        var sourceName = '';
        sourceName = $("#insertSourceName").val();
        if (sourceName != "" && sourceName != null) {
            args += "&sourceName=" + sourceName;
            count += 1;
        }
        var timeRange = '';
        timeRange = $("#SourceRollbackDateTime").val();
        if (timeRange != "" && timeRange != null) {
            args += "&timeRange=" + timeRange;
            count += 1;
        }

        //沒有下名稱條件
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
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="insertRollback"><span>新增索引回溯排程</span></a></td>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="deleteSuccessRollback"><span>刪除成功任務</span></a>
            </td>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="deleteRollback"><span>刪除索引回溯排程</span></a></td>
            <td colspan="5"><input type="text" style="width:180px;height:30px" class="textInput" placeholder="索引庫名稱"
                                   id="rollback_indexNameField"></td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>

        </tr>


        </tbody>
    </table>
    <div id="rollback_operateScope"></div>
</form>

<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <%
            SourceDatabaseMappingDAO sourceDatabaseMappingDAO = new SourceDatabaseMappingDAO();
            List<SourceDatabaseMappingEntity> result = new LinkedList<SourceDatabaseMappingEntity>();
            result = sourceDatabaseMappingDAO.selectDistinctSource();
            String data[] = result.toString().substring(1, result.toString().length() - 1).split(",");
        %>
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="insertSourceRollback"><span>新增來源回溯排程</span></a>
            </td>
            <td colspan="4"><select style="width:150px;" id="insertSourceName">
                <option value="">請選擇來源</option>
                <%for (int i = 0; i < data.length; i++) {%>
                <option value="<%out.print(data[i]);%>"><%out.print(data[i]);%></option>
                <%}%>
            </select><br>
                <input type="text" style="width:180px;height:30px" class="textInput" placeholder="202001~202010"
                       id="SourceRollbackDateTime"></td>
            <td>&nbsp&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp&nbsp</td>

        </tr>

        </tbody>
    </table>
    <div id="source_rollbackScope"></div>
</form>


<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="selectRollback"><span>回溯排程查詢</span></a></td>
        </tr>
        <tr>

        </tr>

        </tbody>

    </table>
    <div id="rollback_resultScope"></div>
</form>

</body>
</html>