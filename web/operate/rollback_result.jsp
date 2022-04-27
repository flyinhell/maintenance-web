<%@ page import="com.eland.pojo.model.IndexRollbackTaskEntity" %>
<%@ page import="com.eland.dao.RollbackTaskDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/10
  Time: 上午 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <script src="../js/sorttable.js"></script>
    <style type="text/css">
        /* Sortable tables */
        table.sortable thead {
            /*background-color:#C9FFFF;*/
            color: #000000;
            /*font-size:12px;*/
            /*font-weight: bold;*/
            cursor: default;
        }
    </style>
    <title></title>
</head>
<%

    int totalSize = 0;      //資料總筆數
    RollbackTaskDAO rollbackTaskDAO = new RollbackTaskDAO();
    List<IndexRollbackTaskEntity> rollbackTaskList = new LinkedList<IndexRollbackTaskEntity>();
    try {
        rollbackTaskList = rollbackTaskDAO.selectIndexRollbackTask();
        totalSize = rollbackTaskList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }
    request.setAttribute("rollbackTaskList", rollbackTaskList);
    request.setAttribute("totalSize", totalSize);
%>
<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="sortable">
            <thead>
            <tr>
                <th style="padding:2px;" width="270">索引名稱<br>(index_name)</th>
                <th style="padding:2px;" width="180">執行建立機器<br>(action_flag)</th>
                <th style="padding:2px;" width="100">建立狀況<br>(status)</th>
                <th style="padding:2px;" width="100">權重<br>(weight)</th>
                <th style="padding:2px;" width="150">建立時間<br>(create_time)</th>
                <th style="padding:2px;" width="150">更新時間<br>(update_time)</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${rollbackTaskList}" var="rollbackTaskList" begin="0" end="${totalSize-1}">
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${rollbackTaskList.indexName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${rollbackTaskList.actionFlag}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${rollbackTaskList.status}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${rollbackTaskList.weight}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${rollbackTaskList.createTime}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${rollbackTaskList.updateTime}</td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <strong>找不到符合的資料</strong>
    </c:otherwise>
</c:choose>

<%--</div>--%>
</body>
</html>