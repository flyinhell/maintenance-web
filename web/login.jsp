<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.net.URLDecoder" %>
<%--
  Created by IntelliJ IDEA.
  User: danielhsieh
  Date: 2013/1/18
  Time: 下午 1:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" language="java" %>
<%
    request.setCharacterEncoding("utf-8");
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server


    RequestWrapper reqWrapper = new RequestWrapper(request);
    String target = reqWrapper.getParameter("target", "");
    int errorCode = reqWrapper.getInt("errorCode", 0);
    String errorMsg = "";
    String actionUrl = "Auth";
    if (!target.equals("")) {
        actionUrl = "Auth?target=" + target;
    }

    if (errorCode == 1) {
        errorMsg = "帳號密碼錯誤!";
    }

    boolean cookieAlive = false;
    String userAccount = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("remember")) {
                String remember = URLDecoder.decode(cookie.getValue(), "utf-8");
                userAccount = remember;
            } else if (cookie.getName().equals("user_name")) {
                String value = cookie.getValue();
                if (value != null && !value.equals("")) {
                    cookieAlive = true;
                } else {
                    cookieAlive = false;
                }
            }
        }

        //用來判斷登入時是否直接登入或需重新驗證一次
        if (cookieAlive) {
            if (target.equals("")) {
                target = "/OpviewMaintenance/Copy/CopyMainPage";
            }
            response.sendRedirect(target);
            return;
        }
    }

    request.setAttribute("actionUrl", actionUrl);
    request.setAttribute("userAccount", userAccount);
    request.setAttribute("errorMsg", errorMsg);
    request.setAttribute("moduleName", "LogIn");
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title> 維運管理站台 - 登入 </title>
    <link type="text/css" rel="stylesheet" charset="utf-8" href="css/reset.css"/>
    <link type="text/css" rel="stylesheet" charset="utf-8" href="../css/jquery-ui.min.css?_20141216"/>
    <link type="text/css" rel="stylesheet" charset="utf-8" href="../css/jquery-ui.structure.min.css?_20141216"/>
    <link type="text/css" rel="stylesheet" charset="utf-8" href="../css/jquery-ui.theme.min.css?_20141216"/>
    <link type="text/css" rel="stylesheet" charset="utf-8" href="css/bootstrap.css"/>
    <link type="text/css" rel="stylesheet" charset="utf-8" href="css/colorbox.css"/>
    <link rel="stylesheet" type="text/css" href="css/jquery.fancybox-1.3.4.css"/>
    <link type="text/css" rel="stylesheet" charset="utf-8" href="css/ticker-style.css"/>
    <link type="text/css" rel="stylesheet" charset="utf-8" href="css/style.css"/>
    <script type="text/javascript" src="js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="../js/jquery-ui.min.js?_20141216"></script>
    <script type="text/javascript" src="js/jquery.colorbox.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.ticker.js"></script>
    <script type="text/javascript" src="js/jquery.fancybox-1.3.4.pack.js"></script>
    <script type="text/javascript">
        $(function () {

            $("#inline").fancybox({}); //Header中"關於OpView"使用的效果
            $(".ActionLink").colorbox({opacity: 0.5, iframe: false});
        });

        $(function () {
            $("#login_form input").keypress(function (event) {
                if (event.keyCode == 13) {
                    $("#login_form").submit();
                }
            })
        })

        $(document).ready(function () {
            if ("${errorMsg}" != "") {
                alert("${errorMsg}");
            }
            $(".loginBtn a").click(function () {
                $("#login_form").submit();
            });
        });
    </script>
</head>

<body id="login">
<div class="mainContainer">
    <div id="Header">
        <div><img src="images/loginHeader.png"></div>
    </div><!--Header-->

    <form action="${actionUrl}" id="login_form" method="post">
        <div class="loginContainer">
            <div class="loginContent">
                <div class="form" id="form_login">
                    <h1>登入</h1>
                    <ul class="unstyled">
                        <li>使用者帳號：<input class="textInput" id="Account" name="account" type="text"
                                         value="${userAccount}"></li>
                        <li>　　　密碼：<input class="textInput" id="Password" name="password" type="password" value=""></li>
                        <li>　　　　　　<input type="checkbox" name="rememberMe" id="rememberMe" value="true"
                                         <c:if test="${fn:length(userAccount)>0}">checked</c:if>>
                            <label for="rememberMe" style="display:inline;"> 記住我的帳號</label>
                        </li>
                        <li class="loginBtn"><a href="#" class="btnstyleB"><span>登入</span></a></li>
                    </ul>
                </div><!--form_login-->
            </div><!--loginContent-->
        </div><!--loginContainer-->


    </form>
</div><!--mainContainer-->
<div id="footer">

</div><!--footer-->


</body><!--login-->
</html>
