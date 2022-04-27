<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.CustomIndexDAO" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.MonthyIndexConfigDAO" %>
<%@ page import="com.eland.pojo.model.MonthyTaskConfigEntity" %>
<%@ page import="com.eland.dao.IndexInspectorConfigDAO" %>
<%@ page import="com.eland.dao.IndexInformationDAO" %>
<%@ page import="com.eland.pojo.model.IndexInspectorConfigEntity" %>
<%@ page import="com.eland.pojo.model.IndexInformationEntity" %>
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

        //刪除
        function delete_IndexInspectorConfig(id) {
            var args = "type=delete&id=" + id;
            var del = confirm("確認要刪除索引設定嗎?");
            if (del == true) {
                $.ajax({
                    type: "POST",
                    url: '../search/inspectorUpdate_execute_operate.jsp',
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
        function update_IndexInspectorConfig(id) {
            var args = get_updateIndexInspectorConfig(id);
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

        //修改
        function update_IndexInformation(id) {
            var args = get_updateIndexInformation(id);
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


        //修改
        function update_IndexInformationDatabase(id) {
            var args = get_updateIndexInformationDatabase(id);
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

        function get_updateIndexInspectorConfig(id) {
            var args = 'type=updateIndexInspectorConfig&id=' + id;
            var count = 0;
            var indexType = '';
            var immediate = '';
            var inspectSwitch = '';

            indexType = $("#inspectorUpdate_indexTypeField" + id).val();
            if (indexType != "" && indexType != null) {
                args += "&indexType=" + indexType;
                count += 1;
            }
            immediate = $("#inspectorUpdate_immediateField" + id).val();
            if (immediate != "" && immediate != null) {
                args += "&immediate=" + encodeURIComponent(immediate);
                count += 1;
            }
            inspectSwitch = $("#inspectorUpdate_inspectSwitchField" + id).val();
            if (inspectSwitch != "" && inspectSwitch != null) {
                args += "&inspectSwitch=" + encodeURIComponent(inspectSwitch);
                count += 1;
            }

            //沒有下任何條件
            if (count <= 2) {
                args = "";
                alert("請填寫內容");
            }
            return args;
        }

        function get_updateIndexInformation(id) {
            var args = 'type=updateIndexInformation&id=' + id;
            var count = 0;
            var indexType = '';
            var dateRange = '';
            var pType2 = '';


            indexType = $("#inspectorUpdate_indexTypeField" + id).val();
            if (indexType != "" && indexType != null) {
                args += "&indexType=" + encodeURIComponent(indexType);
                count += 1;
            }
            dateRange = $("#inspectorUpdate_dateRangeField" + id).val();
            if (dateRange != "" && dateRange != null) {
                args += "&dateRange=" + encodeURIComponent(dateRange);
                count += 1;
            }
            pType2 = $("#inspectorUpdate_pType2Field" + id).val();
            if (pType2 != "" && pType2 != null) {
                args += "&pType2=" + encodeURIComponent(pType2);
                count += 1;
            }

            //沒有下任何條件

            if (count <= 2) {
                args = "";
                alert("請填寫內容");
            }
            return args;
        }

        function get_updateIndexInformationDatabase(id) {
            var args = 'type=updateIndexInformationDatabase&id=' + id;
            var count = 0;
            var viewName = '';
            var databaseType = '';
            var databaseAddress = '';

            viewName = $("#inspectorUpdate_viewNameField" + id).val();
            if (viewName != "" && viewName != null) {
                args += "&viewName=" + viewName;
                count += 1;
            }
            databaseType = $("#inspectorUpdate_databaseTypeField" + id).val();
            if (databaseType != "" && databaseType != null) {
                args += "&databaseType=" + databaseType;
                count += 1;
            }
            databaseAddress = $("#inspectorUpdate_databaseAddressField" + id).val();
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
    int indexInspectorConfigTotalSize = 0;      //資料總筆數
    int indexInformationListTotalSize = 0;      //資料總筆數

    IndexInspectorConfigDAO indexInspectorConfigDAO = new IndexInspectorConfigDAO();
    IndexInformationDAO indexInformationDAO = new IndexInformationDAO();

    List<IndexInspectorConfigEntity> indexInspectorConfigList = new LinkedList<IndexInspectorConfigEntity>();
    List<IndexInformationEntity> indexInformationList = new LinkedList<IndexInformationEntity>();
    try {
        indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        //config
        indexInspectorConfigList = indexInspectorConfigDAO.selectIndexInspectorConfig(indexName);
        indexInspectorConfigTotalSize = indexInspectorConfigList.size();
        //information
        indexInformationList = indexInformationDAO.selectIndexInformation(indexName);
        indexInformationListTotalSize = indexInformationList.size();
    } catch (Exception e) {
        logger.error(e.getMessage(), e);
    }
    request.setAttribute("indexInspectorConfigList", indexInspectorConfigList);
    request.setAttribute("indexInspectorConfigTotalSize", indexInspectorConfigTotalSize);

    request.setAttribute("indexInformationList", indexInformationList);
    request.setAttribute("indexInformationListTotalSize", indexInformationListTotalSize);

    if (type.equals("updateConfig")) {
        request.setAttribute("type", type);
    } else if (type.equals("updateInformation")) {
        request.setAttribute("type", type);
    } else if (type.equals("updateDatabase")) {
        request.setAttribute("type", type);
    } else if (type.equals("delete")) {
        request.setAttribute("type", type);
    }

%>
<body>
<c:choose>
    <c:when test="${type=='updateConfig'&&indexInspectorConfigTotalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>索引名稱<br>(index_name)</th>
            <th>索引檢測類型<br>(index_type)</th>
            <th>即時性<br>(immediate)</th>
            <th>檢測開關<br>(inspectSwitch)</th>
            <th>檢測SQL<br>(check_immediate_sql)</th>


            <c:forEach items="${indexInspectorConfigList}" var="indexInspectorConfigList" begin="0"
                       end="${indexInspectorConfigTotalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-warning" style="width:60px;height:25px;font-size:12px"
                               value="更新"
                               onclick="update_IndexInspectorConfig(${indexInspectorConfigList.id})">
                    </td>

                    <td>${indexInspectorConfigList.indexName}</td>

                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${indexInspectorConfigList.indexType}
                                       id="inspectorUpdate_indexTypeField${indexInspectorConfigList.id}"></td>
                    <td><input type="text" style="width:100px;height:30px" class="textInput"
                               value=${indexInspectorConfigList.immediate}
                                       id="inspectorUpdate_immediateField${indexInspectorConfigList.id}"></td>
                    <td><input type="text" style="width:180px;height:30px" class="textInput"
                               value=${indexInspectorConfigList.inspectSwitch}
                                       id="inspectorUpdate_inspectSwitchField${indexInspectorConfigList.id}"></td>
                    <td><a href="../search/inspectorUpdate_sql.jsp?id=${indexInspectorConfigList.id}"
                           class="btnstyleA editConfig"><span>編輯</span></a>

                            <%--<td><input type="text" style="width:140px;height:30px" class="textInput"--%>
                            <%--value=${indexInspectorConfigList.checkImmediateSql}--%>
                            <%--id="monthyUpdate_priorityField${indexInspectorConfigList.id}"></td>--%>


                        <c:forEach var="categoryName" items="${categoriesList}" varStatus="loop">
                        <li><a onclick="getCategoryIndex(${loop.index})" href="#">${categoryName}</a></li>
                        </c:forEach>
                </tr>
            </c:forEach>


            </tbody>
        </table>

    </c:when>
    <c:when test="${type=='updateInformation'&&indexInformationListTotalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>索引名稱<br>(index_name)</th>
            <th>索引庫類型<br>(index_type)</th>
            <th>日期範圍<br>(date_range)</th>
            <th>文章類型<br>(p_type_2)</th>

            <c:forEach items="${indexInformationList}" var="indexInformationList" begin="0"
                       end="${indexInformationListTotalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-warning" style="width:60px;height:25px;font-size:12px"
                               value="更新"
                               onclick="update_IndexInformation(${indexInformationList.id})">
                    </td>

                    <td>${indexInformationList.indexName}</td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${indexInformationList.indexType}
                                       id="inspectorUpdate_indexTypeField${indexInformationList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${indexInformationList.dateRange}
                                       id="inspectorUpdate_dateRangeField${indexInformationList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${indexInformationList.pType2}
                                       id="inspectorUpdate_pType2Field${indexInformationList.id}"></td>
                    <c:forEach var="categoryName" items="${categoriesList}" varStatus="loop">
                        <li><a onclick="getCategoryIndex(${loop.index})" href="#">${categoryName}</a></li>
                    </c:forEach>
                </tr>
            </c:forEach>


            </tbody>
        </table>

    </c:when>
    <c:when test="${type=='updateDatabase'&&indexInformationListTotalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>索引名稱<br>(index_name)</th>
            <th>檢視表名稱<br>(view_name)</th>
            <th>資料庫類型<br>(database_type)</th>
            <th>資料庫位置<br>(database_address)</th>

            <c:forEach items="${indexInformationList}" var="indexInformationList" begin="0"
                       end="${indexInformationListTotalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-warning" style="width:60px;height:25px;font-size:12px"
                               value="更新"
                               onclick="update_IndexInformationDatabase(${indexInformationList.id})">
                    </td>

                    <td>${indexInformationList.indexName}</td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${indexInformationList.viewName}
                                       id="inspectorUpdate_viewNameField${indexInformationList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${indexInformationList.databaseType}
                                       id="inspectorUpdate_databaseTypeField${indexInformationList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${indexInformationList.databaseAddress}
                                       id="inspectorUpdate_databaseAddressField${indexInformationList.id}"></td>


                    <c:forEach var="categoryName" items="${categoriesList}" varStatus="loop">
                        <li><a onclick="getCategoryIndex(${loop.index})" href="#">${categoryName}</a></li>
                    </c:forEach>
                </tr>
            </c:forEach>


            </tbody>
        </table>

    </c:when>
    <c:when test="${type=='delete'&&indexInspectorConfigTotalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>索引名稱<br>(index_name)</th>
            <th>索引檢測類型<br>(index_type)</th>
            <th>即時性<br>(immediate)</th>
            <th>檢測開關<br>(inspectSwitch)</th>
            <c:forEach items="${indexInspectorConfigList}" var="indexInspectorConfigList" begin="0"
                       end="${indexInspectorConfigTotalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-danger" style="width:60px;height:25px;font-size:12px"
                               value="刪除"
                               onclick="delete_IndexInspectorConfig(${indexInspectorConfigList.id})">
                    </td>
                    <td>${indexInspectorConfigList.indexName}</td>
                    <td>${indexInspectorConfigList.indexType}</td>
                    <td>${indexInspectorConfigList.immediate}</td>
                    <td>${indexInspectorConfigList.inspectSwitch}</td>

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