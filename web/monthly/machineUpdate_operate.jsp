<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.CustomIndexDAO" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.pojo.model.MonthyTaskConfigEntity" %>
<%@ page import="com.eland.dao.MachineTypeMappingDAO" %>
<%@ page import="com.eland.pojo.model.MachineTypeMappingEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/11
  Time: 上午 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
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

        });

        //刪除
        function delete_MachineType(id) {
            var args = "type=delete&id=" + id;
            var del = confirm("確認要刪除索引設定嗎?");
            if (del == true) {
                $.ajax({
                    type: "POST",
                    url: '../monthly/machineUpdate_execute_operate.jsp',
                    data: args,
                    success: function (html) {
                        alert("刪除完成");
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("刪除失敗");
                    }
                });
            } else {
            }
        }

        //新增
        $("#insert_MachineType").click(function () {
            var args = get_insertMachine();
            $.ajax({
                type: "POST",
                url: '../monthly/machineUpdate_execute_operate.jsp',
                data: args,
                success: function (html) {
                    alert("新增成功");
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("更新失敗");
                }
            });
        });

        function get_insertMachine() {
            var args = 'type=insert';
            var count = 0;
            var machineName = '';
            var machineType = '';
            var ipAddress = '';
            machineName = $("#machineInsert_machineNameField").val();
            if (machineName != "" && machineName != null) {
                args += "&machineName=" + encodeURIComponent(machineName);
                count += 1;
            }
            machineType = $("#machineInsert_machineTypeField").val();
            if (machineType != "" && machineType != null) {
                args += "&machineType=" + machineType;
                count += 1;
            }
            ipAddress = $("#machineInsert_ipAddressField").val();
            if (ipAddress != "" && ipAddress != null) {
                args += "&ipAddress=" + ipAddress;
                count += 1;
            }
            //沒有下任何條件
            if (count <= 2) {
                args = "";
                alert("請填寫內容");
            }
            return args;
        }

    </script>

    <title></title>
</head>
<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String type = reqWrapper.getParameter("type");
    String machineName = "";
    int totalSize = 0;      //資料總筆數
    MachineTypeMappingDAO machineTypeMappingDAO = new MachineTypeMappingDAO();
    List<MachineTypeMappingEntity> machineTypeMappingList = new LinkedList<MachineTypeMappingEntity>();
    try {
        if (type.equals("insert")) {
            request.setAttribute("type", type);
        } else if (type.equals("delete")) {
            machineName = new String(request.getParameter("machineName").getBytes("ISO8859-1"), "UTF-8");
            machineTypeMappingList = machineTypeMappingDAO.selectMachineTypeMapping(machineName);
            totalSize = machineTypeMappingList.size();
            request.setAttribute("type", type);
            request.setAttribute("machineTypeMappingList", machineTypeMappingList);
            request.setAttribute("totalSize", totalSize);
        }
    } catch (Exception e) {
        logger.error(e.getMessage(), e);
    }

%>
<body>
<c:choose>
    <c:when test="${type=='insert'}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th>機器名稱<br>(machine_name)</th>
            <th>機器類型<br>(machine_type)</th>
            <th>機器IP位置<br>(ip_address)</th>
            <tr>
                <td><input type="text" style="width:140px;height:30px" class="textInput"
                           id="machineInsert_machineNameField"></td>
                <td><input type="text" style="width:140px;height:30px" class="textInput"
                           id="machineInsert_machineTypeField"></td>
                <td><input type="text" style="width:140px;height:30px" class="textInput"
                           id="machineInsert_ipAddressField"></td>
            </tr>
            <tr>
                <td colspan="3">
                    <input type="button" class="btn btn-info" style="width:60px;height:25px;font-size:12px"
                           value="新增" id="insert_MachineType">
                </td>
            </tr>
            </tbody>
        </table>
    </c:when>
    <c:when test="${type=='delete'&&totalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>機器名稱<br>(machine_name)</th>
            <th>機器類型<br>(machine_type)</th>
            <th>機器IP位置<br>(ip_address)</th>
            <c:forEach items="${machineTypeMappingList}" var="machineTypeMappingList" begin="0" end="${totalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-danger" style="width:60px;height:25px;font-size:12px"
                               value="刪除"
                               onclick="delete_MachineType(${machineTypeMappingList.id})">
                    </td>
                    <td>${machineTypeMappingList.machineName}</td>
                    <td>${machineTypeMappingList.machineType}</td>
                    <td>${machineTypeMappingList.ipAddress}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <strong>找不到符合的資料</strong>
    </c:otherwise>
</c:choose>
</body>
</html>