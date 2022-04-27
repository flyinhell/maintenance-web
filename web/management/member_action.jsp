<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eland.dao.AccountDAO" %>
<%@ page import="com.eland.pojo.model.AccountEntity" %>
<%@ page import="javax.swing.*" %>
<%--
  Created by IntelliJ IDEA.
  User: wycai
  Date: 2015/5/27
  Time: 上午 01:37
  新增 / 修改 使用者對應審核者
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>

<%--因使用了<%@include />標籤，導致頁面有大量空白行，清除空白--%>
<%@ page trimDirectiveWhitespaces="true" %>

<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String act = reqWrapper.getParameter("act");
    String email = reqWrapper.getParameter("email");
    String account = reqWrapper.getParameter("account");
    String password = reqWrapper.getParameter("password");
    AccountDAO accountDAO = new AccountDAO();
    String memberUrl = "";

    //admin新增帳戶
    if (act.equals("new")) {
        AccountEntity accountEntity = new AccountEntity();
        //新增 AuthorInfo
        accountEntity.setUserName(account);
        accountEntity.setEmail(email);
        accountEntity.setPassword(password);
        accountEntity.setPermissions(1);
        accountEntity.setEmailSwitch("true");
        accountDAO.insert(accountEntity, password);
        memberUrl = response.encodeRedirectURL("../Management/Member");
        response.sendRedirect(memberUrl);

        //admin編輯其他帳戶密碼
    } else if (act.equals("editPassword")) {
        //修改 AuthorInfo
        AccountEntity accountEntity = new AccountEntity();
        accountEntity = accountDAO.getByUser(account);
        accountEntity.setPassword(password);
        accountDAO.editPassword(accountEntity, password);
        out.print("修改成功");

        //admin編輯其他帳戶email
    } else if (act.equals("editEmail")) {
        //修改 AuthorInfo
        AccountEntity accountEntity = new AccountEntity();
        accountEntity = accountDAO.getByUser(account);
        accountEntity.setEmail(email);
        accountDAO.editEmail(accountEntity);
        out.print("修改成功");

        //admin刪除其他帳戶
    } else if (act.equals("delete")) {
        String user = reqWrapper.getParameter("account");
        //宣告ㄧ個AccountEntity作db欄位的存取
        AccountEntity accountEntity = accountDAO.getByUser(user);
        accountDAO.delete(accountEntity);
        memberUrl = response.encodeRedirectURL("../Management/Member");
        response.sendRedirect(memberUrl);

        //自行更改密碼
    } else if (act.equals("updatePassword")) {
        //修改 AuthorInfo
        String newPassword = reqWrapper.getParameter("newPassword");
        AccountEntity accountEntity = new AccountEntity();
        accountEntity = accountDAO.getByUser(account);

        if (accountDAO.md5(password).equals(accountEntity.getPassword())) {
            accountDAO.updatePassword(accountEntity, newPassword);
            out.print("修改成功");
        } else {
            out.print("密碼錯誤");
        }

        //自行更改email
    } else if (act.equals("updateEmail")) {
        //修改 AuthorInfo
        AccountEntity accountEntity = new AccountEntity();
        accountEntity = accountDAO.getByUser(account);

        if (accountDAO.md5(password).equals(accountEntity.getPassword())) {
            accountDAO.updateEmail(accountEntity, email);
            out.print("修改成功");
        } else {
            out.print("密碼錯誤");
        }

    }

%>
