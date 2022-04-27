<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.RollbackTaskDAO" %>
<%@ page import="com.eland.pojo.model.IndexRollbackTaskEntity" %>
<%@ page import="com.eland.dao.NewSourceDAO" %>
<%@ page import="com.eland.pojo.model.WhSourceTypeEntity" %>
<%--
  Created by IntelliJ IDEA.
  User: zhenfuliao
  Date: 2020/5/14
  Time: 下午 06:00
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
            $("#newSourceInsert").click(function () {
                var args = get_insertNewSource();
                // var argsArr = args.split(";");
                // for (var i = 0; i < argsArr.length; i++) {
                    if (args != "") {
                        $.ajax({
                            type: "POST",
                            url: '../operate/newSource_execute_operate.jsp',
                            data: args,
                            success: function (html) {
                                $("#newSource_execute_operateScope").html(html);
                                alert("新增完成");
                            },
                            error: function (jqXHR) {
                                if (jqXHR.status === 0) return;
                                alert("新增失敗,請確認參數內容");
                            }
                        });
                    }
                // }

            });
        })
        ;

        function get_insertNewSource() {
            var args = '';

            var sourceIdArray = new Array();
            var sourceNameArray = new Array();
            var ptypeArray = new Array();
            var ptype2Array = new Array();

            $('[name="newSourceInsert_sourceIdField"]').each(function (i) {
                sourceIdArray[i] = $(this).val();
            });
            $('[name="newSourceInsert_sourceNameField"]').each(function (i) {
                sourceNameArray[i] = $(this).val();
            });
            $('[name="newSourceInsert_pTypeField"]').each(function (i) {
                ptypeArray[i] = $(this).val();
            });
            $('[name="newSourceInsert_pType2Field"]').each(function (i) {
                ptype2Array[i] = $(this).val();
            });

            // for (var i = 0; i < sourceIdArray.length; i++) {
                args += "type=insert";
                var count = 0;
                var sourceId = sourceIdArray;
                var sourceName = sourceNameArray;
                var ptype = ptypeArray;
                var ptype2 = ptype2Array;

                if (sourceId != "" && sourceId != null) {
                    // args += "&sourceId=" + encodeURIComponent(sourceId);
                    args += "&sourceId=" + sourceId;
                    count += 1;
                }
                if (sourceName != "" && sourceName != null) {
                    args += "&sourceName=" + sourceName;
                    count += 1;
                }
                if (ptype != "" && ptype != null) {
                    args += "&ptype=" + ptype;
                    count += 1;
                }
                if (ptype2 != "" && ptype2 != null) {
                    args += "&ptype2=" + ptype2;
                    count += 1;
                }
                //沒有下任何條件
                if (count <= 1) {
                    args = "";
                    alert("請填寫內容");
                }
                // args += ";";
            // }
            return args;
        }

        //刪除
        function delete_NewSource(id) {
            var args = "type=delete&id=" + id;
            var del = confirm("確認要刪除該筆新來源嗎?");
            if (del == true) {
                $.ajax({
                    type: "POST",
                    url: '../operate/newSource_execute_operate.jsp',
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

        $(function () {
            $("#add").click(function () {
                $('#addMember tbody').append('<tr> ' +
                    '<td><input type="text" style="width:140px;height:30px" class="textInput" placeholder="" ' +
                    'name="newSourceInsert_sourceIdField"></td> ' +
                    '<td><input type="text" style="width:140px;height:30px" class="textInput" value="" ' +
                    'name="newSourceInsert_sourceNameField"></td> ' +
                    '<td><input type="text" style="width:140px;height:30px" class="textInput" value="" ' +
                    'name="newSourceInsert_pTypeField"></td> ' +
                    '<td><input type="text" style="width:140px;height:30px" class="textInput" value="" ' +
                    'name="newSourceInsert_pType2Field"></td> ' +
                    '</tr>');
            });
        })

    </script>


    <title></title>
</head>
<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String type = reqWrapper.getParameter("type");
    String newSource = "";
    int totalSize = 0;      //資料總筆數
    NewSourceDAO newSourceDAO = new NewSourceDAO();
//    //未完成任務或失敗任務搜尋
    if (type.equals("insert")) {
        request.setAttribute("type", type);
    } else if (type.equals("delete")) {
        List<WhSourceTypeEntity> newSourceList = new LinkedList<WhSourceTypeEntity>();
        try {
            newSource = new String(request.getParameter("newSource").getBytes("ISO8859-1"), "UTF-8");
            newSourceList = newSourceDAO.selectNewSourceById(newSource);
            totalSize = newSourceList.size();

        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("newSourceList", newSourceList);
        request.setAttribute("totalSize", totalSize);
        request.setAttribute("type", type);
    }

%>
<body>
<form>
    <c:choose>

        <c:when test="${type=='delete'&&totalSize>0}">
            <table class="table table-hover">

                <tbody class="topicTableContent">
                <th></th>
                <th>sourceId</th>
                <th>sourceName</th>
                <th>type</th>
                <th>type2</th>
                <c:forEach items="${newSourceList}" var="newSourceList" begin="0" end="${totalSize-1}">

                    <tr>
                        <td>
                            <input type="button" class="btn btn-danger" style="width:60px;height:25px;font-size:12px"
                                   value="刪除"
                                   onclick="delete_NewSource(${newSourceList.sourceId})">
                        </td>
                        <td>${newSourceList.sourceId}</td>
                        <td>${newSourceList.sourceName}</td>
                        <td>${newSourceList.type}</td>
                        <td>${newSourceList.type2}</td>

                    </tr>

                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:when test="${type=='insert'}">
            <table class="table table-hover" id="addMember">
                <tbody class="topicTableContent">
                <th>source_id</th>
                <th>source_name</th>
                <th>p_type</th>
                <th>p_type_2</th>
                <tr>
                    <td><input type="text" style="width:140px;height:30px" class="textInput" placeholder=""
                               name="newSourceInsert_sourceIdField"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput" value=""
                               name="newSourceInsert_sourceNameField"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput" value=""
                               name="newSourceInsert_pTypeField"></td>
                    <td><input type="text" style="width:140px;height:30px" class="textInput" value=""
                               name="newSourceInsert_pType2Field"></td>
                    <td><input type="button" style="font-size: 16px" id="add" value="+"></td>
                </tr>
                </tbody>
            </table>
            <table>
                <tr>
                    <td>
                        <input type="button" class="btn btn-info" style="width:60px;height:25px;font-size:12px"
                               value="新增" id="newSourceInsert">
                    <td>&nbsp&nbsp&nbsp</td>
                    <td>&nbsp&nbsp&nbsp</td>
                    <td>&nbsp&nbsp&nbsp</td>
                    <td>&nbsp&nbsp&nbsp</td>
                    <td>&nbsp&nbsp&nbsp</td>
                </tr>
            </table>

        </c:when>
        <c:otherwise>
            <strong>找不到符合的資料</strong>
        </c:otherwise>
    </c:choose>
    <div id="newSource_execute_operateScope"></div>
</form>
</body>
</html>
