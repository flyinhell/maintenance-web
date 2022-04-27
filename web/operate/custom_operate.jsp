<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.CustomIndexDAO" %>
<%@ page import="com.eland.pojo.model.CustomIndexInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
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

            //新增
            $("#customInsert").click(function () {
                var args = get_insertCustom()
                $.ajax({
                    type: "POST",
                    url: '../operate/custom_execute_operate.jsp',
                    data: args,
                    success: function (html) {
                        alert("新增完成");

                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("新增失敗,請確認參數內容");
                    }
                });
            });

        });

        function get_insertCustom() {
            var args = 'type=insert';
            var count = 0;
            var indexName = '';
            var minute = '';
            var hour = '';
            var day = '';
            var timeoutSecond = '';
            indexName = $("#customInsert_indexNameField").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
                count += 1;
            }
            minute = $("#customInsert_minuteField").val();
            if (minute != "" && minute != null) {
                args += "&minute=" + minute;
                count += 1;
            }
            hour = $("#customInsert_hourField").val();
            if (hour != "" && hour != null) {
                args += "&hour=" + hour;
                count += 1;
            }
            day = $("#customInsert_dayField").val();
            if (day != "" && day != null) {
                args += "&day=" + day;
                count += 1;
            }
            timeoutSecond = $("#customInsert_timeoutSecondField").val();
            if (timeoutSecond != "" && timeoutSecond != null) {
                args += "&timeoutSecond=" + timeoutSecond;
                count += 1;
            }
            //沒有下任何條件
            if (count <= 4) {
                args = "";
                alert("請填寫內容");

            }

            return args;
        }

        //刪除
        function delete_CustomIndex(id) {
            var args = "type=delete&id=" + id;
            var del = confirm("確認要刪除任務資料嗎?");
            if (del == true) {
                $.ajax({
                    type: "POST",
                    url: '../operate/custom_execute_operate.jsp',
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
        function update_CustomIndex(id) {
            var args = get_updateCustom(id);
            $.ajax({
                type: "POST",
                url: '../operate/custom_execute_operate.jsp',
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

        function get_updateCustom(id) {
            var args = 'type=update&id=' + id;
            var count = 0;
            var indexName = '';
            var minute = '';
            var hour = '';
            var day = '';
            var timeoutSecond = '';
            indexName = $("#customUpdate_indexNameField" + id).val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
                count += 1;
            }
            minute = $("#customUpdate_minuteField" + id).val();
            if (minute != "" && minute != null) {
                args += "&minute=" + minute;
                count += 1;
            }
            hour = $("#customUpdate_hourField" + id).val();
            if (hour != "" && hour != null) {
                args += "&hour=" + hour;
                count += 1;
            }
            day = $("#customUpdate_dayField" + id).val();
            if (day != "" && day != null) {
                args += "&day=" + day;
                count += 1;
            }
            timeoutSecond = $("#customUpdate_timeoutSecondField" + id).val();
            if (timeoutSecond != "" && timeoutSecond != null) {
                args += "&timeoutSecond=" + timeoutSecond;
                count += 1;
            }
            //沒有下任何條件
            if (count <= 4) {
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
    CustomIndexDAO customIndexDAO = new CustomIndexDAO();
//    //未完成任務或失敗任務搜尋
    if (type.equals("insert")) {
        request.setAttribute("type", type);
    } else if (type.equals("update")) {
        List<CustomIndexInformationEntity> customIndexList = new LinkedList<CustomIndexInformationEntity>();
        try {
//            indexName = reqWrapper.getParameter("indexName");
            indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
            customIndexList = customIndexDAO.selectCustomIndexInformation(indexName);
            totalSize = customIndexList.size();


//            System.out.println(customIndexList.get(0).getIndexName());
//            System.out.println(customIndexList.get(0).getMinute());
//            System.out.println(customIndexList.get(0).getHour());
//            System.out.println(customIndexList.get(0).getDay());
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("customIndexList", customIndexList);
        request.setAttribute("totalSize", totalSize);
        request.setAttribute("type", type);
    } else if (type.equals("delete")) {
        List<CustomIndexInformationEntity> customIndexList = new LinkedList<CustomIndexInformationEntity>();
        try {
            indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
//            indexName = reqWrapper.getParameter("indexName");
            customIndexList = customIndexDAO.selectCustomIndexInformation(indexName);
            totalSize = customIndexList.size();

            System.out.println(customIndexList.get(0).getIndexName());
            System.out.println(customIndexList.get(0).getMinute());
            System.out.println(customIndexList.get(0).getHour());
            System.out.println(customIndexList.get(0).getDay());
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("customIndexList", customIndexList);
        request.setAttribute("totalSize", totalSize);
        request.setAttribute("type", type);
    }

%>
<body>
<c:choose>
    <c:when test="${type=='update'&&totalSize>0}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th></th>
            <th>IndexName</th>
            <th>Minute</th>
            <th>Hour</th>
            <th>Day</th>
            <th>TimeoutSecond</th>

            <c:forEach items="${customIndexList}" var="customIndexList" begin="0" end="${totalSize-1}">
                <tr>
                    <td>
                        <input type="button" class="btn btn-warning" style="width:60px;height:25px;font-size:12px"
                               value="更新"
                               onclick="update_CustomIndex(${customIndexList.id})">
                    </td>

                    <td><input type="text" style="width:180px;height:30px" class="textInput"
                               value=${customIndexList.indexName}
                                       id="customUpdate_indexNameField${customIndexList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${customIndexList.minute}
                                       id="customUpdate_minuteField${customIndexList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${customIndexList.hour}
                                       id="customUpdate_hourField${customIndexList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${customIndexList.day}
                                       id="customUpdate_dayField${customIndexList.id}"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput"
                               value=${customIndexList.timeoutSecond}
                                       id="customUpdate_timeoutSecondField${customIndexList.id}"></td>

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
            <th>IndexName</th>
            <th>Minute</th>
            <th>Hour</th>
            <th>Day</th>
            <th>TimeoutSecond</th>
            <c:forEach items="${customIndexList}" var="customIndexList" begin="0" end="${totalSize-1}">

                <tr>
                    <td>
                        <input type="button" class="btn btn-danger" style="width:60px;height:25px;font-size:12px"
                               value="刪除"
                               onclick="delete_CustomIndex(${customIndexList.id})">
                    </td>
                    <td>${customIndexList.indexName}</td>
                    <td>${customIndexList.minute}</td>
                    <td>${customIndexList.hour}</td>
                    <td>${customIndexList.day}</td>
                    <td>${customIndexList.timeoutSecond}</td>
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
    <c:when test="${type=='insert'}">
        <table class="table table-hover">

            <tbody class="topicTableContent">
            <th>IndexName</th>
            <th>Minute</th>
            <th>Hour</th>
            <th>Day</th>
            <th>TimeoutSecond</th>
            <tr>

                <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="索引庫名稱"
                           id="customInsert_indexNameField"></td>
                <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="0"
                           id="customInsert_minuteField"></td>
                <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="*/3"
                           id="customInsert_hourField"></td>
                <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="*"
                           id="customInsert_dayField"></td>
                <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="7200"
                           id="customInsert_timeoutSecondField"></td>
            </tr>
            <tr>
                <td colspan="5">
                    <input type="button" class="btn btn-info" style="width:60px;height:25px;font-size:12px" value="新增"
                           id="customInsert">
                </td>
            </tr>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <strong>找不到符合的資料</strong>
    </c:otherwise>
</c:choose>
</body>
</html>