<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.pojo.model.MonthyTaskConfigEntity" %>
<%@ page import="com.eland.pojo.model.MachineTypeMappingEntity" %>
<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/10
  Time: 上午 11:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title></title>
</head>
<%

    int totalSize = 0;      //資料總筆數
    MachineTypeMappingDAO machineTypeMappingDAO = new MachineTypeMappingDAO();
    List<MachineTypeMappingEntity> machineTypeMappingEntityList = new LinkedList<MachineTypeMappingEntity>();

    try {
        machineTypeMappingEntityList = machineTypeMappingDAO.selectMachineTypeMapping();
        totalSize = machineTypeMappingEntityList.size();
    } catch (Exception e) {
        logger.error(e.getMessage(), e);
    }
    request.setAttribute("machineTypeMappingEntityList", machineTypeMappingEntityList);
    request.setAttribute("totalSize", totalSize);
%>
<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>機器名稱<br>(machine_name)</th>
                <th>機器類型<br>(machine_type)</th>
                <th>機器IP位置<br>(ip_address)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${machineTypeMappingEntityList}" var="machineTypeMappingEntityList" begin="0"
                       end="${totalSize-1}">
                <tr>
                    <td>${machineTypeMappingEntityList.machineName}</td>
                    <td>${machineTypeMappingEntityList.machineType}</td>
                    <td>${machineTypeMappingEntityList.ipAddress}</td>
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