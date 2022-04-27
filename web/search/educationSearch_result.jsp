<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.MachineServiceStatusDAO" %>
<%@ page import="com.eland.pojo.model.MachineServiceStatusEntity" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: kueihenglu
  Date: 2018/4/2
  Time: 下午 06:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
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
    String machineName = reqWrapper.getParameter("machineName");
    String ipAddress = reqWrapper.getParameter("ipAddress");
    String machineType = reqWrapper.getParameter("type");
    String site = reqWrapper.getParameter("site");
    String status = reqWrapper.getParameter("status");
    String sortField = reqWrapper.getParameter("sortField");
    String sortType = reqWrapper.getParameter("sortType");

    int totalSize = 0;      //資料總筆數

    MachineServiceStatusDAO machineServiceStatusDAO = new MachineServiceStatusDAO();
    List<MachineServiceStatusEntity> machineServiceStatusList = new LinkedList<MachineServiceStatusEntity>();
    try {
        machineServiceStatusList = machineServiceStatusDAO.getMachineServiceStatusList(machineName, ipAddress, machineType,
                site, status, sortField, sortType);
        totalSize = machineServiceStatusList.size();
    } catch (Exception e) {
        logger.error("搜尋歷史紀錄 發生錯誤：", e);
    }

    request.setAttribute("machineServiceStatusList", machineServiceStatusList);
    request.setAttribute("totalSize", totalSize);

%>
<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="table table-hover">
            <thead>
            <tr>
                <th width="230">機器名稱(machine_name)</th>
                <th width="100">IP位址(ip_address)</th>
                <th width="90">服務類型(machine_type)</th>
                <th width="90">系統狀態(status)</th>
                <th width="180">開始時間(start_time)</th>
                <th width="180">更新時間(update_time)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${machineServiceStatusList}" var="machineServiceStatusEntity" begin="0"
                       end="${totalSize-1}">
                <tr>
                    <td>${machineServiceStatusEntity.machineName}</td>
                    <td>${machineServiceStatusEntity.ipAddress}</td>
                    <td>${machineServiceStatusEntity.machineType}</td>
                    <td>${machineServiceStatusEntity.status}</td>
                    <td>${machineServiceStatusEntity.startTime}</td>
                    <td>${machineServiceStatusEntity.updateTime}</td>
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
