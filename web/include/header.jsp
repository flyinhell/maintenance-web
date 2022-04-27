<%@ page import="com.eland.pojo.view.UserInfo" %>
<%--
  Created by IntelliJ IDEA.
  User: wycai
  Date: 2015/4/15
  Time: 上午 11:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //確認使用者資訊
    UserInfo headerUserInfo = new UserInfo();
    headerUserInfo = (UserInfo) session.getAttribute("userInfo");


%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript" src="../js/jquery.autocomplete.js"></script>
<div id="header" class="clearfix">
    <div class="wrapper clearfix">
        <div class="content clearfix">
            <header class="pull-left">
                <nav>
                    <ul class="nav clearfix">
                        <li class="dropdown">
                            <a href="../Copy/CopyMainPage"
                               class="nav-icon statistics"><span>複製任務</span><b>複製任務</b></a>
                        </li>

                        <li class="dropdown">
                            <a href="../Index/IndexMainPage"
                               class="nav-icon socialImpact"><span>建立索引服務</span><b>建立索引服務</b></a>
                        </li>
                        <li class="dropdown">
                            <a href="../Search/SearchMainPage"
                               class="nav-icon view"><span>搜尋服務</span><b>搜尋服務</b></a>
                        </li>
                        <li class="dropdown">
                            <a href="../Operate/OperateMainPage"
                               class="nav-icon analysis"><span>日常維運</span><b>日常維運</b></a>
                        </li>
                        <li class="dropdown">
                            <a href="../Monthly/MonthlyMainPage"
                               class="nav-icon statistics"><span>跨月操作</span><b>跨月操作</b></a>
                        </li>
                        <li class="dropdown">
                            <a href="../Management/Member"
                               class="nav-icon manage"><span>權限管理</span><b>權限管理</b></a>
                        </li>
                        <li class="navEndLine"><!--Opview 3.2 新增分隔線LI--></li>
                    </ul>
                    <!--nav clearfix-->
                </nav>
            </header>
            <div id="member-info" class="pull-right">
                <%--<span class="msg">Hi~<a href="#">${sessionScope.userInfo.user}</a></span>--%>
                <a class="btnstyleB" href="../LogOut"><span>登出</span></a>
            </div>
            <!--member-info-->
        </div>
        <!--content-->
    </div>
    <!--wrapper-->
</div>
<!--header-->
