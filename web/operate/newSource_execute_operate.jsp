<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.RollbackTaskDAO" %>
<%@ page import="com.eland.dao.NewSourceDAO" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%--
  Created by IntelliJ IDEA.
  User: zhenfuliao
  Date: 2020/5/15
  Time: 上午 10:27
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
    String insertSQL = "";

//    int totalSize = 0;      //資料總筆數
    NewSourceDAO newSourceDAO = new NewSourceDAO();
//    //未完成任務或失敗任務搜尋
    if (type.equals("insert")) {
        String[] multipleSourceId = request.getParameter("sourceId").split(",");
        String[] multipleSourceName = request.getParameter("sourceName").split(",");
        String[] multiplePtype = request.getParameter("ptype").split(",");
        String[] multiplePtype2 = request.getParameter("ptype2").split(",");

        for(int i = 0; i < multipleSourceId.length ; i ++){
            multipleSourceId[i] = new String(multipleSourceId[i].getBytes("ISO8859-1"), "UTF-8");
            multiplePtype[i] = new String(multiplePtype[i].getBytes("ISO8859-1"), "UTF-8");
            multiplePtype2[i] = new String(multiplePtype2[i].getBytes("ISO8859-1"), "UTF-8");
        }
        try {
            for(int i = 0; i < multipleSourceId.length; i++){
                boolean insert = newSourceDAO.insertNewSource(multipleSourceId[i], multipleSourceName[i], multiplePtype[i], multiplePtype2[i]);
            // logger.info("Insert Rollback Task Index:"+indexName+" Weight:"+weight);
//            request.setAttribute("sql",insert);
                logger.info("Insert:" + insert);
            }
            insertSQL = newSourceDAO.getInsertSQL(multipleSourceId,multipleSourceName, multiplePtype, multiplePtype2);
        } catch (Exception e) {
            logger.error("新增發生錯誤：", e);
        }
    } else if (type.equals("delete")) {
        try {
            String id = reqWrapper.getParameter("id");
            boolean delete = newSourceDAO.deleteNewSource(id);
            logger.info("delete RNewSource ID:" + id);
            logger.info("delete:" + delete);
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
    }

%>
<body>
<strong><%response.getWriter().write(insertSQL);%></strong>
</body>
</html>
