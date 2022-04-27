<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.IndexInspectorConfigDAO" %>
<%@ page import="com.eland.pojo.model.IndexInspectorConfigEntity" %>
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
        function update_IndexInspectorConfigSql(id) {
            var args = get_updateIndexInspectorConfigSql(id);
            $.ajax({
                type: "POST",
                url: '../search/inspectorUpdate_execute_operate.jsp',
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

        function get_updateIndexInspectorConfigSql(id) {
            var args = 'type=updateIndexInspectorConfigSql&id=' + id;
            var count = 0;
            var checkImmediateSql = '';

            checkImmediateSql = $("#inspectorUpdate_checkImmediateSqlField").val();
            if (checkImmediateSql != "" && checkImmediateSql != null) {
                args += "&checkImmediateSql=" + encodeURIComponent(checkImmediateSql);
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
    IndexInspectorConfigDAO indexInspectorConfigDAO = new IndexInspectorConfigDAO();

    List<IndexInspectorConfigEntity> indexInspectorConfigList = new LinkedList<IndexInspectorConfigEntity>();

    try {
        indexInspectorConfigList = indexInspectorConfigDAO.selectIndexInspectorConfigById(id);

    } catch (Exception e) {
        logger.error(e.getMessage(), e);
    }
    request.setAttribute("indexInspectorConfigList", indexInspectorConfigList.get(0));


%>
<div>
    <table class="table table-hover">
        <tbody class="topicTableContent">

        <tr>
            <td>
                <textarea id="inspectorUpdate_checkImmediateSqlField" name="inspectorUpdate_checkImmediateSqlField"
                          style="width:600px;height:300px">${indexInspectorConfigList.checkImmediateSql}</textarea>
            </td>
        </tr>
        <tr>
            <td>
                <input onclick="update_IndexInspectorConfigSql(${id})" type="button" class="btn btn-primary"
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
