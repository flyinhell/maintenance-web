<%@ page import="com.eland.dao.CustomIndexDAO" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
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
    CustomIndexDAO customIndexDAO = new CustomIndexDAO();
    List<CustomIndexInformationEntity> customIndexList = new LinkedList<CustomIndexInformationEntity>();
    try {
        customIndexList = customIndexDAO.selectCustomIndexInformation();
        totalSize = customIndexList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }
    request.setAttribute("customIndexList", customIndexList);
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
                <th>分<br>(minute)</th>
                <th>時<br>(hour)</th>
                <th>天<br>(day)</th>
                <th>逾時秒數<br>(timeout_second)</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${customIndexList}" var="customIndexList" begin="0" end="${totalSize-1}">
                <tr>
                    <td>${customIndexList.indexName}</td>
                    <td>${customIndexList.minute}</td>
                    <td>${customIndexList.hour}</td>
                    <td>${customIndexList.day}</td>
                    <td>${customIndexList.timeoutSecond}</td>
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