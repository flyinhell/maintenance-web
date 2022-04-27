<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: johnnyhuang
  Date: 2018/3/7
  Time: 上午 12:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ include file="../include/html_head.jsp" %>
<html>
<head>
    <style type="text/css">
        .textInput, select {
            width: 250px
        }
    </style>

    <script>
        (function ($) {
            $(document).ready(function () {
                $(".COMPtheme, .COMPcenter, #scrollbar1").mCustomScrollbar({
                    theme: "dark"
                });
            });
        })(jQuery);

        //組未完成或失敗任務的查詢條件
        function getUnfinishedBuildIndexStatus_args() {
            var args = 'type=unfinishedBuildIndexStatus';
            return args;
        }

        //組舊表未完成或失敗任務的查詢條件
        function getUnfinishedBuildIndexStatusOld_args() {
            var args = 'type=unfinishedBuildIndexStatusOld';
            return args;
        }

        //組查詢自訂的搜尋條件
        function getIndexStatusUserDefined_args() {
            var args = 'type=definedCondition';
            var count = 0;

            var condition = '';
            condition = $("#indexStatus_UserDefined").val();
            if (condition != "" && condition != null) {
                args += "&condition=" + encodeURIComponent(condition);
                ;
                count += 1;
            }

            //沒有下任何條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組舊表查詢自訂的搜尋條件
        function getIndexStatusUserDefinedOld_args() {
            var args = 'type=definedConditionOld';
            var count = 0;

            var condition = '';
            condition = $("#indexStatus_UserDefinedOld").val();
            if (condition != "" && condition != null) {
                args += "&condition=" + encodeURIComponent(condition);
                ;
                count += 1;
            }

            //沒有下任何條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組索引名稱的搜尋條件
        function getIndexStatusByIndexName_args() {
            var args = 'type=indexName';
            var count = 0;

            var indexName = '';
            indexName = $("#indexNameField").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
                ;
                count += 1;
            } else {
                alert("請輸入索引庫名稱");
            }
            var startTime = '';
            startTime = $("#apiIndexStatus_startTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#apiIndexStatus_endTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }
            var sortField = '';
            sortField = $("#indexName_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#indexName_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組舊表索引名稱的搜尋條件
        function getIndexStatusByIndexNameOld_args() {
            var args = 'type=indexNameOld';
            var count = 0;

            var indexName = '';
            indexName = $("#indexNameFieldOld").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
                ;
                count += 1;
            } else {
                alert("請輸入索引庫名稱");
            }
            var sortField = '';
            sortField = $("#indexName_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#indexName_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組更新狀態的條件
        function getIndexStatusUpdate_args() {
            var args = 'type=indexStatus_update';
            var count = 0;

            var indexName = '';
            indexName = $("#indexNameField_update").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
                count += 1;
            } else {
                alert("請輸入索引庫名稱");
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        $(document).ready(function () {

            $("#inline").fancybox({});
            $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});

            //傳送查詢條件(未完成任務)
            $("#unfinishedBuildIndexStatus").click(function () {
                var args = getUnfinishedBuildIndexStatus_args();
                $.ajax({
                    type: "POST",
                    url: '../index/apiIndexStatus_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#apiIndexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送舊表查詢條件(未完成任務)
            $("#unfinishedBuildIndexStatusOld").click(function () {
                var args = getUnfinishedBuildIndexStatusOld_args();
                $.ajax({
                    type: "POST",
                    url: '../index/apiIndexStatusOld_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#apiIndexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(自訂搜尋)
            $("#indexStatusUserDefined").click(function () {
                var args = getIndexStatusUserDefined_args();
                $.ajax({
                    type: "POST",
                    url: '../index/apiIndexStatus_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#apiIndexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送舊表查詢條件(自訂搜尋)
            $("#indexStatusUserDefinedOld").click(function () {
                var args = getIndexStatusUserDefinedOld_args();
                $.ajax({
                    type: "POST",
                    url: '../index/apiIndexStatusOld_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#apiIndexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(索引庫名稱搜尋)
            $("#indexName").click(function () {
                var args = getIndexStatusByIndexName_args();
                $.ajax({
                    type: "POST",
                    url: '../index/apiIndexStatus_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#apiIndexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送舊表查詢條件(索引庫名稱搜尋)
            $("#indexNameOld").click(function () {
                var args = getIndexStatusByIndexNameOld_args();
                $.ajax({
                    type: "POST",
                    url: '../index/apiIndexStatusOld_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#apiIndexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送更新條件
            $("#indexStatus_update").click(function () {
                if(confirm("確定要修改狀態為Fail嗎?")){
                    var args = getIndexStatusUpdate_args();
                    $.ajax({
                        type: "POST",
                        url: '../index/apiIndexStatus_result.jsp',
                        data: args,
                        success: function (html) {
                            $("#apiIndexStatus_resultScope").html(html);
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("搜尋失敗,請稍後再試..");
                        }
                    });
                }
            });
        });
    </script>
</head>
<%
    SimpleDateFormat startTimeDateFormat = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
    SimpleDateFormat endTimeDateFormat = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
    Calendar today = Calendar.getInstance();
    String startTime = startTimeDateFormat.format(today.getTime());
    String endTime = endTimeDateFormat.format(today.getTime());
%>
<body>
<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <form>
            <tr>
                <td colspan="6"><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                                   id="unfinishedBuildIndexStatusOld"><span>舊表未完成或失敗任務</span></a></td>
            </tr>
        </form>
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexStatusUserDefinedOld"><span>自訂搜尋條件</span></a></td>
                <td>WHERE</td>
                <td colspan="4"><input type="text" style="width:480px;height:30px" class="textInput"
                                       placeholder="Ex：index_name like '%WH_Fet_Today%' and status ='fail' order by action_flag desc"
                                       id="indexStatus_UserDefinedOld"></td>
            </tr>
        </form>

        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexNameOld"><span>索引名稱搜尋</span></a></td>
                <td>WHERE index_name like</td>
                <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="索引庫名稱"
                           id="indexNameFieldOld"></td>
                <td>order by</td>
                <td><select style="width:140px;" id="indexName_sortFieldOld">
                    <%--<option value="">排序欄位</option>--%>
                    <option value="start_time">start_time</option>
                    <option value="index_name">index_name</option>
                    <option value="status">status</option>
                </select></td>
                <td><select style="width:70px;" id="indexName_sortTypeOld">
                    <option value="desc">desc</option>
                    <option value="asc">asc</option>
                </select></td>
            </tr>
        </form>
        <form>
            <tr>
                <td colspan="6"><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                                   id="unfinishedBuildIndexStatus"><span>查詢未完成或失敗任務</span></a></td>
            </tr>
        </form>
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexStatusUserDefined"><span>自訂搜尋條件</span></a></td>
                <td>WHERE</td>
                <td colspan="4"><input type="text" style="width:480px;height:30px" class="textInput"
                                       placeholder="Ex：index_name like '%WH_Khc%' and status ='fail' order by action_flag desc"
                                       id="indexStatus_UserDefined"></td>
            </tr>
        </form>

        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexName"><span>索引名稱搜尋</span></a></td>
                <td>WHERE index_name like</td>
                <td colspan="4"><input type="text" style="width:140px;height:30px" class="textInput" placeholder="索引庫名稱"
                           id="indexNameField"></td>
            </tr>
            <tr>
                <td></td>
                <td>AND start_time >=</td>
                <td>
                    <input type="text" style="width:140px;height:30px" class="textInput" value="<%=startTime%>"
                           id="apiIndexStatus_startTimeField"></td>
                </td>
                <td>AND start_time <</td>
                <td colspan="2">
                    <input type="text" style="width:140px;height:30px" class="textInput" value="<%=endTime%>"
                           id="apiIndexStatus_endTimeField"></td>
            </tr>
            <tr>
                <td></td>
                <td>order by</td>
                <td><select style="width:140px;" id="indexName_sortField">
                    <%--<option value="">排序欄位</option>--%>
                    <option value="start_time">start_time</option>
                    <option value="index_name">index_name</option>
                    <option value="status">status</option>
                </select></td>
                <td colspan="3"><select style="width:70px;" id="indexName_sortType">
                    <option value="desc">desc</option>
                    <option value="asc">asc</option>
                </select></td>
            </tr>
            <tr>
                <td><a href="#" type="button" style="width:155px;height:25px" class="btn btn-danger"
                       id="indexStatus_update"><span style="font-size:14px;">修改狀態為Fail</span></a></td>
                <td>WHERE index_name = </td>
                <td colspan="4"><input type="text" style="width:140px;height:30px" class="textInput" placeholder="索引庫名稱"
                           id="indexNameField_update"></td>
            </tr>
        </form>

        </tbody>
    </table>
</form>

<div id="apiIndexStatus_resultScope"></div>

</body>
</html>
