<%@ page import="java.util.Calendar" %>
<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/3
  Time: 下午 12:02
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
        })(jQuery)

        //組最近建立失敗索引log的查詢條件
        function getFailIndexLog_args() {
            var args = 'type=failIndexLog';
            var count = 0;
            var topNum = '';
            topNum = $("#indexLog_topNum").val();
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
        function getIndexLogUserDefined_args() {
            var args = 'type=definedCondition';
            var count = 0;

            var condition = '';
            condition = $("#indexLog_UserDefined").val();
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
        function getIndexLogByIndexName_args() {
            var args = 'type=indexName';
            var count = 0;

            var indexName = '';
            indexName = $("#indexLog_indexNameField").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
//        args += "&indexName=" + indexName;
                count += 1;
            }
            var startTime = '';
            startTime = $("#indexLog_indexName_startTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#indexLog_indexName_endTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }
            var sortField = '';
            sortField = $("#indexLog_indexName_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#indexLog_indexName_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組索引機器的搜尋條件
        function getIndexLogMachineName_args() {
            var args = 'type=machineName';
            var count = 0;

            var machineName = '';
            machineName = $("#indexLog_MachineNameField").val();
            if (machineName != "" && machineName != null) {
                args += "&machineName=" + machineName;
                count += 1;
            }
            var startTime = '';
            startTime = $("#indexLog_machineName_startTimeField").val();
            if (startTime != "" && startTime != null) {
                args += "&startTime=" + startTime;
                count += 1;
            }
            var endTime = '';
            endTime = $("#indexLog_machineName_endTimeField").val();
            if (endTime != "" && endTime != null) {
                args += "&endTime=" + endTime;
                count += 1;
            }

            var sortField = '';
            sortField = $("#indexLog_machineName_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }

            var sortType = '';
            sortType = $("#indexLog_machineName_sortType").val();
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
            $("#failIndexLog").click(function () {
                var args = getFailIndexLog_args();
                $.ajax({
                    type: "POST",
                    url: '../index/indexLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#indexLog_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(自訂搜尋)
            $("#indexLogUserDefined").click(function () {
                var args = getIndexLogUserDefined_args();
                $.ajax({
                    type: "POST",
                    url: '../index/indexLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#indexLog_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(索引庫名稱搜尋)
            $("#indexLogIndexName").click(function () {
                var args = getIndexLogByIndexName_args();
                $.ajax({
                    type: "POST",
                    url: '../index/indexLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#indexLog_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(索引機器名稱搜尋)
            $("#indexLogMachineName").click(function () {
                var args = getIndexLogMachineName_args();
                $.ajax({
                    type: "POST",
                    url: '../index/indexLog_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#indexLog_resultScope").html(html);
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
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="failIndexLog"><span>查詢最近失敗任務紀錄</span></a></td>

                <td>top</td>
                <td colspan="4"><select style="width:140px;" id="indexLog_topNum">
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
                       id="indexLogUserDefined"><span>自訂搜尋條件</span></a></td>
                <td>WHERE</td>
                <td colspan="4"><input type="text" style="width:480px;height:30px" class="textInput"
                                       placeholder="Ex：indexdb like '%today%' and status ='fail' order by start_time desc"
                                       id="indexLog_UserDefined"></td>

            </tr>
        </form>

        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexLogIndexName"><span>索引庫名稱搜尋</span></a></td>
                <td>WHERE indexdb like</td>
                <td colspan="3"><input type="text" style="width:140px;height:30px" class="textInput" placeholder="索引庫名稱"
                                       id="indexLog_indexNameField"></td>
            </tr>
            <tr>
                <td></td>
                <td>AND start_time >=</td>
                <td>
                    <input type="text" style="width:140px;height:30px" class="textInput" value="<%=startTime%>"
                           id="indexLog_indexName_startTimeField"></td>
                </td>
                <td>AND start_time <</td>
                <td>
                    <input type="text" style="width:140px;height:30px" class="textInput" value="<%=endTime%>"
                           id="indexLog_indexName_endTimeField"></td>
            </tr>
            <tr>
                <td></td>
                <td>order by</td>
                <td><select style="width:140px;" id="indexLog_indexName_sortField">
                    <%--<option value="">排序欄位</option>--%>
                    <option value="start_time">start_time</option>
                    <option value="finish_time">finish_time</option>
                    <option value="indexdb">indexdb</option>
                    <option value="host">host</option>
                    <option value="status">status</option>
                </select></td>
                <td colspan="2"><select style="width:70px;" id="indexLog_indexName_sortType">
                    <option value="desc">desc</option>
                    <option value="asc">asc</option>
                </select></td>
            </tr>
        </form>

        <form>
            <tr>
                <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                       id="indexLogMachineName"><span>索引機器名稱搜尋</span></a></td>
                <td>WHERE host =</td>
                <td colspan="3"><select style="width:140px;" id="indexLog_MachineNameField">
                    <option value="">索引機器</option>
                    <%for (int i = 0; i < dataIndexer.length; i++) {%>
                    <option value="<%out.print(dataIndexer[i]);%>"><%out.print(dataIndexer[i]);%></option>
                    <%}%>
                </select></td>
            </tr>
            <tr>
                <td></td>
                <td>AND start_time >=</td>
                <td>
                    <input type="text" style="width:140px;height:30px" class="textInput" value="<%=startTime%>"
                           id="indexLog_machineName_startTimeField"></td>
                </td>
                <td>AND start_time <</td>
                <td>
                    <input type="text" style="width:140px;height:30px" class="textInput" value="<%=endTime%>"
                           id="indexLog_machineName_endTimeField"></td>
            </tr>
            <tr>
                <td></td>
                <td>order by</td>
                <td><select style="width:140px;" id="indexLog_machineName_sortField">
                    <option value="start_time">start_time</option>
                    <option value="finish_time">finish_time</option>
                    <option value="indexdb">indexdb</option>
                    <option value="host">host</option>
                    <option value="status">status</option>
                </select></td>
                <td colspan="2"><select style="width:70px;" id="indexLog_machineName_sortType">
                    <option value="desc">desc</option>
                    <option value="asc">asc</option>
                </select></td>

            </tr>
        </form>

        </tbody>
    </table>
</form>

<div id="indexLog_resultScope"></div>

</body>
</html>

