<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.CustomIndexDAO" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
<%@ page import="com.eland.dao.MonthyTaskMachineCheckDAO" %>
<%@ page import="com.eland.pojo.model.MachineTypeMappingEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/12
  Time: 上午 11:07
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
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String type = reqWrapper.getParameter("type");

    MachineTypeMappingDAO machineTypeMappingDAO = new MachineTypeMappingDAO();
    MonthyTaskMachineCheckDAO monthyTaskMachineCheckDAO = new MonthyTaskMachineCheckDAO();

    if (type.equals("delete")) {
        String machineName;
        try {

            String id = reqWrapper.getParameter("id");
            List<MachineTypeMappingEntity> list = machineTypeMappingDAO.selectMachineTypeMappingById(id);
            for (MachineTypeMappingEntity machineTypeMappingEntity : list) {
                machineName = machineTypeMappingEntity.getMachineName();
                boolean delete = machineTypeMappingDAO.deleteMachineTypeMapping(machineTypeMappingEntity);
                if (delete) {
                    monthyTaskMachineCheckDAO.deleteMonthyTaskMachineCheck(machineName);
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    } else if (type.equals("insert")) {
        try {
            String machineName = new String(request.getParameter("machineName").getBytes("ISO8859-1"), "UTF-8");
            String machineType = reqWrapper.getParameter("machineType");
            String ipAddress = reqWrapper.getParameter("ipAddress");

            boolean insert = machineTypeMappingDAO.insertIndexConfig(machineName, machineType, ipAddress);
            if (insert) {
                monthyTaskMachineCheckDAO.insertMonthyTaskMachineCheck(machineName);
            }

            logger.info(
                    "Update machineName:" + machineName + " machineType:" + machineType + " ipAddress:" + ipAddress);
            logger.info("insert:" + insert);
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }

%>
<body>

</body>
</html>
