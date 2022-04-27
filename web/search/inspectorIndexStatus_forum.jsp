<%--
  Created by IntelliJ IDEA.
  User: kueihenglu
  Date: 2018/8/23
  Time: 下午 02:59
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
        function getArgs_InspectorIndexStatus() {
            var args = '1=1';
            var count = 0;

            var indexName = '';
            indexName = $("#inspectorIndexStatus_indexName").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
                count += 1;
            }
            var site = '';
            site = $("#inspectorIndexStatus_site").val();
            if (site != "" && site != null) {
                args += "&site=" + site;
                count += 1;
            }
            var status = '';
            status = $("#inspectorIndexStatus_status").val();
            if (status != "" && status != null) {
                args += "&status=" + status;
                count += 1;
            }
            var indexType = '';
            indexType = $("#inspectorIndexStatus_indexType").val();
            if (indexType != "" && indexType != null) {
                args += "&indexType=" + indexType;
                count += 1;
            }
            var sortField = '';
            sortField = $("#inspectorIndexStatus_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
                count += 1;
            }
            var sortType = '';
            sortType = $("#inspectorIndexStatus_sortType").val();
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

        $(document).ready(function () {

            $("#inline").fancybox({});
            $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});


            //傳送查詢條件
            $("#selectInspectorIndexStatus").click(function () {
                var args = getArgs_InspectorIndexStatus();
                $.ajax({
                    type: "POST",
                    url: '../search/inspectorIndexStatus_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#inspectorIndexStatus_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });


            //檢查程式呼叫
            $("#startInspector").click(function () {
                if (confirm("確定要執行OpViewServiceInspector嗎?")) {
                    var args = "type=startInspectorBatch";
                    $.ajax({
                        type: "POST",
                        url: '../search/inspectorUpdate_execute_operate.jsp',
                        data: args,

                        success: function (html) {
                            if (args == '') {
                            } else
                                alert("已呼叫執行Inspector程序");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status === 0) return;
                            alert("關閉失敗,請稍後再試..");
                        }
                    });
                }
            });

        });
    </script>
</head>
<body>
<table class="table table-hover">
    <tbody class="topicTableContent">
    <tr>
        <td colspan="6"><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                           id="startInspector"><span>啟動系統檢測</span></a></td>

    </tr>
    <form>
        <tr>
            <td colspan="6" style="font-size:large;font-weight:bold">條件過濾</td>
        </tr>
        <tr>
            <td width="200">索引名稱(index_name)</td>
            <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder=""
                                   value="" id="inspectorIndexStatus_indexName">
            </td>
            <td>服務類型(site)</td>
            <td><select id="inspectorIndexStatus_site">
                <option value="">全部</option>
                <option value="standard">標準(Standard)</option>
                <option value="advanced">分流(Advanced)</option>
                <option value="staff-only">內部(Staff-only)</option>
                <option value="instant">通報(Instant)</option>
            </select></td>
        </tr>
        <tr>
            <td>索引狀態(status)</td>
            <td colspan="2"><select id="inspectorIndexStatus_status">
                <option value="">全部</option>
                <option value="Normal">良好</option>
                <option value="Error">異常</option>
            </select></td>
            <td>索引類型(index_type)</td>
            <td colspan="2"><select id="inspectorIndexStatus_indexType">
                <option value="">全部</option>
                <option value="synchronized">同步索引庫(synchronized)</option>
                <option value="non-synchronized">非同步索引庫(non-synchronized)</option>
                <option value="incremental">Today索引庫(today)</option>
                <option value="custom">客製索引庫(custom)</option>
            </select></td>
        </tr>

        <tr>
            <td>排序欄位</td>
            <td colspan="2"><select id="inspectorIndexStatus_sortField">
                <option value="status">索引狀況</option>
                <option value="index_name">索引名稱</option>
                <option value="site">服務類型</option>
                <option value="last_post_time">最新發文時間</option>
                <option value="update_time">最後檢查時間</option>
                <option value="index_type">任務類型</option>
                <option value="issue_type">錯誤類型</option>
                <option value="repair_status">修復狀況</option>
            </select>
            </td>
            <td colspan="2">
                <select id="inspectorIndexStatus_sortType">
                    <option value="asc">asc</option>
                    <option value="desc">desc</option>
                </select></td>
        </tr>
        <tr>
            <td colspan="6"><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                               id="selectInspectorIndexStatus"><span>查詢索引狀態</span></a></td>

        </tr>
    </form>
    </tbody>


</table>


<%--<table class="table table-hover">--%>
<%--<tbody class="topicTableContent">--%>
<%--<tr>--%>
<%--<th>索引名稱</th>--%>
<%--<th>機器名稱</th>--%>
<%--<th>最新發文時間</th>--%>
<%--<th>檢查時間</th>--%>
<%--<th>索引狀態</th>--%>
<%--<th>修復狀況</th>--%>
<%--</tr>--%>
<%--<tr>--%>
<%--<td>WH_Bbs_1%DATETIME%</td>--%>
<%--<td>swd-searcher01</td>--%>
<%--<td>2018-11-05 23:59:59.0</td>--%>
<%--<td>2018-11-06 11:30:21.0</td>--%>
<%--<td>Normal</td>--%>
<%--<td>None</td>--%>
<%--</tr>--%>
<%--<tr>--%>
<%--<td>WH_Bbs_1%DATETIME%</td>--%>
<%--<td>swd-searcher11</td>--%>
<%--<td>2018-11-05 23:59:59.0</td>--%>
<%--<td>2018-11-06 11:30:21.0</td>--%>
<%--<td>Normal</td>--%>
<%--<td>None</td>--%>
<%--</tr>--%>
<%--<tr>--%>
<%--<td>WH_Bbs_1%DATETIME%</td>--%>
<%--<td>swd-searcher15</td>--%>
<%--<td>None</td>--%>
<%--<td>2018-11-06 11:30:21.0</td>--%>
<%--<td style=color:#ed2421>Searcher Error</td>--%>
<%--<td>rebuilding</td>--%>
<%--</tr>--%>
<%--</tbody>--%>
<%--</table>--%>

<div id="inspectorIndexStatus_resultScope"></div>

</body>
</html>
