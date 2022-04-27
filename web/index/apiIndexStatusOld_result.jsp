<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.ApiIndexStatusDAO" %>
<%@ page import="com.eland.pojo.model.ApiIndexStatusEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>

<%--
  Created by IntelliJ IDEA.
  User: johnnyhuang
  Date: 2018/3/7
  Time: 上午 09:29
  To change this template use File | Settings | File Templates.
--%>
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
    String type = reqWrapper.getParameter("type");
    int totalSize = 0;      //資料總筆數
    ApiIndexStatusDAO apiIndexStatusDAO = new ApiIndexStatusDAO();
    //未完成任務或失敗任務搜尋
    if (type.equals("unfinishedBuildIndexStatusOld")) {
        List<ApiIndexStatusEntity> indexStatusList = new LinkedList<ApiIndexStatusEntity>();
        try {

            indexStatusList = apiIndexStatusDAO.selectUnfinishedTask();
            indexStatusList.get(0).getSize();
            totalSize = indexStatusList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexStatusList", indexStatusList);
        request.setAttribute("totalSize", totalSize);
        //自訂搜尋條件
    } else if (type.equals("definedConditionOld")) {
        String condition = new String(request.getParameter("condition").getBytes("ISO8859-1"), "UTF-8");
        List<ApiIndexStatusEntity> indexStatusList = new LinkedList<ApiIndexStatusEntity>();
        try {
            indexStatusList = apiIndexStatusDAO.selectByUserDefined(condition);
            totalSize = indexStatusList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexStatusList", indexStatusList);
        request.setAttribute("totalSize", totalSize);
        //依索引名稱搜尋條件
    } else if (type.equals("indexNameOld")) {
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");

        List<ApiIndexStatusEntity> indexStatusList = new LinkedList<ApiIndexStatusEntity>();

        try {
            indexStatusList = apiIndexStatusDAO.selectByIndexName(indexName, sortField, sortType);
            totalSize = indexStatusList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexStatusList", indexStatusList);
        request.setAttribute("totalSize", totalSize);
    }
%>

<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="sortable">
            <thead>
            <tr>
                <th style="padding:2px;" width="210">索引名稱<br>(index_name)</th>
                <th style="padding:2px;" width="190">建立時間<br>(build_time)</th>
                <th style="padding:2px;" width="140">建立毫秒數<br>(build_millisecond)</th>
                <th style="padding:2px;" width="120">建立狀況<br>(status)</th>
                <th style="padding:2px;" width="120">檔案大小<br>(size)</th>
                <th style="padding:2px;" width="120">資料筆數<br>(records)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${indexStatusList}" var="indexStatusList" begin="0" end="${totalSize-1}">
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.indexName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.buildTime}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.buildMillisecond}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.status}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.size}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.records}</td>
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
