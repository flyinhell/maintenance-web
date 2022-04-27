<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.itextpdf.text.log.LoggerFactory" %>
<%@ page import="com.itextpdf.text.log.Logger" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.dao.MonthyTaskCheckDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/8/28
  Time: 下午 02:45
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
        String indexType = reqWrapper.getParameter("indexType");
        String machineNameList = new String(request.getParameter("machineNameList").getBytes("ISO8859-1"), "UTF-8");
        String priority = new String(request.getParameter("priority").getBytes("ISO8859-1"), "UTF-8");
        String module = reqWrapper.getParameter("module");
        String customer = new String(request.getParameter("customer").getBytes("ISO8859-1"), "UTF-8");
        String sourceType = reqWrapper.getParameter("sourceType");
        String contentType = reqWrapper.getParameter("contentType");
        String viewName = reqWrapper.getParameter("viewName");
        String databaseType = reqWrapper.getParameter("databaseType");
        String databaseAddress = new String(request.getParameter("databaseAddress").getBytes("ISO8859-1"), "UTF-8");
        String viewSchema = new String(request.getParameter("viewSchema").getBytes("ISO8859-1"), "UTF-8");

        MonthyIndexConfigDAO monthyIndexConfigDAO = new MonthyIndexConfigDAO();
        MonthyTaskCheckDAO monthyTaskCheckDAO = new MonthyTaskCheckDAO();
        try {
            //新增跨月索引設定表
            check = monthyIndexConfigDAO.insertIndexConfig(indexName, indexType, machineNameList, priority, module,
                    customer, sourceType, contentType, viewName, databaseType, databaseAddress, viewSchema);
            //新增跨月索引檢查表
            if (check) {
                monthyTaskCheckDAO.insertMonthyTaskCheck(indexName);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }

    %>

</head>
<body>

</body>
</html>
