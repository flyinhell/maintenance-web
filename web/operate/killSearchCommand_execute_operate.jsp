<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.pojo.model.MonthyTaskConfigEntity" %>
<%@ page import="com.eland.pojo.model.IndexInspectorConfigEntity" %>
<%@ page import="com.eland.backend.CallSearchCommandBat" %>
<%--
  Created by IntelliJ IDEA.
  User: zhenfuliao
  Date: 2020/5/19
  Time: 下午 03:21
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


    if (type.equals("selectStandard")) {
        // System.out.println("type:"+type);
        CallSearchCommandBat callSC = new CallSearchCommandBat();
        callSC.dopost("selectStandard");
    } else if (type.equals("selectStaff")) {
        CallSearchCommandBat callSC = new CallSearchCommandBat();
        callSC.dopost("selectStaff");
    } else if (type.equals("selectAdvanced")) {
        CallSearchCommandBat callSC = new CallSearchCommandBat();
        callSC.dopost("selectAdvanced");
    } else if (type.equals("selectInstant")) {
        CallSearchCommandBat callSC = new CallSearchCommandBat();
        callSC.dopost("selectInstant");
    }

%>
<body>

</body>
</html>
