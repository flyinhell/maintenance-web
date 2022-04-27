<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.IndexInspectorStatusDAO" %>
<%@ page import="com.eland.pojo.model.IndexInspectorStatusEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.TestDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2019/1/3
  Time: 上午 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
    String indexName = "";
    try {
        if (reqWrapper.getParameter("indexName").equals("")) {
            indexName = "";
        } else {
            indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        }
    } catch (Exception e) {
        indexName = "";
    }
    String site = reqWrapper.getParameter("site");
    String status = reqWrapper.getParameter("status");
    String indexType = reqWrapper.getParameter("indexType");
    String sortField = reqWrapper.getParameter("sortField");
    String sortType = reqWrapper.getParameter("sortType");

    int totalSize = 0;      //資料總筆數


    List<IndexInspectorStatusEntity> indexInspectorStatusList = new LinkedList<IndexInspectorStatusEntity>();

    IndexInspectorStatusDAO indexInspectorStatusDAO = new IndexInspectorStatusDAO();

    try {
        indexInspectorStatusList = indexInspectorStatusDAO.selectList(indexName, site, status, indexType, sortField, sortType);

        totalSize = indexInspectorStatusList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }

    request.setAttribute("indexInspectorStatusList", indexInspectorStatusList);
    request.setAttribute("totalSize", totalSize);

%>

<body>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="sortable">
            <thead>
            <tr>
                <th style="padding:2px;" width="270">索引名稱<br>(index_name)</th>
                <th style="padding:2px;" width="100">服務類型<br>(site)</th>
                <th style="padding:2px;" width="130">最新發文時間<br>(last_post_time)</th>
                <th style="padding:2px;" width="130">最後檢查時間<br>(update_time)</th>
                <th style="padding:2px;" width="90">索引狀態<br>(status)</th>
                <th style="padding:2px;" width="90">錯誤類型<br>(issue_type)</th>
                <th style="padding:2px;" width="90">修復狀況<br>(repair_status)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${indexInspectorStatusList}" var="indexInspectorStatusList" begin="0"
                       end="${totalSize-1}">
                <%--<tr style="padding: 8px;text-align: left;border-bottom: 1px solid #ddd">--%>
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty indexInspectorStatusList.indexName}">null</c:if>
                        <c:if test="${!empty indexInspectorStatusList.indexName}">${indexInspectorStatusList.indexName}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty indexInspectorStatusList.site}">null</c:if>
                        <c:if test="${!empty indexInspectorStatusList.site}">${indexInspectorStatusList.site}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty indexInspectorStatusList.lastPostTime}">null</c:if>
                        <c:if test="${!empty indexInspectorStatusList.lastPostTime}">${indexInspectorStatusList.lastPostTime}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty indexInspectorStatusList.updateTime}">null</c:if>
                        <c:if test="${!empty indexInspectorStatusList.updateTime}">${indexInspectorStatusList.updateTime}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty indexInspectorStatusList.status}">null</c:if>
                        <c:if test="${!empty indexInspectorStatusList.status}">${indexInspectorStatusList.status}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty indexInspectorStatusList.issueType}">null</c:if>
                        <c:if test="${!empty indexInspectorStatusList.issueType}">${indexInspectorStatusList.issueType}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty indexInspectorStatusList.repairStatus}">null</c:if>
                        <c:if test="${!empty indexInspectorStatusList.repairStatus}">${indexInspectorStatusList.repairStatus}</c:if>
                    </td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <strong>找不到符合的資料</strong>
    </c:otherwise>
</c:choose>

</body>
</html>
