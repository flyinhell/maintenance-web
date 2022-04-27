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
                    <a class="nav-link active" id="inspectorIndexStatus-tab" data-toggle="tab" href="#inspectorIndexStatus"
                       role="tab" aria-controls="inspectorIndexStatus" aria-selected="true">索引檢測狀態表</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="inspectorConfigInsert-tab" data-toggle="tab" href="#inspectorConfigInsert"
                       role="tab" aria-controls="inspectorConfigInsert" aria-selected="true">新增索引檢測設定</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="inspectorConfigUpdate-tab" data-toggle="tab" href="#inspectorConfigUpdate"
                       role="tab" aria-controls="inspectorConfigUpdate" aria-selected="true">修改索引檢測設定</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="standardSearch-tab" data-toggle="tab" href="#standardSearch"
                       role="tab" aria-controls="standardSearch" aria-selected="true">搜尋服務-標準</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="advancedSearch-tab" data-toggle="tab" href="#advancedSearch" role="tab"
                       aria-controls="advancedSearch" aria-selected="true">搜尋服務-分流</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="staffSearch-tab" data-toggle="tab" href="#staffSearch" role="tab"
                       aria-controls="staffSearch" aria-selected="true">搜尋服務-內部</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="educationSearch-tab" data-toggle="tab" href="#educationSearch" role="tab"
                       aria-controls="educationSearch" aria-selected="true">搜尋服務-教育</a>
                </li>

            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="inspectorIndexStatus" role="tabpanel"
                     aria-labelledby="inspectorIndexStatus-tab">
                    <jsp:include page='../search/inspectorIndexStatus_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="inspectorConfigInsert" role="tabpanel"
                     aria-labelledby="inspectorConfigInsert-tab">
                    <jsp:include page='../search/inspectorConfigInsert_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="inspectorConfigUpdate" role="tabpanel"
                     aria-labelledby="inspectorConfigUpdate-tab">
                    <jsp:include page='../search/inspectorUpdate_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="standardSearch" role="tabpanel"
                     aria-labelledby="standardSearch-tab">
                    <jsp:include page='../search/standardSearch_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="advancedSearch" role="tabpanel"
                     aria-labelledby="advancedSearch-tab">
                    <jsp:include page='../search/advancedSearch_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="staffSearch" role="tabpanel" aria-labelledby="staffSearch-tab">
                    <jsp:include page='../search/staffSearch_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="educationSearch" role="tabpanel"
                     aria-labelledby="educationSearch-tab">
                    <jsp:include page='../search/educationSearch_form.jsp'/>
                </div>
                </div>

        </div>

    </div>
    <!--searchSection-->
</div>

</body>
</html>
