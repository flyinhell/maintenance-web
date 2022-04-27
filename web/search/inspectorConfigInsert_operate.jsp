<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.itextpdf.text.log.LoggerFactory" %>
<%@ page import="com.itextpdf.text.log.Logger" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.dao.MonthyTaskCheckDAO" %>
<%@ page import="com.eland.pojo.model.IndexInformationEntity" %>
<%@ page import="com.eland.dao.IndexInformationDAO" %>
<%@ page import="com.eland.dao.IndexInspectorConfigDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2019/1/3
  Time: 下午 03:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <%

        Logger logger = LoggerFactory.getLogger("web");

        boolean check;
        RequestWrapper reqWrapper = new RequestWrapper(request);
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        String informationIndexType = reqWrapper.getParameter("informationIndexType");
        String configIndexType = reqWrapper.getParameter("configIndexType");
        String immediate = new String(request.getParameter("immediate").getBytes("ISO8859-1"), "UTF-8");
        String informationDateRange = new String(request.getParameter("informationDateRange").getBytes("ISO8859-1"), "UTF-8");
        String informationPType2 = new String(request.getParameter("informationPType2").getBytes("ISO8859-1"), "UTF-8");
        String standardSwitch = reqWrapper.getParameter("standardSwitch");
        String staffSwitch = reqWrapper.getParameter("staffSwitch");
        String advancedSwitch = reqWrapper.getParameter("advancedSwitch");
        String instantSwitch = reqWrapper.getParameter("instantSwitch");
        String viewName = reqWrapper.getParameter("viewName");
        String databaseType = reqWrapper.getParameter("databaseType");
        String databaseAddress = new String(request.getParameter("databaseAddress").getBytes("ISO8859-1"), "UTF-8");
        String checkImmediateSql = new String(request.getParameter("checkImmediateSql").getBytes("ISO8859-1"), "UTF-8");


        IndexInformationDAO indexInformationDAO = new IndexInformationDAO();

        IndexInspectorConfigDAO indexInspectorConfigDAO = new IndexInspectorConfigDAO();

        try {
            //新增index_information
            check = indexInformationDAO.insertIndexInformation(indexName, informationIndexType, informationDateRange,
                    databaseType, databaseAddress, viewName, informationPType2);

            //新增index_inspector_config
            if (check) {
                indexInspectorConfigDAO.insertIndexInspectorConfig(indexName, configIndexType, immediate, standardSwitch,
                        staffSwitch, advancedSwitch, instantSwitch, checkImmediateSql);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }

    %>
</head>
<body>

</body>
</html>
