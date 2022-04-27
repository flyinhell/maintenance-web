<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eland.dao.AccountDAO" %>
<%@ page import="com.eland.pojo.model.AccountEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: wycai
  Date: 2015/5/27
  Time: 上午 01:25
  預設列出所有使用者
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

    /*RequestWrapper reqWrapper = new RequestWrapper(request);
    //頁面，查詢筆數分頁
    int recordFrom = reqWrapper.getInt("page", 0); //從第幾筆開始
    int totalSize = 0;      //資料總筆數
    //取得對應UserID
    AccountDAO accountDAO = new AccountDAO();
    List<AccountEntity> accountInfoList = new LinkedList<AccountEntity>();

    recordFrom = (recordFrom * perPageRecord);  //從第幾筆開始 = 頁面 * 數量

    request.setAttribute("accountInfoList", accountInfoList);
    request.setAttribute("startNum", recordFrom);   //列表顯示資料筆數位置
    request.setAttribute("endNum", recordFrom + perPageRecord);*/


%>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <%@ include file="../include/html_style_bootstrap.jsp" %>
    <%@ include file="../include/html_head.jsp" %>
    <%@ include file="../include/html_collapse_bootstrap.jsp" %>

</head>
<body id="main">
<%@include file="../include/header.jsp" %>
<div class="mainContainer">
    <!--pageHeader-->
    <div id="searchSection" class="portlet">
        <div class="top clearfix">
            <h1 class="pull-left">維運服務操作</h1>
        </div>

        <!--標題和內文區塊間的空白-->
        <div class="borderChart"></div>
        <!--內文區塊-->
        <div class="content">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="indexStatus-tab" data-toggle="tab" href="#indexStatus" role="tab"
                       aria-controls="indexStatus" aria-selected="true">索引狀態表</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="machineStatus-tab" data-toggle="tab" href="#machineStatus" role="tab"
                       aria-controls="machineStatus" aria-selected="false">機器狀態表</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="errorLog-tab" data-toggle="tab" href="#errorLog" role="tab"
                       aria-controls="errorLog" aria-selected="false">錯誤紀錄</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="indexUpdate-tab" data-toggle="tab" href="#indexConfigInsert" role="tab"
                       aria-controls="indexUpdate" aria-selected="false">新增索引設定</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="machineUpdate-tab" data-toggle="tab" href="#machineUpdate" role="tab"
                       aria-controls="machineUpdate" aria-selected="false">新增機器設定</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="monthlyUpdate-tab" data-toggle="tab" href="#monthlyUpdate" role="tab"
                       aria-controls="monthlyUpdate" aria-selected="false">跨月設定修改</a>
                </li>

            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="indexStatus" role="tabpanel"
                     aria-labelledby="indexStatus-tab">
                    <jsp:include page='../monthly/indexStatus_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="errorLog" role="tabpanel" aria-labelledby="errorLog-tab">
                    <jsp:include page='../monthly/errorLog_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="machineStatus" role="tabpanel" aria-labelledby="machineStatus-tab">
                    <jsp:include page='../monthly/machineStatus_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="indexConfigInsert" role="tabpanel" aria-labelledby="indexUpdate-tab">
                    <jsp:include page='../monthly/indexConfigInsert_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="machineUpdate" role="tabpanel" aria-labelledby="machineUpdate-tab">
                    <jsp:include page='../monthly/machineUpdate_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="monthlyUpdate" role="tabpanel" aria-labelledby="indexUpdate-tab">
                    <jsp:include page='../monthly/monthlyUpdate_forum.jsp'/>
                </div>
            </div>

        </div>

    </div>
    <!--searchSection-->
</div>
</body>
</html>
