<%--
  Created by IntelliJ IDEA.
  User: kueihenglu
  Date: 2018/8/23
  Time: 下午 09:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        $("#selectMachineConfig").click(function () {
            $.ajax({
                type: "POST",
                url: '../monthly/machineUpdate_result.jsp',
                success: function (html) {
                    $("#machineUpdate_resultScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        //新增
        $("#machineUpdate_insert").click(function () {
            var args = "type=insert";
            $.ajax({
                type: "POST",
                url: '../monthly/machineUpdate_operate.jsp',
                data: args,
                success: function (html) {
                    $("#machineUpdate_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

        //刪除
        $("#machineUpdate_delete").click(function () {
            var args = getDeleteMachineConfig_args();
            $.ajax({
                type: "POST",
                url: '../monthly/machineUpdate_operate.jsp',
                data: args,
                success: function (html) {
                    $("#machineUpdate_operateScope").html(html);
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("搜尋失敗,請稍後再試..");
                }
            });
        });

    });


    //        function getInsertMachineConfig_args() {
    //            var args = 'type=insert';
    //            var count = 0;
    //
    //            var machineName = '';
    //            machineName = $("#machineUpdate_machineNameField").val();
    //            if (machineName != "" && machineName != null) {
    //                args += "&machineName=" + encodeURIComponent(machineName);
    //                count += 1;
    //            }
    //
    //            //沒有下索引名稱條件
    //            if (count <= 0) {
    //                args = "";
    //            }
    //            return args;
    //        }

    function getDeleteMachineConfig_args() {
        var args = 'type=delete';
        var count = 0;

        var machineName = '';
        machineName = $("#machineUpdate_machineNameField").val();
        if (machineName != "" && machineName != null) {
            args += "&machineName=" + encodeURIComponent(machineName);
            count += 1;
        }

        //沒有下索引名稱條件
        if (count <= 0) {
            args = "";
        }
        return args;
    }
</script>


<body>
<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="machineUpdate_insert"><span>新增機器</span></a></td>

            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="machineUpdate_delete"><span>刪除機器</span></a></td>


            <td colspan="5"><input type="text" style="width:180px;height:30px" class="textInput" placeholder="機器名稱"
                                   id="machineUpdate_machineNameField"></td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
            <td>&nbsp&nbsp&nbsp</td>
        </tr>
        </tbody>
    </table>
    <div id="machineUpdate_operateScope"></div>
</form>


<form>
    <table class="table table-hover">
        <tbody class="topicTableContent">
        <tr>
            <td><a href="#" type="button" class="btn btn-primary" style="width:155px;height:25px;font-size:14px" id="selectMachineConfig"><span>列出機器清單</span></a></td>
        </tr>

        </tbody>

    </table>
    <div id="machineUpdate_resultScope"></div>
</form>


</body>
</html>
