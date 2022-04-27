<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.TaskLogDAO" %>
<%@ page import="com.eland.pojo.model.TaskLogEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/3
  Time: 下午 12:09
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
    TaskLogDAO taskLogDAO = new TaskLogDAO();
    //未完成任務或失敗任務搜尋
    if (type.equals("failTaskLog")) {
        List<TaskLogEntity> taskLogList = new LinkedList<TaskLogEntity>();
        int topNum = Integer.parseInt(reqWrapper.getParameter("topNum"));
        try {
            taskLogList = taskLogDAO.selectFailTaskLog(topNum);
            totalSize = taskLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskLogList", taskLogList);
        request.setAttribute("totalSize", totalSize);

        //自訂搜尋條件
    } else if (type.equals("definedCondition")) {
        List<TaskLogEntity> taskLogList = new LinkedList<TaskLogEntity>();
        try {
            String condition = new String(request.getParameter("condition").getBytes("ISO8859-1"), "UTF-8");

            taskLogList = taskLogDAO.selectByUserDefined(condition);
            totalSize = taskLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskLogList", taskLogList);
        request.setAttribute("totalSize", totalSize);
        //依索引名稱搜尋條件
    } else if (type.equals("indexName")) {
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        String startTime = reqWrapper.getParameter("startTime");
        String endTime = reqWrapper.getParameter("endTime");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");

        List<TaskLogEntity> taskLogList = new LinkedList<TaskLogEntity>();

        try {
            taskLogList = taskLogDAO.selectByIndexName(indexName, startTime, endTime, sortField, sortType);
            totalSize = taskLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskLogList", taskLogList);
        request.setAttribute("totalSize", totalSize);
        //依目標機器名稱搜尋條件
    } else if (type.equals("targetPath")) {
        String targetPath = reqWrapper.getParameter("targetPath");
        String startTime = reqWrapper.getParameter("startTime");
        String endTime = reqWrapper.getParameter("endTime");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");
        String machineIP = targetPath.replace("swd-searcher", "172.16.30.");
        List<TaskLogEntity> taskLogList = new LinkedList<TaskLogEntity>();

        try {

            taskLogList = taskLogDAO.selectByTargetPath(targetPath, machineIP, startTime, endTime, sortField, sortType);
            totalSize = taskLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskLogList", taskLogList);
        request.setAttribute("totalSize", totalSize);
        //cloner機器名稱搜尋條件
    } else if (type.equals("actionFlag")) {
        String actionFlag = reqWrapper.getParameter("actionFlag");
        String startTime = reqWrapper.getParameter("startTime");
        String endTime = reqWrapper.getParameter("endTime");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");
        List<TaskLogEntity> taskLogList = new LinkedList<TaskLogEntity>();
        try {
            taskLogList = taskLogDAO.selectByActionFlag(actionFlag, startTime, endTime, sortField, sortType);
            totalSize = taskLogList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("taskLogList", taskLogList);
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
                <th style="padding:2px;" width="230">索引名稱<br>(index_name)</th>
                <th style="padding:2px;" width="230">複製目標路徑<br>(target_path)</th>
                <th style="padding:2px;" width="120">執行複製機器<br>(action_flag)</th>
                <th style="padding:2px;" width="90">複製狀態<br>(status)</th>
                <th style="padding:2px;" width="120">任務開始時間<br>(task_start_time)</th>
                <th style="padding:2px;" width="120">任務結束時間<br>(task_end_time)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${taskLogList}" var="taskLogList" begin="0" end="${totalSize-1}">
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${taskLogList.indexName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${taskLogList.targetPath}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${taskLogList.actionFlag}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${taskLogList.status}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${taskLogList.taskStartTime}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${taskLogList.taskEndTime}</td>
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

