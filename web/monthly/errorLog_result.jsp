<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.MonthyCheckErrorLogDAO" %>
<%@ page import="com.eland.pojo.model.MonthyCheckErrorLogEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.Calendar" %><%--
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

    if (type.equals("dateTime")) {
        String startTime = reqWrapper.getParameter("startTime");
        String endTime = reqWrapper.getParameter("endTime");

        int totalSize = 0;      //資料總筆數
        MonthyCheckErrorLogDAO monthyCheckErrorLogDAO = new MonthyCheckErrorLogDAO();
        List<MonthyCheckErrorLogEntity> MonthyCheckErrorLogList = new LinkedList<MonthyCheckErrorLogEntity>();

        try {
            MonthyCheckErrorLogList = monthyCheckErrorLogDAO.selectMonthyCheckErrorLog(startTime, endTime);
            totalSize = MonthyCheckErrorLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }

        request.setAttribute("monthyCheckErrorLogList", MonthyCheckErrorLogList);
        request.setAttribute("totalSize", totalSize);
    }

    /*SimpleDateFormat startTimeDateFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
    SimpleDateFormat endTimeDateFormat = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
    Calendar fast = Calendar.getInstance();
    Calendar end = Calendar.getInstance();
    fast.add(Calendar.MONTH, 0);
    fast.set(Calendar.DAY_OF_MONTH,1);
    end.set(Calendar.DAY_OF_MONTH, end.getActualMaximum(Calendar.DAY_OF_MONTH));
    String startTime = startTimeDateFormat.format(fast.getTime());
    String endTime = endTimeDateFormat.format(end.getTime());*/

%>
<body>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="sortable">
            <thead>
            <tr>

                <th style="padding:2px;" width="270">(Index Name)</th>
                <th style="padding:2px;" width="130">(Machine Name)</th>
                <th style="padding:2px;" width="400">(Error Type)</th>
                <th style="padding:2px;" width="230">(Error Time)</th>

            </tr>
            </thead>
            <tbody>

            <c:forEach items="${monthyCheckErrorLogList}" var="monthyCheckErrorLogList" begin="0" end="${totalSize-1}">
                <tr>

                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyCheckErrorLogList.indexName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyCheckErrorLogList.machineName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyCheckErrorLogList.errorType}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${monthyCheckErrorLogList.errorTime}</td>

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
