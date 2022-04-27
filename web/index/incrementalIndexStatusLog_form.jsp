<%@ page import="java.util.Calendar" %>
<%@ page import="com.eland.dao.IncrementalIndexStatusLogDAO" %>
<%@ page import="com.eland.pojo.model.IncrementalIndexStatusLogEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
<%@ page import="com.eland.pojo.model.MachineTypeMappingEntity" %>
<%@ page import="com.eland.dao.IncrementalIndexStatusDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: johnnyhuang
  Date: 2018/3/7
  Time: 上午 09:29
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

        //組查詢條件
        function getArgs_IncrementalStatusLog() {
            var args = '1=1';
            var count = 0;

            var indexName = '';
            indexName = $("#increStatusLog_indexName").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + indexName;
                count += 1;
            }
            var machineName = '';
            machineName = $("#increStatusLog_machineName").val();
            if (machineName != "" && machineName != null) {
                args += "&machineName=" + machineName;
                count += 1;
            }
            var status = '';
            status = $("#increStatusLog_status").val();
            if (status != "" && status != null) {
                args += "&status=" + status;
                count += 1;
            }
            var type = '';
            type = $("#increStatusLog_type").val();
            if (type != "" && type != null) {
                args += "&type=" + type;
                count += 1;
            }
            var sortField = '';
            sortField = $("#increStatusLog_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
                count += 1;
            }
            var sortType = '';
            sortType = $("#increStatusLog_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
                count += 1;
            }
            var record;
            record = $("#increStatusLog_record").val();

            if (isNaN(record)) {
                alert("顯示筆數請輸入數字!!");
                return false;
            }

            if (record == 0) {
                record = 100;
                args += "&record=" + record;
                count += 1;
            } else if (record <= 100 && record > 0) {
                args += "&record=" + record;
                count += 1;
            } else {
                alert("顯示筆數大於預設值100，僅顯示前100筆資訊");
                record = 100;
                args += "&record=" + record;
                count += 1;
            }
            var startTime = '';
            startTime = $("#incremtentalIndexStatusLog_startTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#incremtentalIndexStatusLog_endTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }
            var temp = '';
            temp = $("#increStatusLog_temp").prop('checked');
            if (temp != "" && temp != null) {
                args += "&temp=" + temp;
                count += 1;
            }
            //沒有下任何條件
            if (count <= 0) {
                args = "";
            } else if ((sortField == "" || sortField == null) && (sortType != "" && sortType != null)) {
                alert("未指定排序欄位!!");
                return false;
            } else if ((sortType == "" || sortType == null) && (sortField != "" && sortField != null)) {
                alert("未指定排序方式!!");
                return false;
            }
            return args;
        }

        $(document).ready(function () {
            $("#inline").fancybox({});
            $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});

            //傳送查詢條件
            $("#increStatusLog").click(function () {
                var args = getArgs_IncrementalStatusLog();

                $.ajax({
                    type: "POST",
                    url: '../index/incrementalIndexStatusLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#increStatusLog_resultScope").html(html);
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

    String[] dataToday = IncrementalIndexStatusDAO.todayIndex.toArray(new String[IncrementalIndexStatusDAO.todayIndex.size()]);
    String[] dataInstant = IncrementalIndexStatusDAO.instantIndex.toArray(new String[IncrementalIndexStatusDAO.instantIndex.size()]);

    String[] standardMachine = MachineTypeMappingDAO.standard.keySet().toArray(new String[MachineTypeMappingDAO.standard.size()]);
    String[] advancedMachine = MachineTypeMappingDAO.advanced.keySet().toArray(new String[MachineTypeMappingDAO.advanced.size()]);
    String[] staffOnlyMachine = MachineTypeMappingDAO.staffOnly.keySet().toArray(new String[MachineTypeMappingDAO.staffOnly.size()]);
    String[] instantMachine = MachineTypeMappingDAO.instant.keySet().toArray(new String[MachineTypeMappingDAO.instant.size()]);
%>
<body>
<table class="table table-hover">
    <tbody>
    <tr>
        <td>索引名稱(index_name)</td>
        <td colspan="2">
            <input id="increStatusLog_indexName" list="increStatusLog_indexName_list" placeholder="請選擇索引名稱">
            <datalist id="increStatusLog_indexName_list">
<%--                <option value="">請選擇索引名稱</option>--%>
                <%for (int i = 0; i < dataToday.length; i++) {%>
                    <option value="<%out.print(dataToday[i]);%>">
                <%}%>
                <%for (int i = 0; i < dataInstant.length; i++) {%>
                    <option value="<%out.print(dataInstant[i]);%>">
                <%}%>
            </datalist>
            &nbsp;&nbsp;&nbsp;<input type="checkbox" id="increStatusLog_temp" checked>&nbsp;排除Temp系列
        </td>
        </td>
    </tr>
    <tr>
        <td>機器名稱(machine_name)</td>

        <td colspan="2"><select id="increStatusLog_machineName">
            <option value="">請選擇機器</option>
            <option value="standard">外部(Standard)</option>
            <option value="advanced">分流(Advanced)</option>
            <option value="staff-only">內部(Staff-only)</option>
            <option value="instant">通報(Instant)</option>
            <%for (int i = 0; i < standardMachine.length; i++) {%>
            <option value="<%out.print(standardMachine[i]);%>"><%out.print(standardMachine[i]);%></option>
            <%}%>
            <%for (int i = 0; i < advancedMachine.length; i++) {%>
            <option value="<%out.print(advancedMachine[i]);%>"><%out.print(advancedMachine[i]);%></option>
            <%}%>
            <%for (int i = 0; i < staffOnlyMachine.length; i++) {%>
            <option value="<%out.print(staffOnlyMachine[i]);%>"><%out.print(staffOnlyMachine[i]);%></option>
            <%}%>
            <%for (int i = 0; i < instantMachine.length; i++) {%>
            <option value="<%out.print(instantMachine[i]);%>"><%out.print(instantMachine[i]);%></option>
            <%}%>

        </select></td>

    </tr>
    <tr>
        <td>任務狀態(status)</td>
        <td colspan="2"><select id="increStatusLog_status">
            <option value="">請選擇任務狀態</option>
            <option value="succeed">成功</option>
            <option value="fail">失敗</option>
            <option value="processing">處理中</option>
        </select></td>
    </tr>
    <tr>
        <td>任務類型(type)</td>
        <td colspan="2"><select id="increStatusLog_type">
            <option value="">請選擇任務類型</option>
            <option value="AddNewId">Searcher塞diff資料(AddNewId)</option>
            <option value="Indexing">Searcher作漸進索引(Indexing)</option>
            <option value="I_AddNewId">Indexer塞diff資料(I_AddNewId)</option>
            <option value="I_Indexing">Indexer作漸進索引(I_Indexing)</option>
        </select></td>
    </tr>
    <tr>

        <td>時間範圍(start_time)</td>
        <td colspan="2">
            <input type="text" style="height:30px" class="textInput" value="<%=startTime%>"
                   id="incrementalIndexStatusLog_startTimeField">
            &nbsp;&nbsp;~&nbsp;
            <input type="text" style="height:30px" class="textInput" value="<%=endTime%>"
                   id="incrementalIndexStatusLog_endTimeField"></td>
    </tr>
    <tr>
        <td>排序欄位</td>
        <td colspan="2"><select id="increStatusLog_sortField">
            <option value="start_time">任務開始時間</option>
            <option value="finish_time">任務結束時間</option>
            <option value="index_name">索引名稱</option>
            <option value="machine_name">機器名稱</option>
            <option value="last_content_create_time">最新發文時間</option>
            <option value="records">資料筆數</option>
            <option value="type">任務類型</option>
        </select>
            &nbsp;&nbsp; &nbsp; &nbsp;
            <select id="increStatusLog_sortType">
                <option value="desc">desc</option>
                <option value="asc">asc</option>
            </select></td>
    </tr>
    <tr>
        <td>顯示筆數</td>
        <td colspan="2"><input type="text" style=";height:30px" class="textInput" placeholder="請輸入顯示筆數..."
                               id="increStatusLog_record" value="100"></td>
    </tr>
    <tr>
    <tr>
        <td colspan="3"><a href="#" type="button" class="btn btn-primary" style="width:155px;height:30px;font-size:14px"
                           id="increStatusLog"><span>查詢</span></a></td>

    </tr>
    </tbody>
</table>

<%--<jsp:include page="../check/incrementalIndexStatus_result.jsp" />--%>
<div id="increStatusLog_resultScope"></div>

</body>
</html>
