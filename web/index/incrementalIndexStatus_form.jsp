<%@ page import="java.util.Calendar" %>
<%@ page import="com.eland.dao.IncrementalIndexStatusDAO" %>
<%@ page import="com.eland.pojo.model.IncrementalIndexStatusEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
<%@ page import="com.eland.pojo.model.MachineTypeMappingEntity" %>
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
        function getArgs_IncrementalStatus() {
            var args = 'actionType=select';
            var count = 0;

            var indexName = '';
            indexName = $("#increStatus_indexName").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + indexName;
                count += 1;
            }

            var machineName = '';
            machineName = $("#increStatus_machineName").val();
            if (machineName != "" && machineName != null) {
                args += "&machineName=" + machineName;
                count += 1;
            }
            var status = '';
            status = $("#increStatus_status").val();
            if (status != "" && status != null) {
                args += "&status=" + status;
                count += 1;
            }
            var type = '';
            type = $("#increStatus_type").val();
            if (type != "" && type != null) {
                args += "&type=" + type;
                count += 1;
            }
            var sortField = '';
            sortField = $("#increStatus_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
                count += 1;
            }
            var sortType = '';
            sortType = $("#increStatus_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
                count += 1;
            }
            var startTime = '';
            startTime = $("#incrementalIndexStatus_startTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#incrementalIndexStatus_endTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }
            var temp = '';
            temp = $("#increStatus_temp").prop('checked');
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

        //修改狀態的條件
        function getArgs_IncrementalStatusUpdate() {
            var args = 'actionType=update';
            var count = 0;

            var indexName = '';
            indexName = $("#increStatus_indexName").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + indexName;
                count += 1;
            } else {
                alert("請指定索引名稱");
            }

            var machineName = '';
            machineName = $("#increStatus_machineName").val();
            if (machineName != "" && machineName != null) {
                args += "&machineName=" + machineName;
                count += 1;
            } else {
                alert("請指定機器名稱");
            }

            var temp = '';
            temp = $("#increStatus_temp").prop('checked');
            if (temp != "" && temp != null) {
                args += "&temp=" + temp;
                count += 1;
            }
            var type = '';
            type = $("#increStatus_type").val();
            if (type != "" && type != null) {
                args += "&type=" + type;
                count += 1;
            }else{
                alert("請指定任務類型");
            }
            //沒有下任何條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        $(document).ready(function () {

            $("#inline").fancybox({});
            $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});

            //傳送查詢條件
            $("#increStatus").click(function () {
                var args = getArgs_IncrementalStatus();

                $.ajax({
                    type: "POST",
                    url: '../index/incrementalIndexStatus_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#increStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });

            $("#increStatus_update").click(function () {
                if(confirm("確定要修改狀態為Fail嗎?")){
                    var args = getArgs_IncrementalStatusUpdate();
                    $.ajax({
                        type: "POST",
                        url: '../index/incrementalIndexStatus_result.jsp',
                        data: args,
                        success: function (html) {
                            $("#increStatus_resultScope").html(html);
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("修改失敗,請稍後再試..");
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
        <td width="200">索引名稱(index_name)</td>
        <td colspan="2">
            <input id="increStatus_indexName" list="increStatus_indexName_list" placeholder="請選擇索引名稱">
            <datalist id="increStatus_indexName_list">
                <%--                <option value="">請選擇索引名稱</option>--%>
                <%for (int i = 0; i < dataToday.length; i++) {%>
                <option value="<%out.print(dataToday[i]);%>">
                        <%}%>
                <%for (int i = 0; i < dataInstant.length; i++) {%>
                <option value="<%out.print(dataInstant[i]);%>">
                        <%}%>
            </datalist>
            &nbsp;&nbsp;&nbsp; <input type="checkbox" id="increStatus_temp" checked>&nbsp;排除Temp系列
        </td>
        </td>
    </tr>
    <tr>
        <td>機器名稱(machine_name)</td>
        <td colspan="2"><select id="increStatus_machineName">
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
        <td colspan="2"><select id="increStatus_status">
            <option value="">請選擇任務狀態</option>
            <option value="succeed">成功</option>
            <option value="fail">失敗</option>
            <option value="processing">處理中</option>
        </select></td>
    </tr>
    <tr>
        <td>任務類型(type)</td>
        <td colspan="2"><select id="increStatus_type">
            <option value="Indexing">Searcher作漸進索引(Indexing)</option>
            <option value="AddNewId">Searcher塞diff資料(AddNewId)</option>
            <option value="I_AddNewId">Indexer塞diff資料(I_AddNewId)</option>
            <option value="I_Indexing">Indexer作漸進索引(I_Indexing)</option>
            <option value="">全部</option>
        </select></td>
    </tr>
    <tr>

        <td>時間範圍(start_time)</td>
        <td colspan="2">
            <input type="text" style="height:30px" class="textInput" value="<%=startTime%>"
                   id="incrementalIndexStatus_startTimeField">
            &nbsp;&nbsp;~&nbsp;
            <input type="text" style="height:30px" class="textInput" value="<%=endTime%>"
                   id="incrementalIndexStatus_endTimeField"></td>

    </tr>
    <tr>
        <td>排序欄位</td>
        <td colspan="2"><select id="increStatus_sortField">
            <option value="last_content_create_time">最新發文時間</option>
            <option value="index_name">索引名稱</option>
            <option value="machine_name">機器名稱</option>
            <option value="start_time">任務開始時間</option>
            <option value="finish_time">任務結束時間</option>
            <option value="records">資料筆數</option>
            <option value="type">任務類型</option>
        </select>
            &nbsp;&nbsp; &nbsp; &nbsp;
            <select id="increStatus_sortType">
                <option value="desc">desc</option>
                <option value="asc">asc</option>
            </select></td>
    </tr>


    <tr>
        <%--<td><input type="button" class="btn btn-primary" onclick="doRequestUsingGET()" value="查詢"></td>--%>
        <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:30px;font-size:14px"
               id="increStatus"><span>查詢</span></a></td>
        <td><a href="#" type="button" class="btn btn-danger" style="width:155px;height:30px;font-size:14px"
               id="increStatus_update"><span>修改狀態為Fail</span></a></td>
    </tr>
    </tbody>
</table>

<%--<jsp:include page="../check/incrementalIndexStatus_result.jsp" />--%>
<div id="increStatus_resultScope"></div>

</body>
</html>
