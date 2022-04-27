<%@ page import="com.eland.pojo.model.VwSwitchStatusEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.IndexPathDAO" %>
<%@ page import="com.eland.pojo.model.VwIndexSwitchStatusEntity" %>
<%@ page import="com.eland.dao.ViewClonerStatusDAO" %>
<%@ page import="com.eland.dao.SwitchStatusDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/3
  Time: 下午 12:06
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
    int totalSize = 0;      //資料總筆數
    IndexPathDAO indexPathDAO = new IndexPathDAO();
    //未完成任務或失敗任務搜尋
    List<VwSwitchStatusEntity> indexPathList = new LinkedList<VwSwitchStatusEntity>();
    try {
        indexPathList = indexPathDAO.selectIndexPath();
        totalSize = indexPathList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }
    request.setAttribute("indexPathList", indexPathList);
    request.setAttribute("totalSize", totalSize);


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
                <h2>今日切換狀況</h2>
            </tr>
            <tr>
                <th>同步索引路徑<br>(target_path)</th>
                <th>執行切換機器<br>(machine_name)</th>
                <th>切換時間<br>(task_time)</th>
                <th>更新時間<br>(update_time)</th>
                <th>上次切換日期<br>(lastSwitch_date)</th>
                <th>今日切換狀態<br>(switch_status)</th>

            </tr>
            </thead>
            <tbody>
            <c:forEach items="${indexPathList}" var="indexPathList" begin="0" end="${totalSize-1}">
                <tr>
                    <td>${indexPathList.targetPath}</td>
                    <td>${indexPathList.machineName}</td>
                    <td>${indexPathList.taskTime}</td>
                    <td>${indexPathList.updateTime}</td>
                    <td>${indexPathList.lastSwitchDate}</td>
                    <td>${indexPathList.switchStatus}</td>

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

<% //當尚未切換時，搜尋並顯示未達成切換準備的索引列表
    if (indexPathList.get(0).getSwitchStatus().equals("false")) {
        SwitchStatusDAO switchStatusDAO = new SwitchStatusDAO();
        List<VwIndexSwitchStatusEntity> indexSwitchList = new LinkedList<VwIndexSwitchStatusEntity>();
        try {
            indexSwitchList = switchStatusDAO.selectViewIndexSwitchStatus();
            totalSize = indexSwitchList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexSwitchList", indexSwitchList);
        request.setAttribute("totalSize", totalSize);

%>
<%--<div style="font-size: 12px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <BR>
        <tr>
            <h2>未達成切換條件索引</h2>
        </tr>
        <table class="sortable">
                <%--<table class="table table-hover">--%>
            <thead>

            <tr>
                <th style="padding:2px;" width="130">索引名稱<br>(IndexName)</th>
                <th style="padding:2px;" width="90">機器名稱<br>(MachineName)</th>
                <th style="padding:2px;" width="90">索引建立狀況<br>(IndexStatus)</th>
                <th style="padding:2px;" width="90">複製目標路徑<br>(TargetPath)</th>
                <th style="padding:2px;" width="100">執行複製機器<br>(ActionFlag)</th>
                <th style="padding:2px;" width="90">複製狀況<br>(Status)</th>
                <th style="padding:2px;" width="90">上次建立時間<br>(LastBuildTime)</th>
                <th style="padding:2px;" width="90">任務完成時間<br>(TaskTime)</th>
                    <%--<th>SwitchReady</th>--%>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${indexSwitchList}" var="indexSwitchList" begin="0" end="${totalSize-1}">
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${indexSwitchList.indexName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${indexSwitchList.machineName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">${indexSwitchList.indexStatus}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd"><c:if
                            test="${empty indexSwitchList.targetPath}">null</c:if>
                        <c:if test="${!empty indexSwitchList.targetPath}">${indexSwitchList.targetPath}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd"><c:if
                            test="${empty indexSwitchList.actionFlag}">null</c:if>
                        <c:if test="${!empty indexSwitchList.actionFlag}">${indexSwitchList.actionFlag}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd"><c:if
                            test="${empty indexSwitchList.status}">null</c:if>
                        <c:if test="${!empty indexSwitchList.status}">${indexSwitchList.status}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd"><c:if
                            test="${empty indexSwitchList.lastBuildTime}">null</c:if>
                        <c:if test="${!empty indexSwitchList.lastBuildTime}">${indexSwitchList.lastBuildTime}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd"><c:if
                            test="${empty indexSwitchList.taskTime}">null</c:if>
                        <c:if test="${!empty indexSwitchList.taskTime}">${indexSwitchList.taskTime}</c:if>
                    </td>
                        <%--<td>${indexSwitchList.switchReady}</td>--%>
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
<%

    }
%>


</body>
