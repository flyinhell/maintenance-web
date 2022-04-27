<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.CustomIndexDAO" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.pojo.model.MonthyTaskConfigEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: ccyang
  Date: 2018/4/11
  Time: 上午 10:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <%@ include file="../include/util.jsp" %>
    <%@ include file="../include/html_component_bootstrap.jsp" %>
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
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});
            $(".editConfig").colorbox({iframe: false, width: "700px", title: "檢視表架構(view_schema)"});

        });
        //
        //刪除
        function delete_MonthyTaskConfig(id) {
            var args = "type=delete&id=" + id;
            var del = confirm("確認要刪除索引設定嗎?");
            if (del == true) {
                $.ajax({
                    type: "POST",
                    url: '../monthly/monthlyUpdate_execute_operate.jsp',
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

        //修改
        function update_MonthyTaskConfigMachine(id) {
            var args = get_updateMonthyTaskConfigMachine(id);
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

        //修改
        function update_MonthyTaskConfigMapping(id) {
            var args = get_updateMonthyTaskConfigMapping(id);
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


        //修改
        function update_MonthyTaskConfigDatabase(id) {
            var args = get_updateMonthyTaskConfigDatabase(id);
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

        function get_updateMonthyTaskConfigMachine(id) {
            var args = 'type=updateTaskConfigMachine&id=' + id;
            var count = 0;
            var indexType = '';
            var machineNameList = '';
            var priority = '';

            indexType = $("#monthyUpdate_indexTypeField" + id).val();
            if (indexType != "" && indexType != null) {
                args += "&indexType=" + indexType;
                count += 1;
            }
            machineNameList = $("#monthyUpdate_machineNameListField" + id).val();
            if (machineNameList != "" && machineNameList != null) {
                args += "&machineNameList=" + encodeURIComponent(machineNameList);
                count += 1;
            }
            priority = $("#monthyUpdate_priorityField" + id).val();
            if (priority != "" && priority != null) {
                args += "&priority=" + encodeURIComponent(priority);
                count += 1;
            }

            //沒有下任何條件
            if (count <= 2) {
                args = "";
                alert("請填寫內容");
            }
            return args;
        }

        function get_updateMonthyTaskConfigMapping(id) {
            var args = 'type=updateTaskConfigMapping&id=' + id;
            var count = 0;
            var module = '';
            var customer = '';
            var sourceType = '';
            var contentType = '';


            module = $("#monthlyUpdate_moduleField" + id).val();
            if (module != "" && module != null) {
                args += "&module=" + module;
                count += 1;
            }
            customer = $("#monthlyUpdate_customerField" + id).val();
            if (customer != "" && customer != null) {
                args += "&customer=" + encodeURIComponent(customer);
                count += 1;
            }
            sourceType = $("#monthlyUpdate_sourceTypeField" + id).val();
            if (sourceType != "" && sourceType != null) {
                args += "&sourceType=" + sourceType;
                count += 1;
            }
            contentType = $("#monthlyUpdate_contentTypeField" + id).val();
            if (contentType != "" && contentType != null) {
                args += "&contentType=" + contentType;
                count += 1;
            }

            //沒有下任何條件

            if (count <= 3) {
                args = "";
                alert("請填寫內容");
            }
            return args;
        }

        function get_updateMonthyTaskConfigDatabase(id) {
            var args = 'type=updateTaskConfigDatabase&id=' + id;
            var count = 0;
            var viewName = '';
            var databaseType = '';
            var databaseAddress = '';

            viewName = $("#monthlyUpdate_viewNameField" + id).val();
            if (viewName != "" && viewName != null) {
                args += "&viewName=" + viewName;
                count += 1;
            }
            databaseType = $("#monthlyUpdate_databaseTypeField" + id).val();
            if (databaseType != "" && databaseType != null) {
                args += "&databaseType=" + databaseType;
                count += 1;
            }
            databaseAddress = $("#monthlyUpdate_databaseAddressField" + id).val();
            if (databaseAddress != "" && databaseAddress != null) {
                args += "&databaseAddress=" + encodeURIComponent(databaseAddress);
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
    String indexName = "";
    int totalSize = 0;      //資料總筆數
    MonthyIndexConfigDAO monthyIndexConfigDAO = new MonthyIndexConfigDAO();
    List<MonthyTaskConfigEntity> monthyTaskConfigList = new LinkedList<MonthyTaskConfigEntity>();
    try {
        indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        monthyTaskConfigList = monthyIndexConfigDAO.selectMonthyTaskConfig(indexName);
        totalSize = monthyTaskConfigList.size();
    } catch (Exception e) {
        logger.error(e.getMessage(), e);
    }
    request.setAttribute("monthyTaskConfigList", monthyTaskConfigList);
    request.setAttribute("totalSize", totalSize);

    if (type.equals("updateMachine")) {
        request.setAttribute("type", type);
    } else if (type.equals("updateMapping")) {
        request.setAttribute("type", type);
    } else if (type.equals("updateDatabase")) {
        request.setAttribute("type", type);
    } else if (type.equals("delete")) {
        request.setAttribute("type", type);
    }

%>
<body>
<c:choose>
    <c:when test="${type=='updateMachine'&&totalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>索引名稱<br>(index_name)</th>
            <th>索引庫類型<br>(index_type)</th>
            <th>機器列表<br>(machine_name_list)</th>
            <th>機器優先權<br>(priority)</th>

            <c:forEach items="${monthyTaskConfigList}" var="monthyTaskConfigList" begin="0" end="${totalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-warning" style="width:60px;height:25px;font-size:12px"
                               value="更新"
                               onclick="update_MonthyTaskConfigMachine(${monthyTaskConfigList.id})">
                    </td>

                    <td>${monthyTaskConfigList.indexName}</td>

                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.indexType}
                                       id="monthyUpdate_indexTypeField${monthyTaskConfigList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.machineNameList}
                                       id="monthyUpdate_machineNameListField${monthyTaskConfigList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.priority}
                                       id="monthyUpdate_priorityField${monthyTaskConfigList.id}"></td>

                    <c:forEach var="categoryName" items="${categoriesList}" varStatus="loop">
                        <li><a onclick="getCategoryIndex(${loop.index})" href="#">${categoryName}</a></li>
                    </c:forEach>
                </tr>
            </c:forEach>


            </tbody>
        </table>

    </c:when>
    <c:when test="${type=='updateMapping'&&totalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>索引名稱<br>(index_name)</th>
            <th>模組<br>(module)</th>
            <th>顧客站台<br>(customer)</th>
            <th>來源類型<br>(source_type)</th>
            <th>文章類型<br>(content_type)</th>

            <c:forEach items="${monthyTaskConfigList}" var="monthyTaskConfigList" begin="0" end="${totalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-warning" style="width:60px;height:25px;font-size:12px"
                               value="更新"
                               onclick="update_MonthyTaskConfigMapping(${monthyTaskConfigList.id})">
                    </td>

                    <td>${monthyTaskConfigList.indexName}</td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.module}
                                       id="monthlyUpdate_moduleField${monthyTaskConfigList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.customer}
                                       id="monthlyUpdate_customerField${monthyTaskConfigList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.sourceType}
                                       id="monthlyUpdate_sourceTypeField${monthyTaskConfigList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.contentType}
                                       id="monthlyUpdate_contentTypeField${monthyTaskConfigList.id}"></td>
                    <c:forEach var="categoryName" items="${categoriesList}" varStatus="loop">
                        <li><a onclick="getCategoryIndex(${loop.index})" href="#">${categoryName}</a></li>
                    </c:forEach>
                </tr>
            </c:forEach>


            </tbody>
        </table>

    </c:when>
    <c:when test="${type=='updateDatabase'&&totalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>索引名稱<br>(index_name)</th>
            <th>檢視表名稱<br>(view_name)</th>
            <th>資料庫類型<br>(database_type)</th>
            <th>資料庫位置<br>(database_address)</th>
            <th>檢視表結構<br>(view_schema)</th>

            <c:forEach items="${monthyTaskConfigList}" var="monthyTaskConfigList" begin="0" end="${totalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-warning" style="width:60px;height:25px;font-size:12px"
                               value="更新"
                               onclick="update_MonthyTaskConfigDatabase(${monthyTaskConfigList.id})">
                    </td>

                    <td>${monthyTaskConfigList.indexName}</td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.viewName}
                                       id="monthlyUpdate_viewNameField${monthyTaskConfigList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.databaseType}
                                       id="monthlyUpdate_databaseTypeField${monthyTaskConfigList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${monthyTaskConfigList.databaseAddress}
                                       id="monthlyUpdate_databaseAddressField${monthyTaskConfigList.id}"></td>
                    <td><a href="../monthly/monthlyUpdate_viewSchema.jsp?id=${monthyTaskConfigList.id}"
                           class="btnstyleA editConfig"><span>編輯</span></a>

                        <c:forEach var="categoryName" items="${categoriesList}" varStatus="loop">
                        <li><a onclick="getCategoryIndex(${loop.index})" href="#">${categoryName}</a></li>
                        </c:forEach>
                </tr>
            </c:forEach>


            </tbody>
        </table>

    </c:when>
    <c:when test="${type=='delete'&&totalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>索引名稱<br>(index_name)</th>
            <th>資料庫位置<br>(database_address)</th>
            <th>機器列表<br>(machine_name_list)</th>
            <c:forEach items="${monthyTaskConfigList}" var="monthyTaskConfigList" begin="0" end="${totalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-danger" style="width:60px;height:25px;font-size:12px"
                               value="刪除"
                               onclick="delete_MonthyTaskConfig(${monthyTaskConfigList.id})">
                    </td>
                    <td>${monthyTaskConfigList.indexName}</td>
                    <td>${monthyTaskConfigList.databaseAddress}</td>
                    <td>${monthyTaskConfigList.machineNameList}</td>

                </tr>

            </c:forEach>

                <%--<tr>--%>
                <%--<td colspan="5">--%>
                <%--<input type="button" class="btn btn-info" value="刪除" id="customDelete">--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--<input type="hidden" name="customDelete_indexNameField" id="customDelete_indexNameField" value=${indexName}>--%>
            </tbody>
        </table>
    </c:when>

    <c:otherwise>
        <strong>找不到符合的資料</strong>
    </c:otherwise>
</c:choose>
</body>
</html>