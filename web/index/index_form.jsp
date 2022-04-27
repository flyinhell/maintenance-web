<%@ page import="java.util.Calendar" %>
<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
<%@ page import="com.eland.pojo.model.MachineTypeMappingEntity" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: johnnyhuang
  Date: 2018/3/19
  Time: 下午 02:53
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

        //組新增索引任務條件
        function getInsertIndexTask_args() {
            var args = 'type=insertIndexName';
            var count = 0;

            var insertIndexName = '';
            insertIndexName = $("#insertIndexName").val();
            if (insertIndexName != "" && insertIndexName != null) {
                args += "&insertIndexName=" + encodeURIComponent(insertIndexName);
                count += 1;
            } else {
                alert("請輸入索引庫名稱");
            }
            var insertIndexType = '';
            insertIndexType = $("#insertIndexType").val();
            if (insertIndexType != "" && insertIndexType != null) {
                args += "&insertIndexType=" + insertIndexType;
                count += 1;
            }
            var insertIndexStatus = '';
            insertIndexStatus = $("#insertIndexStatus").val();
            if (insertIndexStatus != "" && insertIndexStatus != null) {
                args += "&insertIndexStatus=" + insertIndexStatus;
                count += 1;
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組刪除索引任務條件
        function getDeleteIndexTask_args() {
            var args = 'type=deleteIndexName';
            var count = 0;

            var deleteIndexName = '';
            deleteIndexName = $("#deleteIndexName").val();
            if (deleteIndexName != "" && deleteIndexName != null) {
                args += "&deleteIndexName=" + encodeURIComponent(deleteIndexName);
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

        //組更新索引任務條件
        function getUpdateIndexTask_args() {
            var args = 'type=updateIndexName';
            var count = 0;

            var updateIndexName = '';
            updateIndexName = $("#updateIndexName").val();
            if (updateIndexName != "" && updateIndexName != null) {
                args += "&updateIndexName=" + encodeURIComponent(updateIndexName);
                count += 1;
            }
            var updateIndexStatus = '';
            updateIndexStatus = $("#updateIndexStatus").val();
            if (updateIndexStatus != "" && updateIndexStatus != null) {
                args += "&updateIndexStatus=" + updateIndexStatus;
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

        //組查詢自訂的搜尋條件
        function getIndexUserDefined_args() {
            var args = 'type=definedCondition';
            var count = 0;

            var condition = '';
            condition = $("#index_UserDefined").val();
            if (condition != "" && condition != null) {

                args += "&condition=" + encodeURIComponent(condition);
//        args += "&condition=" + condition;
                count += 1;
            }

            //沒有下任何條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組索引名稱的搜尋條件
        function getIndexByIndexName_args() {
            var args = 'type=indexName';
            var count = 0;

            var indexName = '';
            indexName = $("#index_NameDefined").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
//        args += "&indexName=" + indexName;
                count += 1;
            }
            var sortField = '';
            sortField = $("#index_indexName_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#index_indexName_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組索引狀態的搜尋條件
        function getIndexByIndexStatus_args() {
            var args = 'type=indexStatus';
            var count = 0;

            var indexStatus = '';
            indexStatus = $("#index_indexStatusField").val();
            if (indexStatus != "" && indexStatus != null) {
                args += "&indexStatus=" + indexStatus;
                count += 1;
            }
            var sortField = '';
            sortField = $("#index_indexStatus_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#index_indexStatus_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組重啟TaskQueue的條件
        function getIndexerRestart_args() {
            var args = 'type=restartTaskQueue';
            var indexer = '';
            indexer = $("#index_Task").val();
            args += "&indexer=" + indexer;
            return args;
        }

        //組關閉TaskQueue的條件
        function getIndexerStop_args() {
            var args = 'type=stopTaskQueue';
            var indexer = '';
            indexer = $("#index_Task").val();
            args += "&indexer=" + indexer;
            return args;
        }

        //組時間範圍的搜尋條件
        function getIndexByIndexTimeRange_args() {
            var args = 'type=indexTimeRange';
            var count = 0;

            var startTime = '';
            startTime = $("#index_lastBuildTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#index_updateTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }
            var sortField = '';
            sortField = $("#index_timeRange_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#index_timeRange_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
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

            //傳送新增索引任務
            $("#insertIndexTask").click(function () {
                var args = getInsertIndexTask_args();
                $.ajax({
                    type: "POST",
                    url: '../index/index_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#indexStatus_resultScope").html(html);
                        if (args == '') {
                        } else {
                            alert("已成功新增索引任務");
                        }
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送刪除索引任務
            $("#deleteIndexTask").click(function () {
                if (confirm("確定要刪除索引任務嗎?")) {
                    var args = getDeleteIndexTask_args();
                    $.ajax({
                        type: "POST",
                        url: '../index/index_result.jsp',
                        data: args,
                        success: function (html) {
                            $("#indexStatus_resultScope").html(html);
                            if (args == '') {
                            } else {
                                alert("已成功刪除索引任務");
                            }
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("搜尋失敗,請稍後再試..");
                        }
                    });
                }

            });
            //傳送更新索引任務
            $("#updateIndexTask").click(function () {
                if (confirm("確定要更新索引任務嗎?")) {
                    var args = getUpdateIndexTask_args();
                    $.ajax({
                        type: "POST",
                        url: '../index/index_result.jsp',
                        data: args,
                        success: function (html) {
                            $("#indexStatus_resultScope").html(html);
                            if (args == '') {
                            } else {
                                alert("已成功更新索引任務");
                            }
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("搜尋失敗,請稍後再試..");
                        }
                    });
                }

            });
            //傳送查詢條件(自訂搜尋)
            $("#indexUserDefined").click(function () {
                var args = getIndexUserDefined_args();
                $.ajax({
                    type: "POST",
                    url: '../index/index_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#indexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(索引庫名稱搜尋)
            $("#indexNameDefined").click(function () {
                var args = getIndexByIndexName_args();
                $.ajax({
                    type: "POST",
                    url: '../index/index_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#indexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(索引庫狀態搜尋)
            $("#indexStatusDefined").click(function () {
                var args = getIndexByIndexStatus_args();
                $.ajax({
                    type: "POST",
                    url: '../index/index_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#indexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //重啟Task_Queue
            $("#TaskRestart").click(function () {
                if (confirm("確定要重啟Task Queue嗎?")) {
                    var args = getIndexerRestart_args();
                    $.ajax({
                        type: "POST",
                        url: '../index/index_result.jsp',
                        data: args,
                        success: function (html) {
                            $("#indexStatus_resultScope").html(html);
                            if (args == '') {
                            } else{
                                alert("已成功重啟Task Queue");
                            }
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("重啟失敗,請稍後再試..");
                        }
                    });
                }
            });

            //關閉Task_Queue
            $("#TaskStop").click(function () {
                if (confirm("確定要關閉Task Queue嗎?")) {
                    var args = getIndexerStop_args();
                    $.ajax({
                        type: "POST",
                        url: '../index/index_result.jsp',
                        data: args,
                        success: function (html) {
                            $("#indexStatus_resultScope").html(html);
                            if (args == '') {
                            } else{
                                alert("已成功關閉Task Queue");
                            }
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("關閉失敗,請稍後再試..");
                        }
                    });
                }
            });

            //傳送查詢條件(時間範圍搜尋)
            $("#indexTimeRangeDefined").click(function () {
                var args = getIndexByIndexTimeRange_args();
                $.ajax({
                    type: "POST",
                    url: '../index/index_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#indexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
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
    String[] dataIndexer = MachineTypeMappingDAO.indexer.keySet().toArray(new String[MachineTypeMappingDAO.indexer.size()]);
%>
<body>
<form>

    <table class="table table-hover">
        <tbody class="topicTableContent">
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;height:25px" class="btn btn-danger"
                       id="insertIndexTask"><span style="font-size:14px;">新增索引任務</span></a></td>
                <td colspan="4"><input type="text" style=";height:30px" class="textInput" placeholder="請輸入索引庫名稱..."
                                       id="insertIndexName"><br>
                    <select style="width:180px;" id="insertIndexType">
                        <%--<option value="">排序欄位</option>--%>
                        <option value="">請選擇索引庫型態</option>
                        <option value="synchronized">synchronized</option>
                        <option value="non-synchronized">non-synchronized</option>
                        <option value="today">today</option>
                        <option value="custom">custom</option>
                    </select><br>
                    <select style="width:180px;" id="insertIndexStatus">
                        <%--<option value="">排序欄位</option>--%>
                        <option value="">請選擇索引建立狀態</option>
                        <option value="Succeed">Succeed</option>
                        <option value="Processing">Processing</option>
                        <option value="Fail">Fail</option>
                        <option value="Rebuild">Rebuild</option>
                    </select></td>
            </tr>
        </form>
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;height:25px" class="btn btn-danger"
                       id="deleteIndexTask"><span style="font-size:14px;">刪除索引任務</span></a></td>
                <td colspan="4"><input type="text" style=";height:30px" class="textInput" placeholder="請輸入索引庫名稱..."
                                       id="deleteIndexName"></td>
            </tr>
        </form>
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;height:25px" class="btn btn-danger"
                       id="updateIndexTask"><span style="font-size:14px;">更新索引任務</span></a></td>
                <td colspan="4"><input type="text" style=";height:30px" class="textInput" placeholder="請輸入索引庫名稱..."
                                       id="updateIndexName"><br>
                    <select style="width:140px;" id="updateIndexStatus">
                        <%--<option value="">排序欄位</option>--%>
                        <option value="">請選擇更新狀態</option>
                        <option value="Succeed">Succeed</option>
                        <option value="Processing">Processing</option>
                        <option value="Fail">Fail</option>
                        <option value="Rebuild">Rebuild</option>
                    </select></td>
            </tr>
        </form>
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;height:25px" class="btn btn-danger"
                       id="TaskRestart"><span style="font-size:14px;">TaskQueue重啟</span></a></td>
                <td><a href="#" type="button" style="width:155px;height:25px" class="btn btn-danger"
                       id="TaskStop"><span style="font-size:14px;">關閉TaskQueue</span></a></td>
                <td colspan="4"><select style="width:140px;" id="index_Task">
                    <%for (int i = 0; i < dataIndexer.length; i++) {%>
                    <option value="<%out.print(dataIndexer[i]);%>"><%out.print(dataIndexer[i]);%></option>
                    <%}%>

                </select></td>

            </tr>
        </form>
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexUserDefined"><span>自訂搜尋條件</span></a>
                </td>
                <td>Where</td>
                <td colspan="4"><input type="text" style="width:450px;height:30px" class="textInput"
                                       placeholder="Ex：index_name like '%today%' and status ='fail' order by start_time desc"
                                       id="index_UserDefined">
                </td>
            </tr>
        </form>
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexNameDefined"><span>索引庫名稱搜尋</span></a></td>
                <td>Where index_name like</td>
                <td colspan="4"><input type="text" style="width:155px;height:30px" class="textInput"
                                       placeholder="索引庫名稱"
                                       id="index_NameDefined">
                </td>
            </tr>
            <tr>
                <td></td>
                <td>order by</td>
                <td><select style="width:140px;" id="index_indexName_sortField">
                    <%--<option value="">排序欄位</option>--%>
                    <option value="index_name">index_name</option>
                    <option value="action_flag">action_flag</option>
                    <option value="index_type">index_type</option>
                    <option value="status">status</option>
                    <option value="last_build_time">last_build_time</option>
                </select></td>
                <td colspan="2"><select style="width:140px;" id="index_indexName_sortType">
                    <option value="asc">asc</option>
                    <option value="desc">desc</option>
                </select></td>
            </tr>
        </form>
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexStatusDefined"><span>索引建立狀態搜尋</span></a></td>
                <td>status =</td>
                <td colspan="4"><select style="width:140px;" id="index_indexStatusField">
                    <option value="Non-Succeed">Non-Succeed</option>
                    <option value="Processing">Processing</option>
                    <option value="Succeed">Succeed</option>
                    <option value="Fail">Fail</option>
                    <option value="Rebuild">Rebuild</option>
                </select></td>
            </tr>
            <tr>
                <td></td>
                <td>order by</td>
                <td><select style="width:140px;" id="index_indexStatus_sortField">
                    <%--<option value="">排序欄位</option>--%>
                    <option value="action_flag">action_flag</option>
                    <option value="index_name">index_name</option>
                    <option value="index_type">index_type</option>
                    <option value="status">status</option>
                    <option value="last_build_time">last_build_time</option>
                </select></td>
                <td colspan="2"><select style="width:140px;" id="index_indexStatus_sortType">
                    <option value="asc">asc</option>
                    <option value="desc">desc</option>
                </select></td>
            </tr>
        </form>
        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexTimeRangeDefined"><span>建立時間範圍搜尋</span></a></td>

                <td>last_build_time >=</td>
                <td>
                    <input type="text" style="width:140px;height:30px" class="textInput" value="<%=startTime%>"
                           id="index_lastBuildTimeField"></td>
                </td>
                <td>last_build_time <</td>
                <td>
                    <input type="text" style="width:140px;height:30px" class="textInput" value="<%=endTime%>"
                           id="index_updateTimeField"></td>
            </tr>
            <tr>
                <td></td>
                <td>order by</td>
                <td><select style="width:140px;" id="index_timeRange_sortField">
                    <option value="index_name">index_name</option>
                    <option value="action_flag">action_flag</option>
                    <option value="index_type">index_type</option>
                    <option value="status">status</option>
                    <option value="last_build_time">last_build_time</option>
                </select></td>
                <td colspan="2"><select style="width:140px;" id="index_timeRange_sortType">
                    <option value="asc">asc</option>
                    <option value="desc">desc</option>
                </select></td>
            </tr>
        </form>
        </tbody>
    </table>
</form>
<div id="indexStatus_resultScope"></div>
</body>
</html>
