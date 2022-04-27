<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.RollbackTaskDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/13
  Time: 上午 10:29
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
    RollbackTaskDAO rollbackTaskDAO = new RollbackTaskDAO();
//    //未完成任務或失敗任務搜尋
    if (type.equals("insert")) {
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        int weight = Integer.parseInt(reqWrapper.getParameter("weight"));
        try {
            rollbackTaskDAO.insertIndexRollbackTask(indexName, weight);
            logger.info("Insert Rollback Task Index:" + indexName + " Weight:" + weight);
        } catch (Exception e) {
            logger.error("新增發生錯誤：", e);
        }

    } else if (type.equals("delete")) {

        try {
            String id = reqWrapper.getParameter("id");
            boolean delete = rollbackTaskDAO.deleteCustomIndexInformation(id);
            logger.info("delete RollbackTask ID:" + id);
            logger.info("delete:" + delete);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    }

%>
<body>

</body>
</html>
