<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.pojo.model.MonthyTaskConfigEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/8/30
  Time: 下午 06:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../include/util.jsp" %>
<head>
    <script>
        (function ($) {
            $(document).ready(function () {
                $(".COMPtheme, .COMPcenter, #scrollbar1").mCustomScrollbar({
                    theme: "dark"
                });
            });
        })(jQuery);

        //修改
        function update_MonthyTaskConfigView(id) {
            var args = get_updateMonthyTaskConfigView(id);
            $.ajax({
                type: "POST",
                url: '../monthly/monthlyUpdate_execute_operate.jsp',
                data: args,
                success: function (html) {
                    alert("更新完成");
                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("更新失敗");
                }
            });
        }

        function get_updateMonthyTaskConfigView(id) {
            var args = 'type=updateTaskConfigView&id=' + id;
            var count = 0;
            var viewSchema = '';

            viewSchema = $("#monthlyUpdate_viewSchemaField").val();
            if (viewSchema != "" && viewSchema != null) {
                args += "&viewSchema=" + encodeURIComponent(viewSchema);
                count += 1;
            }
            //沒有下任何條件
            if (count <= 0) {
                args = "";
                alert("請填寫內容");
            }
            return args;
        }


    </script>


</head>

<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String id = reqWrapper.getParameter("id");
    request.setAttribute("id", id);

    MonthyIndexConfigDAO monthyIndexConfigDAO = new MonthyIndexConfigDAO();
    List<MonthyTaskConfigEntity> monthyTaskConfigList = new LinkedList<MonthyTaskConfigEntity>();
    try {
        monthyTaskConfigList = monthyIndexConfigDAO.selectMonthyTaskConfigById(id);

    } catch (Exception e) {
        logger.error(e.getMessage(), e);
    }
    request.setAttribute("monthyTaskConfig", monthyTaskConfigList.get(0));


%>
<div>
    <table class="table table-hover">
        <tbody class="topicTableContent">

        <tr>
            <td>
                <textarea id="monthlyUpdate_viewSchemaField" name="monthlyUpdate_viewSchemaField"
                          style="width:600px;height:300px">${monthyTaskConfig.viewSchema}</textarea>
            </td>
        </tr>
        <tr>
            <td>
                <input onclick="update_MonthyTaskConfigView(${id})" type="button" class="btn btn-primary"
                       style="width:120px;height:30px;font-size:14px" value="更新">
                &nbsp;&nbsp;&nbsp;
                <a href="javascript:$.fn.colorbox.close();" class="btnstyleC"><span>離開</span></a>
            </td>
        </tr>
        <tr>
            <td>
            </td>

        </tr>

        </tbody>
    </table>

</div>
