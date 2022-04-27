<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.cloner.CallCheckTools" %>
<%@ page import="com.eland.cloner.CallStartupTools" %>
<%@ page import="com.eland.dao.ClonerStatusDAO" %>
<%@ page import="com.eland.cloner.CallKillTools" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/3/31
  Time: 下午 02:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
    RequestWrapper reqWrapper = new RequestWrapper(request);

    String type = reqWrapper.getParameter("type");
    String machineName = reqWrapper.getParameter("machineName");
    if (type.equals("check")) {
        if (!machineName.equals("") || machineName != null) {
            CallCheckTools callCheckTools = new CallCheckTools();
            callCheckTools.callCheckTools(machineName);
        }
    } else if (type.equals("startup")) {
        if (!machineName.equals("") || machineName != null) {
            CallStartupTools callStartupTools=new CallStartupTools();
            callStartupTools.callStartupTools(machineName);

        }
    } else if (type.equals("close")) {
        if (!machineName.equals("") || machineName != null) {
            ClonerStatusDAO closeCloner = new ClonerStatusDAO();
            closeCloner.callCloseTools(machineName);
        }
    } else if (type.equals("kill")) {
        if (!machineName.equals("") || machineName != null) {
            CallKillTools callKillTools = new CallKillTools();
            callKillTools.callKillTools(machineName);

        }
    } else {

    }
%>
</body>
</html>
