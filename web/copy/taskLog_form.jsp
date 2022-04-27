<%@ page import="com.sun.star.bridge.oleautomation.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/3
  Time: 下午 12:09
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

        //組最近失敗任務log的查詢條件
        function getFailTaskLog_args() {
            var args = 'type=failTaskLog';
            var count = 0;
            var topNum = '';
            topNum = $("#taskLog_topNum").val();
            if (topNum != "" && topNum != null) {
                args += "&topNum=" + topNum;
                count += 1;
            }
            //沒有下任何條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組查詢自訂的搜尋條件
        function getTasLogUserDefined_args() {
            var args = 'type=definedCondition';
            var count = 0;

            var condition = '';
            condition = $("#taskLog_UserDefined").val();
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
        function getTaskLogByIndexName_args() {
            var args = 'type=indexName';
            var count = 0;

            var indexName = '';
            indexName = $("#taskLog_indexNameField").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
//        args += "&indexName=" + indexName;
                count += 1;
            }
            var startTime = '';
            startTime = $("#taskLog_indexName_startTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#taskLog_indexName_endTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }
            var sortField = '';
            sortField = $("#taskLog_indexName_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#taskLog_indexName_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組目標機器[targetPath]的搜尋條件
        function getTaskLogByTargetPath_args() {
            var args = 'type=targetPath';
            var count = 0;

            var targetPath = '';
            targetPath = $("#taskLog_targetPathField").val();
            if (targetPath != "" && targetPath != null) {
                args += "&targetPath=" + targetPath;
                count += 1;
            }
            var startTime = '';
            startTime = $("#taskLog_targetPath_startTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#taskLog_targetPath_endTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }
            var sortField = '';
            sortField = $("#taskLog_targetPath_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#task_targetPath_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組cloner機器的搜尋條件
        function getTaskLogByActionFlag_args() {
            var args = 'type=actionFlag';
            var count = 0;

            var actionFlag = '';
            actionFlag = $("#taskLog_actionFlagField").val();
            if (actionFlag != "" && actionFlag != null) {
                args += "&actionFlag=" + actionFlag;
                count += 1;
            }
            var startTime = '';
            startTime = $("#taskLog_actionFlag_startTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#taskLog_actionFlag_endTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }

            var sortField = '';
            sortField = $("#taskLog_actionFlag_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#taskLog_actionFlag_sortType").val();
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

            //傳送查詢條件(未完成任務)
            $("#failTaskLog").click(function () {
                var args = getFailTaskLog_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/taskLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#taskLog_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(自訂搜尋)
            $("#taskLogUserDefined").click(function () {
                var args = getTasLogUserDefined_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/taskLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#taskLog_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(索引庫名稱搜尋)
            $("#taskLogIndexName").click(function () {
                var args = getTaskLogByIndexName_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/taskLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#taskLog_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(目標機器名稱搜尋)
            $("#taskLogTargetPath").click(function () {
                var args = getTaskLogByTargetPath_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/taskLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#taskLog_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(Cloner機器名稱搜尋)
            $("#taskLogActionFlag").click(function () {
                var args = getTaskLogByActionFlag_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/taskLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#taskLog_resultScope").html(html);
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
%>
<body>

<table class="table table-hover">
    <tbody class="topicTableContent">
    <form>
        <tr>
            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                   id="failTaskLog"><span>查詢最近失敗任務紀錄</span></a></td>

            <td>top</td>
            <td colspan="4"><select style="width:140px;" id="taskLog_topNum">
                <option value="10">10</option>
                <option value="25">25</option>
                <option value="50">50</option>
                <option value="75">75</option>
                <option value="100">100</option>
            </select></td>
        </tr>
    </form>

    <form>
        <tr>
            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                   id="taskLogUserDefined"><span>自訂搜尋條件</span></a></td>
            <td>WHERE</td>
            <td colspan="4"><input type="text" style="width:480px;height:30px" class="textInput"
                                   placeholder="Ex：index_name like '%today%' and status ='fail' order by action_flag desc"
                                   id="taskLog_UserDefined"></td>

        </tr>
    </form>

    <form>
        <tr>
            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                   id="taskLogIndexName"><span>索引名稱搜尋</span></a></td>
            <td>WHERE index_name like</td>
            <td colspan="3"><input type="text" style="width:140px;height:30px" class="textInput" placeholder="索引庫名稱"
                                   id="taskLog_indexNameField"></td>
        </tr>
        <tr>
            <td></td>
            <td>AND task_start_time >=</td>
            <td>
                <input type="text" style="width:140px;height:30px" class="textInput" value="<%=startTime%>"
                       id="taskLog_indexName_startTimeField"></td>
            </td>
            <td>AND task_start_time <</td>
            <td>
                <input type="text" style="width:140px;height:30px" class="textInput" value="<%=endTime%>"
                       id="taskLog_indexName_endTimeField"></td>
        </tr>
        <tr>
            <td></td>
            <td>order by</td>
            <td><select style="width:140px;" id="taskLog_indexName_sortField">
                <%--<option value="">排序欄位</option>--%>
                <option value="task_start_time">task_start_time</option>
                <option value="task_end_time">task_end_time</option>
                <option value="index_name">index_name</option>
                <option value="action_flag">action_flag</option>
                <option value="target_path">target_path</option>
                <option value="status">status</option>
            </select></td>
            <td colspan="2"><select style="width:70px;" id="taskLog_indexName_sortType">
                <option value="desc">desc</option>
                <option value="asc">asc</option>
            </select></td>
        </tr>
    </form>
    <%
        String[] dataIndexer = MachineTypeMappingDAO.indexer.keySet().toArray(new String[MachineTypeMappingDAO.indexer.size()]);
        String[] dataStandard = MachineTypeMappingDAO.standard.keySet().toArray(new String[MachineTypeMappingDAO.standard.size()]);
        String[] dataAdvanced = MachineTypeMappingDAO.advanced.keySet().toArray(new String[MachineTypeMappingDAO.advanced.size()]);
        String[] dataStaffOnly = MachineTypeMappingDAO.staffOnly.keySet().toArray(new String[MachineTypeMappingDAO.staffOnly.size()]);
        String[] dataInstant = MachineTypeMappingDAO.instant.keySet().toArray(new String[MachineTypeMappingDAO.instant.size()]);
    %>
    <form>
        <tr>
            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                   id="taskLogTargetPath"><span>機器名稱搜尋</span></a></td>
            <td>WHERE target_path =</td>
            <td colspan="3"><select style="width:140px;" id="taskLog_targetPathField">
                <option value="">目標機器</option>
                <%for (int i = 0; i < dataStandard.length; i++) {%>
                <option value="<%out.print(dataStandard[i]);%>"><%out.print(dataStandard[i]);%></option>
                <%}%>
                <%for (int i = 0; i < dataAdvanced.length; i++) {%>
                <option value="<%out.print(dataAdvanced[i]);%>"><%out.print(dataAdvanced[i]);%></option>
                <%}%>
                <%for (int i = 0; i < dataStaffOnly.length; i++) {%>
                <option value="<%out.print(dataStaffOnly[i]);%>"><%out.print(dataStaffOnly[i]);%></option>
                <%}%>
                <%for (int i = 0; i < dataInstant.length; i++) {%>
                <option value="<%out.print(dataInstant[i]);%>"><%out.print(dataInstant[i]);%></option>
                <%}%>

            </select></td>
        </tr>
        <tr>
            <td></td>
            <td>AND task_start_time >=</td>
            <td>
                <input type="text" style="width:140px;height:30px" class="textInput" value="<%=startTime%>"
                       id="taskLog_targetPath_startTimeField"></td>
            </td>
            <td>AND task_start_time <</td>
            <td>
                <input type="text" style="width:140px;height:30px" class="textInput" value="<%=endTime%>"
                       id="taskLog_targetPath_endTimeField"></td>
        </tr>
        <tr>
            <td></td>
            <td>order by</td>
            <td><select style="width:140px;" id="taskLog_targetPath_sortField">
                <option value="task_start_time">task_start_time</option>
                <option value="task_end_time">task_end_time</option>
                <option value="index_name">index_name</option>
                <option value="action_flag">action_flag</option>
                <option value="target_path">target_path</option>
                <option value="status">status</option>
            </select></td>
            <td colspan="2"><select style="width:70px;" id="taskLog_targetPath_sortType">
                <option value="desc">desc</option>
                <option value="asc">asc</option>
            </select></td>

        </tr>
    </form>

    <form>
        <tr>
            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary" id="taskLogActionFlag"><span>Cloner機器搜尋</span></a>
            </td>
            <td>WHERE action_flag =</td>
            <td colspan="3"><select style="width:140px;" id="taskLog_actionFlagField">
                <option value="">Cloner機器</option>
                <%for (int i = 0; i < dataIndexer.length; i++) {%>
                <option value="<%out.print(dataIndexer[i]);%>"><%out.print(dataIndexer[i]);%></option>
                <%}%>
                <%for (int i = 0; i < dataStandard.length; i++) {%>
                <option value="<%out.print(dataStandard[i]);%>"><%out.print(dataStandard[i]);%></option>
                <%}%>
            </select></td>
        </tr>
        <tr>
            <td></td>
            <td>AND task_start_time >=</td>
            <td>
                <input type="text" style="width:140px;height:30px" class="textInput" value="<%=startTime%>"
                       id="taskLog_actionFlag_startTimeField"></td>
            </td>
            <td>AND task_start_time <</td>
            <td>
                <input type="text" style="width:140px;height:30px" class="textInput" value="<%=endTime%>"
                       id="taskLog_actionFlag_endTimeField"></td>
        </tr>
        <tr>
            <td></td>
            <td>order by</td>
            <td><select style="width:140px;" id="taskLog_actionFlag_sortField">
                <option value="task_start_time">task_start_time</option>
                <option value="task_end_time">task_end_time</option>
                <option value="index_name">index_name</option>
                <option value="action_flag">action_flag</option>
                <option value="target_path">target_path</option>
                <option value="status">status</option>
            </select></td>
            <td colspan="2"><select style="width:70px;" id="taskLog_actionFlag_sortType">
                <option value="desc">desc</option>
                <option value="asc">asc</option>
            </select></td>
        </tr>
    </form>

    </tbody>
</table>


<div id="taskLog_resultScope"></div>
</body>
</html>