<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.pojo.model.MonthyTaskConfigEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/10
  Time: 上午 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title></title>
</head>
<%

    int totalSize = 0;      //資料總筆數
    MonthyIndexConfigDAO monthyIndexConfigDAO = new MonthyIndexConfigDAO();
    List<MonthyTaskConfigEntity> MonthyTaskConfigEntityList = new LinkedList<MonthyTaskConfigEntity>();

    try {
        MonthyTaskConfigEntityList = monthyIndexConfigDAO.selectMonthyTaskConfig();
        totalSize = MonthyTaskConfigEntityList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }
    request.setAttribute("monthyTaskConfigEntityList", MonthyTaskConfigEntityList);
    request.setAttribute("totalSize", totalSize);
%>
<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>索引名稱<br>(index_name)</th>
                <th>資料庫位置<br>(database_address)</th>
                <th>機器列表<br>(machine_name_list)</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${monthyTaskConfigEntityList}" var="monthyTaskConfigEntityList" begin="0"
                       end="${totalSize-1}">
                <tr>
                    <td>${monthyTaskConfigEntityList.indexName}</td>
                    <td>${monthyTaskConfigEntityList.databaseAddress}</td>
                    <td>${monthyTaskConfigEntityList.machineNameList}</td>
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