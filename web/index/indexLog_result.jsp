<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.IndexLogDAO" %>
<%@ page import="com.eland.pojo.model.IndexLogEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %><%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/3
  Time: 下午 12:04
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
    IndexLogDAO indexLogDAO = new IndexLogDAO();
    //未完成任務或失敗任務搜尋
    if (type.equals("failIndexLog")) {
        List<IndexLogEntity> indexLogList = new LinkedList<IndexLogEntity>();
        int topNum = Integer.parseInt(reqWrapper.getParameter("topNum"));
        try {
            indexLogList = indexLogDAO.selectFailIndexLog(topNum);
            totalSize = indexLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexLogList", indexLogList);
        request.setAttribute("totalSize", totalSize);
        //自訂搜尋條件
    } else if (type.equals("definedCondition")) {
        String condition = new String(request.getParameter("condition").getBytes("ISO8859-1"), "UTF-8");
        List<IndexLogEntity> indexLogList = new LinkedList<IndexLogEntity>();
        try {
            indexLogList = indexLogDAO.selectByUserDefined(condition);
            totalSize = indexLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexLogList", indexLogList);
        request.setAttribute("totalSize", totalSize);
        //依索引名稱搜尋條件
    } else if (type.equals("indexName")) {
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        String startTime = reqWrapper.getParameter("startTime");
        String endField = reqWrapper.getParameter("endTime");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");


        List<IndexLogEntity> indexLogList = new LinkedList<IndexLogEntity>();

        try {
            indexLogList = indexLogDAO.selectByIndexName(indexName, startTime, endField, sortField, sortType);
            totalSize = indexLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexLogList", indexLogList);
        request.setAttribute("totalSize", totalSize);
        //依目標機器名稱搜尋條件
    } else if (type.equals("machineName")) {
        String indexName = reqWrapper.getParameter("machineName");
        String startTime = reqWrapper.getParameter("startTime");
        String endField = reqWrapper.getParameter("endTime");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");


        List<IndexLogEntity> indexLogList = new LinkedList<IndexLogEntity>();

        try {
            indexLogList = indexLogDAO.selectByMachineName(indexName, startTime, endField, sortField, sortType);
            totalSize = indexLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexLogList", indexLogList);
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
                <th style="padding:2px;" width="120">建立機器<br>(host)</th>
                <th style="padding:2px;" width="250">索引名稱<br>(indexdb)</th>
                <th style="padding:2px;" width="180">開始建立時間<br>(start_time)</th>
                <th style="padding:2px;" width="180">建立結束時間<br>(finish_time)</th>
                <th style="padding:2px;" width="90">建立狀況<br>(status)</th>
                <th style="padding:2px;" width="90">建立筆數<br>(indexdbRecnum)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${indexLogList}" var="indexLogList" begin="0" end="${totalSize-1}">
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexLogList.host}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexLogList.indexdb}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexLogList.startTime}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexLogList.finishTime}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexLogList.status}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexLogList.indexdbRecnum}</td>
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
