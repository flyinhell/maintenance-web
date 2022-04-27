<%@ page import="com.eland.dao.AccountDAO" %>
<%@ page import="com.eland.pojo.model.AccountEntity" %>
<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eland.pojo.view.UserInfo" %>

<%--
  Created by IntelliJ IDEA.
  User: wycai
  Date: 2015/5/27
  Time: 上午 01:25
  預設列出所有使用者
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    //頁面，查詢筆數分頁
    int recordFrom = reqWrapper.getInt("page", 0); //從第幾筆開始
    int totalSize = 0;      //資料總筆數
    int permissions = 0;
    String email = null;
    String user = null;
    //取得對應UserID
    AccountDAO accountDAO = new AccountDAO();
    List<AccountEntity> accountInfoList = new LinkedList<AccountEntity>();

    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user_name")) {
                user = cookie.getValue();

                //讀取資料庫使用者權限
                AccountEntity resultList = accountDAO.getByUser(user);
                permissions = new Integer(resultList.getPermissions());
                email = resultList.getEmail();
                request.setAttribute("user", user);
                request.setAttribute("email", email);
            }
        }
    }

    try {

        accountInfoList = accountDAO.list(user);
        totalSize = accountInfoList.size();
    } catch (Exception e) {
        logger.error("列出所有使用者發生錯誤：", e.getStackTrace());
    }

    recordFrom = (recordFrom * perPageRecord);  //從第幾筆開始 = 頁面 * 數量

    request.setAttribute("accountInfoList", accountInfoList);
    request.setAttribute("startNum", recordFrom);   //列表顯示資料筆數位置
    request.setAttribute("endNum", recordFrom + perPageRecord);


%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <%@ include file="../include/html_head.jsp" %>
    <script>
        (function ($) {
            $(document).ready(function () {
                $(".COMPtheme, .COMPcenter, #scrollbar1").mCustomScrollbar({
                    theme: "dark"
                });
            });
        })(jQuery);
        $(document).ready(function () {
            $("#inline").fancybox({});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});
            $(".addNewMember").colorbox({iframe: false, width: "560px", title: "新增維運人員資訊"});
            $(".updateMemberEmail").colorbox({iframe: false, width: "560px", title: "修改帳號信箱"});
            $(".editMember").colorbox({iframe: false, width: "560px", title: "編輯維運人員資訊"});
            $(".updateMemberPassword").colorbox({iframe: false, width: "560px", title: "修改帳號密碼"});
            //$(".updateMemberEmail").colorbox({iframe: false, width: "560px", title: "修改帳號信箱"});

        });
        $(function () {
            $("#ddl_sourceId").multiselect({
                selectedList: 1
            });
        });
        /* scrollUp Minimum setup */
        $(function () {
            $.scrollUp({
                scrollText: 'Scroll to top'
            });
        });

        function switchSearchMode(page) {
            location.href = "../Management/Member?act=list&page=" + page;

        }

    </script>
</head>
<body id="main">
<%@include file="../include/header.jsp" %>

<div class="mainContainer">
    <div class="pageHeader">
        <h1><i class="icon-user icon-2x pull-left"></i>使用者資訊
        </h1>
    </div>
    <!--pageHeader-->
    <div id="searchSection" class="portlet">
        <div class="top clearfix">
            <h1 class="pull-left">個人帳號管理</h1>
        </div>
        <!--top-->
        <div class="content">
            <table class="table profilesTable">
                <thead>
                <tr>
                    <th>&nbsp;</th>
                    <th>名稱</th>
                    <th>${user}</th>
                    <th width="180"></th>
                </tr>
                <tr>
                    <th>&nbsp;</th>
                    <th>郵件地址</th>
                    <th>${email}</th>
                    <th width="180"></th>
                </tr>
                <tr>
                    <th>&nbsp;</th>
                    <th>
                        <div>
                            <a href="../Management/MemberAccountUpdate?act=updatePassword&account=${user}"
                               class="btnstyleB updateMemberPassword"><span>修改密碼</span></a>
                        </div>
                    </th>
                    <th>
                        <div>
                            <a href="../Management/MemberAccountUpdate?act=updateEmail&account=${user}"
                               class="btnstyleB updateMemberEmail"><span>修改信箱</span></a>
                        </div>
                    </th>
                    <th width="180"></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>

        </div>

        <%
            //權限等於0，顯示個人資訊及使用者清單
            if (permissions == 0) {
        %>

        <div class="top clearfix">
            <h1 class="pull-left">權限管理</h1>
        </div>

        <div class="content">
            <div class="addTopic clearfix">
                <div>
                    <a href="../Management/MemberEdit?act=new" class="btnstyleB addNewMember"><span>新增維運人員</span></a>
                </div>

            </div>
            <table class="table profilesTable">
                <thead>
                <tr>
                    <th>&nbsp;</th>
                    <th>名稱</th>
                    <th>郵件地址</th>
                    <th width="180">操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="member" items="${accountInfoList}" begin="${startNum}" end="${endNum}">
                    <tr>
                        <td></td>
                        <td>${member.userName}</td>
                        <td>${member.email}</td>
                        <td><a href="../Management/MemberEdit?act=editPassword&account=${member.userName}"
                               class="btnstyleA editMember"><span>重設密碼</span></a>&nbsp;
                            <a href="../Management/MemberEdit?act=editEmail&account=${member.userName}"
                               class="btnstyleA editMember"><span>編輯信箱</span></a>&nbsp;
                            <a href="../Management/MemberAction?act=delete&account=${member.userName}"
                               onclick="return confirm('確定要刪除${member.userName}帳戶嗎?')"
                               class="btnstyleDEL"><span>刪除</span></a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
        <!--content-->
        <%@ include file="../include/pagination.jsp" %>
        <%
            }
        %>
    </div>
    <!--searchSection-->
</div>


</body>
</html>
