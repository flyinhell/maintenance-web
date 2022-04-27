<%@ page import="com.eland.dao.BuildFailRecordsDAO" %>
<%@ page import="com.eland.pojo.model.BuildFailRecordsEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.util.RequestWrapper" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/9
  Time: 下午 06:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});
        });
    </script>
</head>

<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String type = reqWrapper.getParameter("type");

    int totalSize = 0;      //資料總筆數
    BuildFailRecordsDAO buildFailRecordsDAO = new BuildFailRecordsDAO();

    if (type.equals("select")) {
        List<BuildFailRecordsEntity> buildFailRecordsList = new LinkedList<BuildFailRecordsEntity>();
        try {
            buildFailRecordsList = buildFailRecordsDAO.selectBuildFailRecords();
            totalSize = buildFailRecordsList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("buildFailRecordsList", buildFailRecordsList);
        request.setAttribute("totalSize", totalSize);
    } else if (type.equals("clear")) {
        try {
            boolean result = buildFailRecordsDAO.clearBuildFailRecords();
            if (result) {
                totalSize = -1;
            }

        } catch (Exception e) {
            logger.error("清除歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("totalSize", totalSize);

    }
//


%>
<%--<table class="table table-hover">--%>
<%--<tbody class="topicTableContent">--%>
<%--</tbody>--%>
<%--</table>--%>
<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>Id</th>
                <th>IndexName</th>
                <th>ActionFlag</th>
                <th>CreateTime</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${buildFailRecordsList}" var="buildFailRecordsList" begin="0" end="${totalSize-1}">
                <tr>
                    <td>${buildFailRecordsList.id}</td>
                    <td>${buildFailRecordsList.indexName}</td>
                    <td>${buildFailRecordsList.actionFlag}</td>
                    <td>${buildFailRecordsList.createTime}</td>

                </tr>
            </c:forEach>

            </tbody>
        </table>
    </c:when>
    <c:when test="${totalSize == -1}">
        <strong>清除失敗紀錄</strong>
    </c:when>
    <c:otherwise>
        <strong>找不到符合的資料</strong>
    </c:otherwise>
</c:choose>

<%--</div>--%>
</body>


