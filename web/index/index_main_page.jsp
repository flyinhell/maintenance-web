<%@ page import="com.eland.util.FileProperties" %>
<%--
  Created by IntelliJ IDEA.
  User: wycai
  Date: 2015/4/14
  Time: 下午 02:31
  文件審核頁面
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%!
    private static FileProperties properties = new FileProperties("OpviewMaintenance.properties");
    int FileSizeMax = Integer.parseInt(properties.getProperty("FileSizeMax")); //最大檔案大小
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
    <div id="searchSection" class="portlet">
        <!--最上方標題-->
        <div class="top clearfix">
            <h1 class="pull-left">維運服務操作</h1>
        </div>
        <!--標題和內文區塊間的空白-->
        <div class="borderChart"></div>
        <!--內文區塊-->
        <div class="content">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="index-tab" data-toggle="tab" href="#index" role="tab" aria-controls="index"
                       aria-selected="true">建索引任務</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="indexLog-tab" data-toggle="tab" href="#indexLog" role="tab"
                       aria-controls="indexLog" aria-selected="false">索引Log檢查</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" id="apiIndexStatus-tab" data-toggle="tab" href="#apiIndexStatus" role="tab"
                       aria-controls="apiIndexStatus" aria-selected="false">客製索引狀態檢查</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" id="incrementalIndexStatus-tab" data-toggle="tab" href="#incrementalIndexStatus"
                       role="tab" aria-controls="incrementalIndexStatus" aria-selected="false">漸進索引狀態檢查</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="incrementalIndexStatusLog-tab" data-toggle="tab"
                       href="#incrementalIndexStatusLog" role="tab" aria-controls="incrementalIndexStatusLog"
                       aria-selected="false">漸進索引Log檢查</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="buildFailRecords-tab" data-toggle="tab" href="#buildFailRecords" role="tab"
                       aria-controls="buildFailRecords" aria-selected="false">檢查索引建立失敗狀況</a>
                </li>
            </ul>

            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="index" role="tabpanel" aria-labelledby="index-tab">
                    <jsp:include page='../index/index_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="indexLog" role="tabpanel" aria-labelledby="indexLog-tab">
                    <jsp:include page='../index/indexLog_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="apiIndexStatus" role="tabpanel" aria-labelledby="apiIndexStatus-tab">
                    <jsp:include page='../index/apiIndexStatus_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="incrementalIndexStatus" role="tabpanel"
                     aria-labelledby="incrementalIndexStatus-tab">
                    <jsp:include page='../index/incrementalIndexStatus_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="incrementalIndexStatusLog" role="tabpanel"
                     aria-labelledby="incrementalIndexStatusLog-tab">
                    <jsp:include page='../index/incrementalIndexStatusLog_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="buildFailRecords" role="tabpanel" aria-labelledby="buildFailRecords-tab">
                    <jsp:include page='../index/buildFailRecords_form.jsp'/>
                </div>

            </div>

        </div>

    </div>
    <!--searchSection-->
</div>

</body>
</html>
