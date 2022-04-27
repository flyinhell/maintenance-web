<%@ page import="com.eland.dao.ViewClonerStatusDAO" %>
<%@ page import="com.eland.pojo.model.VwClonerStatusEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eland.cloner.CallCheckTools" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
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
    <title></title>
</head>
<script>
    (function ($) {
        $(document).ready(function () {
            $(".COMPtheme, .COMPcenter, #scrollbar1").mCustomScrollbar({
                theme: "dark"
            });
        });
    })(jQuery);

    $(document).ready(function () {

        $("#inline").fancybox({});
        $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
        $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});

        //傳送查詢條件
        $("#cloner").click(function () {
            $.ajax({
                type: "POST",
                url: '../copy/copy_result.jsp',
                success: function (html) {
                    $("#cloner_resultScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });
        //檢查工具呼叫
        $("#check_cloner").click(function () {

            var args = check();
            $.ajax({
                type: "POST",
                url: '../copy/copy_operate.jsp',
                data: args,
                success: function (html) {
                    if (args == '') {
                    } else
                        alert("啟動完成，請確認狀況");
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("檢查失敗,請稍後再試..");
                }
            });

//            alert("檢查cloner狀況 : "+machineName);

        });
        //強制關閉工具呼叫
        $("#kill_cloner").click(function () {
//            alert("強制關閉cloner : "+machineName);
            if (confirm("確定要強制關閉(kill)複製程式嗎?")) {
                var args = kill();
                $.ajax({
                    type: "POST",
                    url: '../copy/copy_operate.jsp',
                    data: args,
                    success: function (html) {
                        if (args == '') {
                        } else
                            alert("已呼叫執行kill程序");
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("執行失敗,請稍後再試..");
                    }
                });
            } else {
            }
        });
        //啟動工具呼叫
        $("#startup_cloner").click(function () {
//            alert("啟動cloner : "+machineName);
            var args = startup();
            $.ajax({
                type: "POST",
                url: '../copy/copy_operate.jsp',
                data: args,
                success: function (html) {
                    if (args == '') {
                    } else
                        alert("已呼叫執行cloner啟動程序");

                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("啟動失敗,請稍後再試..");
                }
            });
        });
        //關閉工具呼叫
        $("#close_cloner").click(function () {
            var args = close();
            $.ajax({
                type: "POST",
                url: '../copy/copy_operate.jsp',
                data: args,

                success: function (html) {
                    if (args == '') {
                    } else
                        alert("已呼叫執行close程序");
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("關閉失敗,請稍後再試..");
                }
            });
        });
        //alert($("#cloner_checkField").val());
        //   check();


    });


</script>

<script>
    function check() {
        var args = 'type=check';
        var count = 0;
        var machineName = '';
        machineName = $("#cloner_checkField").val();
        if (machineName != "" && machineName != null) {
            args += "&machineName=" + machineName;
            count += 1;
        }
        //沒有下任何條件
        if (count <= 0) {
            args = "";
            alert("請選擇機器");

        }

        return args;
    }

    function startup() {
        var args = 'type=startup';
        var count = 0;
        var machineName = '';
        machineName = $("#cloner_startupField").val();
        if (machineName != "" && machineName != null) {
            args += "&machineName=" + machineName;
            count += 1;
        }
        //沒有下任何條件
        if (count <= 0) {
            args = "";
            alert("請選擇機器");

        }

        return args;
    }

    function close() {
        var args = 'type=close';
        var count = 0;
        var machineName = '';
        machineName = $("#cloner_closeField").val();
        if (machineName != "" && machineName != null) {
            args += "&machineName=" + machineName;
            count += 1;
        }
        //沒有下任何條件
        if (count <= 0) {
            args = "";
            alert("請選擇機器");

        }

        return args;
    }

    function kill() {
        var args = 'type=kill';
        var count = 0;
        var machineName = '';
        machineName = $("#cloner_killField").val();
        if (machineName != "" && machineName != null) {
            args += "&machineName=" + machineName;
            count += 1;
        }
        //沒有下任何條件
        if (count <= 0) {
            args = "";
            alert("請選擇機器");

        }

        return args;
    }

</script>
<body>


<table class="table table-hover">
    <tbody class="topicTableContent">
    <tr>
        <%
            String[] dataIndexer = MachineTypeMappingDAO.indexer.keySet().toArray(new String[MachineTypeMappingDAO.indexer.size()]);
            String[] dataStandard = MachineTypeMappingDAO.standard.keySet().toArray(new String[MachineTypeMappingDAO.standard.size()]);
        %>
        <form>
            <td>
                <input type="button" class="btn btn-primary" onclick="return alert('啟動檢查程式')"
                       style="width:155px;height:25px;font-size:14px" value="確認運作狀況" id="check_cloner">
            </td>

            <td><select id="cloner_checkField">
                <option value="">請選擇機器名稱</option>
                <option value="all">全部Cloner機器</option>
                <option value="allIndexer">全部Indexer</option>
                <%for (int i = 0; i < dataIndexer.length; i++) {%>
                <option value="<%out.print(dataIndexer[i]);%>"><%out.print(dataIndexer[i]);%></option>
                <%}%>
                <option value="allSearcher">全部Searcher</option>
                <%for (int i = 0; i < dataStandard.length; i++) {%>
                <option value="<%out.print(dataStandard[i]);%>"><%out.print(dataStandard[i]);%></option>
                <%}%>
            </select>
            </td>
        </form>
        <form>
            <td>
                <input type="button" class="btn btn-danger" style="width:155px;height:25px;font-size:14px"
                       value="強制關閉程式" id="kill_cloner">

            </td>
            <td><select id="cloner_killField">
                <option value="">請選擇機器名稱</option>
                <%for (int i = 0; i < dataIndexer.length; i++) {%>
                <option value="<%out.print(dataIndexer[i]);%>"><%out.print(dataIndexer[i]);%></option>
                <%}%>
                <%for (int i = 0; i < dataStandard.length; i++) {%>
                <option value="<%out.print(dataStandard[i]);%>"><%out.print(dataStandard[i]);%></option>
                <%}%>
            </select>
            </td>
        </form>
    </tr>
    <tr>
        <form>
            <td>
                <input type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px"
                       value="啟動複製程式" id="startup_cloner">
            </td>
            <td><select id="cloner_startupField">
                <option value="">請選擇機器名稱</option>
                <option value="all">全部Cloner機器</option>
                <option value="allIndexer">全部Indexer</option>
                <%for (int i = 0; i < dataIndexer.length; i++) {%>
                <option value="<%out.print(dataIndexer[i]);%>"><%out.print(dataIndexer[i]);%></option>
                <%}%>
                <option value="allSearcher">全部Searcher</option>
                <%for (int i = 0; i < dataStandard.length; i++) {%>
                <option value="<%out.print(dataStandard[i]);%>"><%out.print(dataStandard[i]);%></option>
                <%}%>
            </select>
            </td>
        </form>
        <form>
            <td>
                <input type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px"
                       value="關閉複製程式" id="close_cloner">
            </td>
            <td>
                <select id="cloner_closeField">
                    <option value="">請選擇機器名稱</option>
                    <option value="all">全部Cloner機器</option>
                    <option value="allIndexer">全部Indexer</option>
                    <%for (int i = 0; i < dataIndexer.length; i++) {%>
                    <option value="<%out.print(dataIndexer[i]);%>"><%out.print(dataIndexer[i]);%></option>
                    <%}%>
                    <option value="allSearcher">全部Searcher</option>
                    <%for (int i = 0; i < dataStandard.length; i++) {%>
                    <option value="<%out.print(dataStandard[i]);%>"><%out.print(dataStandard[i]);%></option>
                    <%}%>
                </select>
            </td>
        </form>
    </tr>

    </tbody>
</table>

<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px"
                   id="cloner"><span>Cloner狀況查詢</span></a></td>
        </tr>
        </tbody>
    </table>
</form>
<div id="cloner_resultScope"></div>

</body>
</html>
