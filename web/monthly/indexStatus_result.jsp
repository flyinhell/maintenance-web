<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.MonthyTaskCheckDAO" %>
<%@ page import="com.eland.pojo.model.MonthyTaskCheckEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%--
Created by IntelliJ IDEA.
  User: kueihenglu
  Date: 2018/8/23
  Time: 下午 03:00
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
            color: #000000;
            cursor: default;
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
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});
        });
    </script>
</head>
<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String type = reqWrapper.getParameter("type");

    int totalSize = 0;      //資料總筆數
    MonthyTaskCheckDAO monthyTaskCheckDAO = new MonthyTaskCheckDAO();
    List<MonthyTaskCheckEntity> monthyTaskCheckList = new LinkedList<MonthyTaskCheckEntity>();

    try {
        monthyTaskCheckList = monthyTaskCheckDAO.selectMonthyTaskCheck();
        totalSize = monthyTaskCheckList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }
    request.setAttribute("monthyTaskCheckList", monthyTaskCheckList);
    request.setAttribute("totalSize", totalSize);
%>

<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="sortable">
            <thead>
            <tr>
                <th style="padding:2px;" width="90">(Index Name)</th>
                <th style="padding:2px;" width="90">(Machine<br>Mapping)</th>
                <th style="padding:2px;" width="90">(Source<br>Mapping)</th>
                <th style="padding:2px;" width="90">(P2P<br>Status)</th>
                <th style="padding:2px;" width="90">(TempIndex<br>Status)</th>
                <th style="padding:2px;" width="90">(TSPSDK<br>Status)</th>
                <th style="padding:2px;" width="90">(View<br>Status)</th>
                <th style="padding:2px;" width="90">(Check<br>Time)</th>
                <th style="padding:2px;" width="90">(Month)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${monthyTaskCheckList}" var="monthyTaskCheckList" begin="0" end="${totalSize-1}">
                <tr>

                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskCheckList.indexName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskCheckList.machineMappingStatus}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskCheckList.sourceMappingStatus}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskCheckList.p2pStatus}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskCheckList.tempIndexStatus}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskCheckList.tspsdkStatus}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskCheckList.viewStatus}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskCheckList.checkTime}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskCheckList.month}</td>
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
