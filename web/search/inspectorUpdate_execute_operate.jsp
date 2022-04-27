<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.pojo.model.MonthyTaskConfigEntity" %>
<%@ page import="com.eland.pojo.model.IndexInspectorConfigEntity" %>
<%@ page import="com.eland.dao.*" %>
<%@ page import="com.eland.backend.CallSearchInspectorBat" %>
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

    IndexInspectorConfigDAO indexInspectorConfigDAO = new IndexInspectorConfigDAO();
    IndexInformationDAO indexInformationDAO = new IndexInformationDAO();


    if (type.equals("delete")) {
        try {
            String id = reqWrapper.getParameter("id");
            List<IndexInspectorConfigEntity> indexInspectorConfigEntityList = indexInspectorConfigDAO
                    .selectIndexInspectorConfigById(
                            id);
            String indexName = "";
            for (IndexInspectorConfigEntity indexInspectorConfigEntity : indexInspectorConfigEntityList) {
                indexName = indexInspectorConfigEntity.getIndexName();
                boolean delete = indexInspectorConfigDAO.deleteIndexInspectorConfig(indexInspectorConfigEntity);
                if (delete) {
                    indexInformationDAO.deleteIndexInformation(indexName);
                }
            }

        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    } else if (type.equals("updateIndexInspectorConfig")) {
        try {
            String id = reqWrapper.getParameter("id");
            String indexType = reqWrapper.getParameter("indexType");
            String immediate = new String(request.getParameter("immediate").getBytes("ISO8859-1"), "UTF-8");
            String inspectSwitch = new String(request.getParameter("inspectSwitch").getBytes("ISO8859-1"), "UTF-8");

            boolean update = indexInspectorConfigDAO
                    .updateIndexInspectorConfig(id, indexType, immediate, inspectSwitch);
            logger.info("Update indexType:" + indexType + " immediate:" + immediate + " priority:" + inspectSwitch);
            logger.info("Update:" + update);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    } else if (type.equals("updateIndexInformation")) {
        try {
            String id = reqWrapper.getParameter("id");
            String indexType = new String(request.getParameter("indexType").getBytes("ISO8859-1"), "UTF-8");
            String dateRange = new String(request.getParameter("dateRange").getBytes("ISO8859-1"), "UTF-8");
            String pType2 = new String(request.getParameter("pType2").getBytes("ISO8859-1"), "UTF-8");

            boolean update = indexInformationDAO.updateIndexInformation(id, indexType, dateRange, pType2);
            logger.info("Update indexType:" + indexType + " dateRange:" + dateRange + " pType2:" + pType2);
            logger.info("Update:" + update);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    } else if (type.equals("updateIndexInformationDatabase")) {
        try {
            String id = reqWrapper.getParameter("id");
            String viewName = reqWrapper.getParameter("viewName");
            String databaseType = reqWrapper.getParameter("databaseType");
            String databaseAddress = new String(request.getParameter("databaseAddress").getBytes("ISO8859-1"), "UTF-8");
            boolean update = indexInformationDAO.updateIndexInformationDatabase(id, viewName, databaseType,
                    databaseAddress);
            logger.info("Update viewName:" + viewName + " databaseType:" + databaseType + " databaseAddress:" +
                    databaseAddress);
            logger.info("Update:" + update);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    } else if (type.equals("updateIndexInspectorConfigSql")) {
        try {
            String id = reqWrapper.getParameter("id");
            String checkImmediateSql = new String(request.getParameter("checkImmediateSql").getBytes("ISO8859-1"), "UTF-8");

            boolean update = indexInspectorConfigDAO.updateIndexInspectorConfig(id, checkImmediateSql);
            logger.info("Update checkImmediateSqlField:" + checkImmediateSql);
            logger.info("Update:" + update);
        } catch (Exception e) {

            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    } else if (type.equals("startInspectorBatch")) {
        System.out.println("startInspectorBatch");
        // InspectIndex inspectIndex = new InspectIndex();
        // inspectIndex.startInspector();
        CallSearchInspectorBat callSC = new CallSearchInspectorBat();
        callSC.dopost("SearchInspector");
        System.out.println("endInspectorBatch");

    }

%>
<body>

</body>
</html>
