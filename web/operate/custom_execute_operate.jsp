<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.CustomIndexDAO" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
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
    CustomIndexDAO customIndexDAO = new CustomIndexDAO();
//    //未完成任務或失敗任務搜尋
    if (type.equals("insert")) {
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        String min = reqWrapper.getParameter("minute");
        String hour = reqWrapper.getParameter("hour");
        String day = reqWrapper.getParameter("day");
        int timeoutSecond = Integer.parseInt(reqWrapper.getParameter("timeoutSecond"));

        try {
            boolean insert = customIndexDAO.insertCustomIndexInformation(indexName, min, hour, day, timeoutSecond);
            logger.info("Insert Custom Index:" + indexName + " Min:" + min + " Hour:" + hour + " Day:" + day + " TimeoutSecond:" + timeoutSecond);
            logger.info("Insert:" + insert);

        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }

    } else if (type.equals("delete")) {

        try {
            String id = reqWrapper.getParameter("id");
            boolean delete = customIndexDAO.deleteCustomIndexInformation(id);
            logger.info("Delete Custom ID:" + id);
            logger.info("Delete:" + delete);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    } else if (type.equals("update")) {

        try {
            String id = reqWrapper.getParameter("id");
            String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
            String min = reqWrapper.getParameter("minute");
            String hour = reqWrapper.getParameter("hour");
            String day = reqWrapper.getParameter("day");
            int timeoutSecond = Integer.parseInt(reqWrapper.getParameter("timeoutSecond"));
            boolean update = customIndexDAO.updateCustomIndexInformation(id, indexName, min, hour, day, timeoutSecond);
            logger.info("Update Custom Index:" + indexName + " Min:" + min + " Hour:" + hour + " Day:" + day + " TimeoutSecond:" + timeoutSecond);
            logger.info("Update:" + update);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    }
%>
<body>

</body>
</html>
