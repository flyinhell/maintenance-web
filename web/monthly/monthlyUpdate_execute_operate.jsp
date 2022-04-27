<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.CustomIndexDAO" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.dao.MonthyTaskCheckDAO" %>
<%@ page import="com.eland.pojo.model.MonthyTaskConfigEntity" %>
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


//    int totalSize = 0;      //資料總筆數
    MonthyIndexConfigDAO monthyIndexConfigDAO = new MonthyIndexConfigDAO();
    MonthyTaskCheckDAO monthyTaskCheckDAO = new MonthyTaskCheckDAO();

    if (type.equals("delete")) {
        try {
            String id = reqWrapper.getParameter("id");

            List<MonthyTaskConfigEntity> monthyTaskConfigEntityList = monthyIndexConfigDAO.selectMonthyTaskConfigById(
                    id);
            String indexName = "";
            for (MonthyTaskConfigEntity monthyTaskConfigEntity : monthyTaskConfigEntityList) {
                indexName = monthyTaskConfigEntity.getIndexName();
                boolean delete = monthyIndexConfigDAO.deleteMonthyTaskConfig(monthyTaskConfigEntity);
                if (delete) {
                    monthyTaskCheckDAO.deleteMonthyTaskConfig(indexName);
                }
            }


        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    } else if (type.equals("updateTaskConfigMachine")) {
        try {
            String id = reqWrapper.getParameter("id");
            String indexType = reqWrapper.getParameter("indexType");
            String machineNameList = new String(request.getParameter("machineNameList").getBytes("ISO8859-1"), "UTF-8");
            String priority = new String(request.getParameter("priority").getBytes("ISO8859-1"), "UTF-8");

            boolean update = monthyIndexConfigDAO.updateIndexConfigMachine(id, indexType, machineNameList, priority);
            logger.info("Update indexType:" + indexType + " machineNameList:" + machineNameList + " priority:" + priority);
            logger.info("Update:" + update);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    } else if (type.equals("updateTaskConfigMapping")) {
        try {

            String id = reqWrapper.getParameter("id");
            String module = reqWrapper.getParameter("module");
            String customer = new String(request.getParameter("customer").getBytes("ISO8859-1"), "UTF-8");
            String sourceType = reqWrapper.getParameter("sourceType");
            String contentType = reqWrapper.getParameter("contentType");
            boolean update = monthyIndexConfigDAO.updateIndexConfigMapping(id, module, customer, sourceType, contentType);
            logger.info("Update module:" + module + " customer:" + customer + " sourceType:" + sourceType + " contentType:" + contentType);
            logger.info("Update:" + update);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    } else if (type.equals("updateTaskConfigDatabase")) {
        try {
            String id = reqWrapper.getParameter("id");
            String viewName = reqWrapper.getParameter("viewName");
            String databaseType = reqWrapper.getParameter("databaseType");
            String databaseAddress = new String(request.getParameter("databaseAddress").getBytes("ISO8859-1"), "UTF-8");
            boolean update = monthyIndexConfigDAO.updateIndexConfigDatabase(id, viewName, databaseType, databaseAddress);
            logger.info("Update viewName:" + viewName + " databaseType:" + databaseType + " databaseAddress:" + databaseAddress);
            logger.info("Update:" + update);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    } else if (type.equals("updateTaskConfigView")) {
        try {
            String id = reqWrapper.getParameter("id");
            String viewSchema = new String(request.getParameter("viewSchema").getBytes("ISO8859-1"), "UTF-8");
            System.out.println(viewSchema);

            boolean update = monthyIndexConfigDAO.updateIndexConfigSchema(id, viewSchema);
            logger.info("Update viewSchema:" + viewSchema);
            logger.info("Update:" + update);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    }

%>
<body>

</body>
</html>
