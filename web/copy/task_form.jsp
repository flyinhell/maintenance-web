<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
<%@ page import="com.sun.xml.internal.ws.api.ha.StickyFeature" %><%--
  Created by IntelliJ IDEA.
  User: johnnyhuang
  Date: 2018/3/7
  Time: 上午 09:14
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
        function getUnfinishedTask_args() {
            var args = 'type=unfinishedTask';
            return args;
        }

        function updateFailedTask_args(){
            var args = 'type=failedTask';
            return args;
        }

        //組查詢自訂的搜尋條件
        function getTaskUserDefined_args() {
            var args = 'type=definedCondition';
            var count = 0;

            var condition = '';
            condition = $("#task_UserDefined").val();
            if (condition != "" && condition != null) {
                args += "&condition=" + encodeURIComponent(condition);
//                args += "&condition=" + condition;
                count += 1;
            }

            //沒有下任何條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組索引名稱的搜尋條件
        function getTaskByIndexName_args() {
            var args = 'type=indexName';
            var count = 0;

            var indexName = '';
            indexName = $("#task_indexNameField").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
//                args += "&indexName=" + indexName;
                count += 1;
            }

            var sortField = '';
            sortField = $("#task_indexName_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#task_indexName_sortType").val();
            if (sortType != "" && sortType != null) {
                args += "&sortType=" + sortType;
            }
            //沒有下索引名稱條件
            if (count <= 0) {
                args = "";
            }

            return args;
        }

        //組目標機器的搜尋條件
        function getTaskByMachineName_args() {
            var args = 'type=machineName';
            var count = 0;

            var machineName = '';
            machineName = $("#task_machineNameField").val();
            if (machineName != "" && machineName != null) {
                args += "&machineName=" + machineName;
                count += 1;
            }

            var sortField = '';
            sortField = $("#task_machineName_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#task_machineName_sortType").val();
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
        function getTaskByActionFlag_args() {
            var args = 'type=actionFlag';
            var count = 0;

            var actionFlag = '';
            actionFlag = $("#task_actionFlagField").val();
            if (actionFlag != "" && actionFlag != null) {
                args += "&actionFlag=" + actionFlag;
                count += 1;
            }

            var sortField = '';
            sortField = $("#task_actionFlag_sortField").val();
            if (sortField != "" && sortField != null) {
                args += "&sortField=" + sortField;
            }
            var sortType = '';
            sortType = $("#task_actionFlag_sortType").val();
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
            $("#unfinishedTask").click(function () {
                var args = getUnfinishedTask_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/task_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#task_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });

            //重啟失敗複製任務
            $("#recopyFailedTask").click(function () {
                if(confirm("確定要重啟失敗任務嗎?")){
                    var args = updateFailedTask_args();
                    $.ajax({
                        type: "POST",
                        url: '../copy/task_result.jsp',
                        data: args,
                        success: function (html){
                            $("#task_resultScope").html(html);
                        },
                        error: function (jqXHR){
                            if(jqXHR.status === 0) return;
                            alert("搜尋失敗，請稍後再試..");
                        }
                    })
                }
            })

            //傳送查詢條件(自訂搜尋)
            $("#taskUserDefined").click(function () {
                var args = getTaskUserDefined_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/task_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#task_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(索引庫名稱搜尋)
            $("#taskIndexName").click(function () {
                var args = getTaskByIndexName_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/task_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#task_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(目標機器名稱搜尋)
            $("#taskMachineName").click(function () {
                var args = getTaskByMachineName_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/task_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#task_resultScope").html(html);
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("搜尋失敗,請稍後再試..");
                    }
                });
            });
            //傳送查詢條件(Cloner機器名稱搜尋)
            $("#taskActionFlag").click(function () {
                var args = getTaskByActionFlag_args();
                $.ajax({
                    type: "POST",
                    url: '../copy/task_result.jsp',
                    data: args,
                    success: function (html) {
                        $("#task_resultScope").html(html);
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
<body>

<table class="table table-hover">
    <tbody class="topicTableContent">
    <form>
        <tr>
            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                               id="unfinishedTask"><span>查詢未完成或失敗任務</span></a></td>
            <td colspan="5"><a href="#" type="button" style="width:155px;" class="btn btn-danger"
                               id="recopyFailedTask"><span>重啟失敗複製任務</span></a></td>
        </tr>
    </form>

    <form>
        <tr>
            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                   id="taskUserDefined"><span>自訂搜尋條件</span></a></td>
            <td>WHERE</td>
            <td colspan="4"><input type="text" style="width:480px;height:30px" class="textInput"
                                   placeholder="Ex：index_name like '%today%' and status ='fail' order by action_flag desc"
                                   id="task_UserDefined"></td>

        </tr>
    </form>

    <form>
        <tr>
            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary"
                   id="taskIndexName"><span>索引名稱搜尋</span></a></td>
            <td>WHERE index_name like</td>
            <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="索引庫名稱"
                       id="task_indexNameField"></td>
            <td>order by</td>
            <td><select style="width:140px;" id="task_indexName_sortField">
                <%--<option value="">排序欄位</option>--%>
                <option value="index_name">index_name</option>
                <option value="task_time">task_time</option>
                <option value="action_flag">action_flag</option>
                <option value="machine_name">machine_name</option>
                <option value="status">status</option>
            </select></td>
            <td><select style="width:70px;" id="task_indexName_sortType">
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
                   id="taskMachineName"><span>機器名稱搜尋</span></a></td>
            <td>WHERE machine_name =</td>
            <td><select style="width:140px;" id="task_machineNameField">
                <option value="">目標機器</option>
                <%for (int i = 0; i < dataIndexer.length; i++) {%>
                <option value="<%out.print(dataIndexer[i]);%>"><%out.print(dataIndexer[i]);%></option>
                <%}%>
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
            <td>order by</td>
            <td><select style="width:140px;" id="task_machineName_sortField">
                <option value="index_name">index_name</option>
                <option value="task_time">task_time</option>
                <option value="action_flag">action_flag</option>
                <option value="machine_name">machine_name</option>
                <option value="status">status</option>
            </select></td>
            <td><select style="width:70px;" id="task_machineName_sortType">
                <option value="desc">desc</option>
                <option value="asc">asc</option>
            </select></td>

        </tr>
    </form>

    <form>
        <tr>
            <td><a href="#" type="button" style="width:155px;" class="btn btn-primary" id="taskActionFlag"><span>Cloner機器搜尋</span></a>
            </td>
            <td>WHERE action_flag =</td>
            <td><select style="width:140px;" id="task_actionFlagField">
                <option value="">Cloner機器</option>
                <%for (int i = 0; i < dataIndexer.length; i++) {%>
                <option value="<%out.print(dataIndexer[i]);%>"><%out.print(dataIndexer[i]);%></option>
                <%}%>
                <%for (int i = 0; i < dataStandard.length; i++) {%>
                <option value="<%out.print(dataStandard[i]);%>"><%out.print(dataStandard[i]);%></option>
                <%}%>
            </select></td>
            <td>order by</td>
            <td><select style="width:140px;" id="task_actionFlag_sortField">
                <option value="index_name">index_name</option>
                <option value="task_time">task_time</option>
                <option value="action_flag">action_flag</option>
                <option value="machine_name">machine_name</option>
                <option value="status">status</option>
            </select></td>
            <td><select style="width:70px;" id="task_actionFlag_sortType">
                <option value="desc">desc</option>
                <option value="asc">asc</option>
            </select></td>
        </tr>
    </form>

    </tbody>
</table>


<div id="task_resultScope"></div>
</body>
</html>
