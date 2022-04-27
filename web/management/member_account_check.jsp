<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.AccountDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: wycai
  Date: 2015/6/18
  Time: 上午 11:44
  確認帳號是否已經存在
--%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>

<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String account = reqWrapper.getParameter("account", "");

    AccountDAO accountDAO = new AccountDAO();

    boolean isExist = accountDAO.isExistAccount(account);
    request.setAttribute("isExist", isExist);
%>
${isExist}