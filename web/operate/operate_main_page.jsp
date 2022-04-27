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
                    <a class="nav-link active" id="custom-tab" data-toggle="tab" href="#custom" role="tab"
                       aria-controls="custom" aria-selected="true">客製索引任務</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="rollback-tab" data-toggle="tab" href="#rollback" role="tab"
                       aria-controls="rollback" aria-selected="false">回溯索引任務</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="newSource-tab" data-toggle="tab" href="#newSource" role="tab"
                       aria-controls="newSource" aria-selected="false">新增新來源</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="killSC-tab" data-toggle="tab" href="#killSC" role="tab"
                       aria-controls="killSC" aria-selected="false">清除搜尋</a>
                </li>

            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="custom" role="tabpanel" aria-labelledby="custom-tab">
                    <jsp:include page='../operate/custom_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="rollback" role="tabpanel" aria-labelledby="index-tab">
                    <jsp:include page='../operate/rollback_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="newSource" role="tabpanel" aria-labelledby="index-tab">
                    <jsp:include page='../operate/newSource_forum.jsp'/>
                </div>
                <div class="tab-pane fade" id="killSC" role="tabpanel" aria-labelledby="index-tab">
                    <jsp:include page='../operate/killSearchCommand_forum.jsp'/>
                </div>
            </div>

        </div>

    </div>
    <!--searchSection-->
</div>

</body>
</html>
