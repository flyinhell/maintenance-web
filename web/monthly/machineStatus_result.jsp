<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.pojo.model.MonthyTaskMachineCheckEntity" %>
<%@ page import="com.eland.dao.MonthyTaskMachineCheckDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %><%--
  Created by IntelliJ IDEA.
  User: kueihenglu
  Date: 2018/8/23
  Time: 下午 03:01
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
    MonthyTaskMachineCheckDAO monthyTaskMachineCheckDAO = new MonthyTaskMachineCheckDAO();
    List<MonthyTaskMachineCheckEntity> monthyTaskMachineCheckList = new LinkedList<MonthyTaskMachineCheckEntity>();

    try {
        monthyTaskMachineCheckList = monthyTaskMachineCheckDAO.selectMonthyTaskMachineCheck();
        totalSize = monthyTaskMachineCheckList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }
    request.setAttribute("monthyTaskMachineCheckList", monthyTaskMachineCheckList);
    request.setAttribute("totalSize", totalSize);
%>
<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="sortable">
            <thead>
            <tr>
                <th style="padding:2px;" width="230">(Machine Name)</th>
                <th style="padding:2px;" width="150">(P2P Status)</th>
                <th style="padding:2px;" width="180">(TSPSDK Status)</th>
                <th style="padding:2px;" width="220">(Update Time)</th>
                <th style="padding:2px;" width="180">(Month)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${monthyTaskMachineCheckList}" var="monthyTaskMachineCheckList" begin="0"
                       end="${totalSize-1}">
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskMachineCheckList.machineName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskMachineCheckList.p2pStatus}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskMachineCheckList.tspsdkStatus}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskMachineCheckList.updateTime}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyTaskMachineCheckList.month}</td>
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
