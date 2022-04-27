<%@ page import="com.eland.pojo.model.WhSourceTypeEntity" %>
<%@ page import="com.eland.dao.NewSourceDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.util.RequestWrapper" %>
<%--
  Created by IntelliJ IDEA.
  User: zhenfuliao
  Date: 2020/5/14
  Time: 下午 05:57
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
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String type = reqWrapper.getParameter("type");

    int totalSize = 0;      //資料總筆數
    NewSourceDAO newSourceDAO = new NewSourceDAO();
    List<WhSourceTypeEntity> newSourceList = new LinkedList<WhSourceTypeEntity>();
    try {
        String newSource = new String(request.getParameter("newSource").getBytes("ISO8859-1"), "UTF-8");
        newSource = "source_id = '" + newSource + "'";
        //  System.out.println("newSource:"+newSource);
        newSourceList = newSourceDAO.selectNewSource(newSource);
        totalSize = newSourceList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }
    request.setAttribute("newSourceList", newSourceList);
    request.setAttribute("totalSize", totalSize);
    request.setAttribute("type", type);
%>
<body>
<%--<div style="font-size: 3px">--%>

<c:choose>
    <c:when test="${type=='select'&&totalSize > 0}">

        <table class="sortable">
            <thead>
            <tr>
                <th style="padding:2px;" width="90">新來源ID<br>(source_id)</th>
                <th style="padding:2px;" width="90">新來源名稱<br>(source_name)</th>
                <th style="padding:2px;" width="90">P_Type<br>(p_type)</th>
                <th style="padding:2px;" width="90">P_Type_2<br>(p_type_2)</th>


            </tr>
            </thead>
            <tbody>
            <c:forEach items="${newSourceList}" var="newSourceList" begin="0" end="${totalSize-1}">
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${newSourceList.sourceId}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${newSourceList.sourceName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${newSourceList.pType}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${newSourceList.pType2}</td>
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
