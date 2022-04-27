<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eland.dao.IndexTaskInformationDAO" %>
<%@ page import="com.eland.pojo.model.IndexTaskInformationEntity" %>
<%@ page import="java.sql.SQLOutput" %>
<%@ page import="com.eland.cloner.CallTaskQueueTools" %><%--
  Created by IntelliJ IDEA.
  User: johnnyhuang
  Date: 2018/3/19
  Time: 下午 02:54
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
    IndexTaskInformationDAO indexTaskInformationDAO = new IndexTaskInformationDAO();
    CallTaskQueueTools callTaskQueueTools = new CallTaskQueueTools();
    if (type.equals("insertIndexName")) { //依新增索引任務搜尋條件
        String indexName = new String(request.getParameter("insertIndexName").getBytes("ISO8859-1"), "UTF-8");
        String indexType = reqWrapper.getParameter("insertIndexType");
        String indexStatus = reqWrapper.getParameter("insertIndexStatus");
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        try {
            indexTaskInformationList = indexTaskInformationDAO.insertByIndexName(indexName, indexType, indexStatus);
            totalSize = indexTaskInformationList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexTaskInformationList", indexTaskInformationList);
        request.setAttribute("totalSize", totalSize);

    } else if (type.equals("deleteIndexName")) {  //依刪除索引任務搜尋條件
        String indexName = new String(request.getParameter("deleteIndexName").getBytes("ISO8859-1"), "UTF-8");
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        try {
            indexTaskInformationList = indexTaskInformationDAO.deleteByIndexName(indexName);
            totalSize = indexTaskInformationList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexTaskInformationList", indexTaskInformationList);
        request.setAttribute("totalSize", totalSize);

    } else if (type.equals("updateIndexName")) {  //依更新索引任務搜尋條件
        String indexName = new String(request.getParameter("updateIndexName").getBytes("ISO8859-1"), "UTF-8");
        String updateIndexStatus = reqWrapper.getParameter("updateIndexStatus");
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        try {
            indexTaskInformationList = indexTaskInformationDAO.updateByIndexName(indexName, updateIndexStatus);
            totalSize = indexTaskInformationList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexTaskInformationList", indexTaskInformationList);
        request.setAttribute("totalSize", totalSize);

    } else if (type.equals("definedCondition")) {    //自訂搜尋條件
        String condition = new String(request.getParameter("condition").getBytes("ISO8859-1"), "UTF-8");
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        try {
            indexTaskInformationList = indexTaskInformationDAO.selectByUserDefined(condition);
            totalSize = indexTaskInformationList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexTaskInformationList", indexTaskInformationList);
        request.setAttribute("totalSize", totalSize);

    } else if (type.equals("indexName")) {  //依索引名稱搜尋條件
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");
        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        try {
            indexTaskInformationList = indexTaskInformationDAO.selectByIndexName(indexName, sortField, sortType);
            totalSize = indexTaskInformationList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexTaskInformationList", indexTaskInformationList);
        request.setAttribute("totalSize", totalSize);

    } else if (type.equals("indexStatus")) {    //依索引狀態搜尋條件
        String indexStatus = reqWrapper.getParameter("indexStatus");
        // System.out.println("indexStatus:"+indexStatus);
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");

        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        try {
            indexTaskInformationList = indexTaskInformationDAO.selectByIndexStatus(indexStatus, sortField, sortType);
            totalSize = indexTaskInformationList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexTaskInformationList", indexTaskInformationList);
        request.setAttribute("totalSize", totalSize);

    } else if (type.equals("indexTimeRange")) { //依時間範圍搜尋條件
        String startTime = reqWrapper.getParameter("startTime");
        String endTime = reqWrapper.getParameter("endTime");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");

        List<IndexTaskInformationEntity> indexTaskInformationList = new LinkedList<IndexTaskInformationEntity>();
        try {
            indexTaskInformationList = indexTaskInformationDAO.selectByIndexTimeRange(startTime, endTime, sortField, sortType);
            totalSize = indexTaskInformationList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexTaskInformationList", indexTaskInformationList);
        request.setAttribute("totalSize", totalSize);
    } else if (type.equals("restartTaskQueue")) { //重啟Task_Queue
        String indexer = reqWrapper.getParameter("indexer");
        //  System.out.println(indexer);
        callTaskQueueTools.callTaskQueueRestartTools(indexer);
    } else if (type.equals("stopTaskQueue")){ //關閉Task_Queue
        String indexer = reqWrapper.getParameter("indexer");
        callTaskQueueTools.callTaskQueueStopTools(indexer);
    }
%>
<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="sortable">
            <thead>
            <tr>
                <th style="padding:2px;" width="200">索引名稱<br>(index_name)</th>
                <th style="padding:2px;" width="130">索引類型<br>(index_type)</th>
                <th style="padding:2px;" width="120">建立機器<br>(action_flag)</th>
                <th style="padding:2px;" width="90">建立狀態<br>(status)</th>
                <th style="padding:2px;" width="90">上次建立時間<br>(last_build_time)</th>
                <th style="padding:2px;" width="90">資料筆數<br>(records)</th>
                <th style="padding:2px;" width="90">更新時間<br>(update_time)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${indexTaskInformationList}" var="indexTaskInformationList" begin="0"
                       end="${totalSize-1}">
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexTaskInformationList.indexName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexTaskInformationList.indexType}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexTaskInformationList.actionFlag}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexTaskInformationList.status}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexTaskInformationList.lastBuildTime}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexTaskInformationList.records}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexTaskInformationList.updateTime}</td>
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
