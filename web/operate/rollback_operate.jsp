<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.RollbackTaskDAO" %>
<%@ page import="com.eland.pojo.model.IndexRollbackTaskEntity" %>
<%@ page import="com.eland.backend.GetMonthBetween" %>
<%@ page import="com.eland.dao.SourceDatabaseMappingDAO" %>
<%@ page import="com.eland.pojo.model.SourceDatabaseMappingEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/11
  Time: 上午 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
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

            //新增
            $("#rollbackInsert").click(function () {
                var args = get_insertRollback();

                $.ajax({
                    type: "POST",
                    url: '../operate/rollback_execute_operate.jsp',
                    data: args,
                    success: function (html) {
                        alert("新增完成");
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("新增失敗,請確認參數內容");
                    }
                });
            });

        });

        function get_insertRollback() {
            var args = 'type=insert';
            var count = 0;
            var indexName = '';
            var weight = '';
            indexName = $("#rollbackInsert_indexNameField").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
//                args += "&indexName=" + indexName;
                count += 1;
            }
            weight = $("#rollbackInsert_weightField").val();
            if (weight != "" && weight != null) {
                args += "&weight=" + weight;
                count += 1;
            }
            //沒有下任何條件
            if (count <= 1) {
                args = "";
                alert("請填寫內容");
            }
            return args;
        }

        //刪除
        function delete_RollbackIndex(id) {
            var args = "type=delete&id=" + id;
            var del = confirm("確認要刪除任務資料嗎?");
            if (del == true) {
                $.ajax({
                    type: "POST",
                    url: '../operate/rollback_execute_operate.jsp',
                    data: args,
                    success: function (html) {
                        alert("刪除完成");
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("刪除失敗");
                    }
                });
            } else {
            }
        }

    </script>


    <title></title>
</head>
<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String type = reqWrapper.getParameter("type");
    String indexName = "";
    int totalSize = 0;      //資料總筆數
    RollbackTaskDAO rollbackTaskDAO = new RollbackTaskDAO();
    GetMonthBetween getMonthBetween = new GetMonthBetween();
    SourceDatabaseMappingDAO sourceDatabaseMappingDAO = new SourceDatabaseMappingDAO();
    List<SourceDatabaseMappingEntity> result = new LinkedList<SourceDatabaseMappingEntity>();
//    //未完成任務或失敗任務搜尋
    if (type.equals("insert")) {
        request.setAttribute("type", type);
    } else if (type.equals("deleteSuccess")) {
        rollbackTaskDAO.clearBuildSuccessRecords();
        request.setAttribute("type", type);

    } else if (type.equals("SourceTimeRange")) {

        String sourceName = new String(request.getParameter("sourceName").getBytes("ISO8859-1"), "UTF-8");
        String timeRange = new String(request.getParameter("timeRange").getBytes("ISO8859-1"), "UTF-8");
        System.out.println(sourceName);
        System.out.println(timeRange);
        int weight = 2;
        result = sourceDatabaseMappingDAO.selectBySource(sourceName.trim());
        List<String> list = getMonthBetween.getMonthBetween(timeRange);
        for (String s : list) {
            for (SourceDatabaseMappingEntity user : result) {
                indexName = user.getIndexName().replace("DATETIME", s);
                // System.out.println(indexName);
                rollbackTaskDAO.insertIndexRollbackTask(indexName, weight);
                logger.info("Insert Rollback Task Index:" + indexName + " Weight:" + weight);


            }
        }
        request.setAttribute("type", type);
    } else if (type.equals("delete")) {
        List<IndexRollbackTaskEntity> indexRollbackTaskList = new LinkedList<IndexRollbackTaskEntity>();
        try {
            indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
            indexRollbackTaskList = rollbackTaskDAO.selectIndexRollbackTask(indexName);
            totalSize = indexRollbackTaskList.size();

        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexRollbackTaskList", indexRollbackTaskList);
        request.setAttribute("totalSize", totalSize);
        request.setAttribute("type", type);
    }

%>
<body>
<c:choose>

    <c:when test="${type=='delete'&&totalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>IndexName</th>
            <th>ActionFlag</th>
            <th>Status</th>
            <th>Weight</th>
            <th>CreateTime</th>
            <th>UpdateTime</th>
            <c:forEach items="${indexRollbackTaskList}" var="indexRollbackTaskList" begin="0" end="${totalSize-1}">

                <tr>
                    <td>
                        <input type="button" class="btn btn-danger" style="width:60px;height:25px;font-size:12px"
                               value="刪除"
                               onclick="delete_RollbackIndex(${indexRollbackTaskList.id})">
                    </td>
                    <td>${indexRollbackTaskList.indexName}</td>
                    <td>${indexRollbackTaskList.actionFlag}</td>
                    <td>${indexRollbackTaskList.status}</td>
                    <td>${indexRollbackTaskList.weight}</td>
                    <td>${indexRollbackTaskList.createTime}</td>
                    <td>${indexRollbackTaskList.updateTime}</td>
                </tr>

            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:when test="${type=='insert'}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th>IndexName</th>
            <th>Weight</th>
            <tr>

                <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="索引庫名稱"
                           id="rollbackInsert_indexNameField"></td>
                <td><input type="text" style="width:140px;height:30px" class="textInput" value="2"
                           id="rollbackInsert_weightField"></td>

            </tr>
            <tr>
                <td colspan="2">
                    <input type="button" class="btn btn-info" style="width:60px;height:25px;font-size:12px" value="新增"
                           id="rollbackInsert">
                </td>
            </tr>
            </tbody>

        </table>
    </c:when>
    <c:when test="${type=='deleteSuccess'}">
        <strong>刪除成功任務成功</strong>
    </c:when>
    <c:when test="${type=='SourceTimeRange'}">
        <strong>新增來源回溯任務成功</strong>
    </c:when>
    <c:otherwise>
        <strong>找不到符合的資料</strong>
    </c:otherwise>
</c:choose>
</body>
</html>