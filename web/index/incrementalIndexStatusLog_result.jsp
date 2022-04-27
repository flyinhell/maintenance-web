<%@ page import="com.eland.dao.IncrementalIndexStatusLogDAO" %>
<%@ page import="com.eland.pojo.model.IncrementalIndexStatusLogEntity" %>
<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
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
            /*background-color:#C9FFFF;*/
            color: #000000;
            /*font-size:12px;*/
            /*font-weight: bold;*/
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
    String indexName = reqWrapper.getParameter("indexName");
    String machineName = reqWrapper.getParameter("machineName");
    String status = reqWrapper.getParameter("status");
    String type = reqWrapper.getParameter("type");
    String sortField = reqWrapper.getParameter("sortField");
    String sortType = reqWrapper.getParameter("sortType");
    int record = reqWrapper.getInt("record");
    String temp = reqWrapper.getParameter("temp");
    String startTime = reqWrapper.getParameter("startTime");
    String endTime = reqWrapper.getParameter("endTime");
    int totalSize = 0;      //資料總筆數

    IncrementalIndexStatusLogDAO incrementalIndexStatusLogDAO = new IncrementalIndexStatusLogDAO();
    List<IncrementalIndexStatusLogEntity> incrementalStatusLogList = new LinkedList<IncrementalIndexStatusLogEntity>();
    try {
        incrementalStatusLogList = incrementalIndexStatusLogDAO
                .getIncrementalStatusLogList(indexName, machineName, status, type, sortField, sortType, record, temp, startTime, endTime);
        totalSize = incrementalStatusLogList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }

    request.setAttribute("incrementalStatusLogList", incrementalStatusLogList);
    request.setAttribute("totalSize", totalSize);

%>

<body>
<div style="font-size: 12px">
    <c:choose>
        <c:when test="${totalSize > 0}">
            <table class="sortable">
                <thead>
                <tr>
                    <th style="padding:2px;" width="90">索引名稱(index_name)</th>
                    <th style="padding:2px;" width="90">機器名稱(machine_name)</th>
                    <th style="padding:2px;" width="90">任務狀態(status)</th>
                    <th style="padding:2px;" width="90">開始時間(start_time)</th>
                    <th style="padding:2px;" width="90">結束時間(finish_time)</th>
                    <th style="padding:2px;" width="90">最新發文時間(last_content_create_time)</th>
                    <th style="padding:2px;" width="90">資料筆數(records)</th>
                    <th style="padding:2px;" width="90">任務類型(type)</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${incrementalStatusLogList}" var="incrementalIndexStatusLogEntity" begin="0"
                           end="${totalSize-1}">
                    <tr>
                        <td style="padding: 6px;border-bottom: 1px solid #ddd">${incrementalIndexStatusLogEntity.indexName}</td>
                        <td style="padding: 6px;border-bottom: 1px solid #ddd">${incrementalIndexStatusLogEntity.machineName}</td>
                        <td style="padding: 6px;border-bottom: 1px solid #ddd">${incrementalIndexStatusLogEntity.status}</td>
                        <td style="padding: 6px;border-bottom: 1px solid #ddd">${incrementalIndexStatusLogEntity.startTime}</td>
                        <td style="padding: 6px;border-bottom: 1px solid #ddd">${incrementalIndexStatusLogEntity.finishTime}</td>
                        <td style="padding: 6px;border-bottom: 1px solid #ddd">${incrementalIndexStatusLogEntity.lastContentCreateTime}</td>
                        <td style="padding: 6px;border-bottom: 1px solid #ddd">${incrementalIndexStatusLogEntity.records}</td>
                        <td style="padding: 6px;border-bottom: 1px solid #ddd">${incrementalIndexStatusLogEntity.type}</td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <strong>找不到符合的資料</strong>
        </c:otherwise>
    </c:choose>

</div>
</body>
