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
                    <a class="nav-link active" id="indexPath-tab" data-toggle="tab" href="#indexPath" role="tab"
                       aria-controls="indexPath" aria-selected="true">切換檢查</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="task-tab" data-toggle="tab" href="#task" role="tab" aria-controls="task"
                       aria-selected="false">複製狀態檢查</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="taskLog-tab" data-toggle="tab" href="#taskLog" role="tab"
                       aria-controls="taskLog" aria-selected="false">複製Log檢查</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="cloner-tab" data-toggle="tab" href="#cloner" role="tab"
                       aria-controls="cloner" aria-selected="false">Cloner狀態</a>
                </li>
            </ul>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="indexPath" role="tabpanel" aria-labelledby="indexPath-tab">
                    <jsp:include page='../copy/indexPath_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="task" role="tabpanel" aria-labelledby="task-tab">
                    <jsp:include page='../copy/task_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="taskLog" role="tabpanel" aria-labelledby="taskLog-tab">
                    <jsp:include page='../copy/taskLog_form.jsp'/>
                </div>
                <div class="tab-pane fade" id="cloner" role="tabpanel" aria-labelledby="copy-tab">
                    <jsp:include page='../copy/copy_form.jsp'/>
                </div>

            </div>

        </div>

    </div>
    <!--searchSection-->
</div>

</body>
</html>
