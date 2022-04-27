<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.TaskDAO" %>
<%@ page import="com.eland.pojo.model.TaskEntity" %>
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
    TaskDAO taskDAO = new TaskDAO();
    //未完成任務或失敗任務搜尋
    if (type.equals("unfinishedTask")) {
        List<TaskEntity> taskList = new LinkedList<TaskEntity>();
        try {
            taskList = taskDAO.selectUnfinishedTask();
            totalSize = taskList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskList", taskList);
        request.setAttribute("totalSize", totalSize);
        //自訂搜尋條件
    } else if (type.equals("definedCondition")) {
        String condition = new String(request.getParameter("condition").getBytes("ISO8859-1"), "UTF-8");
//        String condition = reqWrapper.getParameter("condition");
        List<TaskEntity> taskList = new LinkedList<TaskEntity>();
        try {
            taskList = taskDAO.selectByUserDefined(condition);
            totalSize = taskList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskList", taskList);
        request.setAttribute("totalSize", totalSize);
        //依索引名稱搜尋條件
    } else if (type.equals("indexName")) {
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
//        String indexName = reqWrapper.getParameter("indexName");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");

        List<TaskEntity> taskList = new LinkedList<TaskEntity>();

        try {
            taskList = taskDAO.selectByIndexName(indexName, sortField, sortType);
            totalSize = taskList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskList", taskList);
        request.setAttribute("totalSize", totalSize);
        //依目標機器名稱搜尋條件
    } else if (type.equals("machineName")) {
        String machineName = reqWrapper.getParameter("machineName");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");

        List<TaskEntity> taskList = new LinkedList<TaskEntity>();

        try {
            taskList = taskDAO.selectByMachineName(machineName, sortField, sortType);
            totalSize = taskList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskList", taskList);
        request.setAttribute("totalSize", totalSize);
        //cloner機器名稱搜尋條件
    } else if (type.equals("actionFlag")) {
        String actionFlag = reqWrapper.getParameter("actionFlag");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");
        List<TaskEntity> taskList = new LinkedList<TaskEntity>();
        try {
            taskList = taskDAO.selectByActionFlag(actionFlag, sortField, sortType);
            totalSize = taskList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskList", taskList);
        request.setAttribute("totalSize", totalSize);
    }else if (type.equals("failedTask")){
        List<TaskEntity> taskList = new LinkedList<TaskEntity>();
        try {
            taskDAO.updateFailedTask();
            taskList = taskDAO.selectUnfinishedTask();
            totalSize = taskList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskList", taskList);
        request.setAttribute("totalSize", totalSize);
    }


%>
<%--<table class="table table-hover">--%>
<%--<tbody class="topicTableContent">--%>
<%--</tbody>--%>
<%--</table>--%>

<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="sortable">
            <thead>
            <tr>
                <th style="padding:2px;" width="120">機器名稱<br>(machine_name)</th>
                <th style="padding:2px;" width="260">索引名稱<br>(index_name)</th>
                <th style="padding:2px;" width="100">任務時間<br>(task_time)</th>
                <th style="padding:2px;" width="200">複製目標路徑<br>(target_path)</th>
                <th style="padding:2px;" width="120">執行複製機器<br>(action_flag)</th>
                <th style="padding:2px;" width="100">複製狀態<br>(status)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${taskList}" var="taskList" begin="0" end="${totalSize-1}">
                <%--<tr style="padding: 8px;text-align: left;border-bottom: 1px solid #ddd">--%>
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty taskList.machineName}">null</c:if>
                        <c:if test="${!empty taskList.machineName}">${taskList.machineName}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty taskList.indexName}">null</c:if>
                        <c:if test="${!empty taskList.indexName}">${taskList.indexName}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty taskList.taskTime}">null</c:if>
                        <c:if test="${!empty taskList.taskTime}">${taskList.taskTime}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty taskList.targetPath}">null</c:if>
                        <c:if test="${!empty taskList.targetPath}">${taskList.targetPath}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty taskList.actionFlag}">null</c:if>
                        <c:if test="${!empty taskList.actionFlag}">${taskList.actionFlag}</c:if>
                    </td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                        <c:if test="${empty taskList.status}">null</c:if>
                        <c:if test="${!empty taskList.status}">${taskList.status}</c:if>
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

<%--</div>--%>
</body>
