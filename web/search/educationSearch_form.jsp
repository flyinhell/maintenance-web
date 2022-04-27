<%--
  Created by IntelliJ IDEA.
  User: kueihenglu
  Date: 2018/4/2
  Time: 下午 06:17
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
        function getArgs_EducationMachineStatus() {
            var args = '1=1';
            var count = 0;

            var machineName = '';
            machineName = $("#educationMachineStatus_machineName").val();
            if (machineName != "" && machineName != null) {
                args += "&machineName=" + machineName;
                count += 1;
            }
            var ipAddress = '';
            ipAddress = $("#educationMachineStatus_ipAddress").val();
            if (ipAddress != "" && ipAddress != null) {
                args += "&ipAddress=" + ipAddress;
                count += 1;
            }
            var type = '';
            type = $("#educationMachineStatus_type").val();
            if (type != "" && type != null) {
                args += "&type=" + type;
                count += 1;
            }
            var site = 'Education';
            args += "&site=" + site;
            count += 1;
            var status = '';
            status = $("#educationMachineStatus_status").val();
            if (status != "" && status != null) {
                args += "&status=" + status;
                count += 1;
            }
            var sortField = '';
            sortField = $("#educationMachineStatus_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
                count += 1;
            }
            var sortType = '';
            sortType = $("#educationMachineStatus_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
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

        function getArgs_StartEducationTDS() {
            var args = 'BatchPath=startEducationBatch';

            return args;
        }

        function getArgs_StopEducationTDS() {
            var args = 'BatchPath=stopEducationBatch';

            return args;
        }

        $(document).ready(function () {

            $("#inline").fancybox({});
            $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});

            //傳送查詢條件
            $("#educationMachineStatus").click(function () {
                var args = getArgs_EducationMachineStatus();

                $.ajax({
                    type: "POST",
                    url: '../search/educationSearch_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#educationMachineStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送開啟 TDS 批次檔
            $("#startEducationTDS").click(function () {
                var args = getArgs_StartEducationTDS();
                if (confirm("確定要啟動TDS嗎?")) {
                    $.ajax({
                        type: "POST",
                        url: '../ExecuteBatchFile',
                        data: args,
                        success: function (html) {
                            $("#startEducationTDS_resultScope").html(html);
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("搜尋失敗,請稍後再試..");
                        }
                    });
                } else {

                }
            });
            //傳送關閉 TDS 批次檔
            $("#stopEducationTDS").click(function () {
                var args = getArgs_StopEducationTDS();
                if (confirm("確定要關閉TDS嗎?")) {
                    $.ajax({
                        type: "POST",
                        url: '../ExecuteBatchFile',
                        data: args,
                        success: function (html) {
                            $("#stopEducationTDS_resultScope").html(html);
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("搜尋失敗,請稍後再試..");
                        }
                    });
                } else {
                }
            });
        });
    </script>
</head>
<body>
<input type="button" class="btn btn-primary" style="width:155px;height:30px;font-size:14px" id="startEducationTDS"
       value="啟動">
&nbsp;&nbsp;&nbsp;
<input type="button" class="btn btn-danger" style="width:155px;height:30px;font-size:14px" id="stopEducationTDS"
       value="關閉">
<table class="table table-hover">
    <tbody class="topicTableContent">
    <tr>
        <td>機器名稱(machine_name)</td>
        <td><input type="text" style=";height:30px" class="textInput" placeholder="請輸入機器名稱..."
                   id="educationMachineStatus_machineName"></td>
    </tr>
    <tr>
        <td>IP位置(ip_address)</td>
        <td><input type="text" style=";height:30px" class="textInput" placeholder="請輸入機器 IP Address..."
                   id="educationMachineStatus_ipAddress"></td>
    </tr>
    <tr>
        <td>服務類型(type)</td>
        <td><select id="educationMachineStatus_type">
            <option value="">請選擇服務類型</option>
            <option value="DS">DS</option>
            <option value="SS">SS</option>
        </select></td>
    </tr>
    <tr>
        <td>系統狀態(status)</td>
        <td><select id="educationMachineStatus_status">
            <option value="">請選擇系統狀態</option>
            <option value="online">online</option>
            <option value="offline">offline</option>
        </select></td>
    </tr>
    <tr>
        <td>排序欄位</td>
        <td><select id="educationMachineStatus_sortField">
            <option value="">請選擇排序欄位</option>
            <option value="machine_name">機器名稱</option>
            <option value="ip_address">IP位址</option>
            <option value="machine_type">服務類型</option>
            <option value="status">系統狀態</option>
            <option value="start_time">開始時間</option>
            <option value="update_time">更新時間</option>
        </select></td>
    </tr>
    <tr>
        <td>排序方式</td>
        <td><select id="educationMachineStatus_sortType">
            <option value="">請選擇排序方式</option>
            <option value="desc">遞減排序(desc)</option>
            <option value="asc">遞增排序(asc)</option>
        </select></td>
    </tr>
    <tr>
        <%--<td><input type="button" class="btn btn-primary" onclick="doRequestUsingGET()" value="查詢"></td>--%>
        <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:30px;font-size:14px"
               id="educationMachineStatus"><span>查詢</span></a></td>
        <td></td>
    </tr>
    </tbody>
</table>
<div id="educationMachineStatus_resultScope"></div>
</body>
</html>
