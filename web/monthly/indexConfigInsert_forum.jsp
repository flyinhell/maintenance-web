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

        //組新增的設定條件
        function getArgs_InsertIndexConfig() {
            var args = '1=1';
            var count = 0;

            var indexName = '';
            indexName = $("#indexConfig_indexName").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
                count += 1;
            }
            var indexType = '';
            indexType = $("#indexConfig_indexType").val();
            if (indexType != "" && indexType != null) {
                args += "&indexType=" + indexType;
                count += 1;
            }
            var machineNameList = '';
            machineNameList = $("#indexConfig_machineNameList").val();
            if (machineNameList != "" && machineNameList != null) {
                args += "&machineNameList=" + encodeURIComponent(machineNameList);
                count += 1;
            }
            var priority = '';
            priority = $("#indexConfig_priority").val();
            if (priority != "" && priority != null) {
                args += "&priority=" + encodeURIComponent(priority);
                count += 1;
            }
            var module = '';
            module = $("#indexConfig_module").val();
            if (module != "" && module != null) {
                args += "&module=" + module;
                count += 1;
            }
            var customer = '';
            customer = $("#indexConfig_customer").val();
            if (customer != "" && customer != null) {
                args += "&customer=" + encodeURIComponent(customer);
                count += 1;
            }
            var sourceType = '';
            sourceType = $("#indexConfig_sourceType").val();
            if (sourceType != "" && sourceType != null) {
                args += "&sourceType=" + sourceType;
                count += 1;
            }
            var contentType = '';
            contentType = $("#indexConfig_contentType").val();
            if (contentType != "" && contentType != null) {
                args += "&contentType=" + contentType;
                count += 1;
            }

            var viewName = '';
            viewName = $("#indexConfig_viewName").val();
            if (viewName != "" && viewName != null) {
                args += "&viewName=" + viewName;
                count += 1;
            }
            var databaseType = '';
            databaseType = $("#indexConfig_databaseType").val();
            if (databaseType != "" && databaseType != null) {
                args += "&databaseType=" + databaseType;
                count += 1;
            }
            var databaseAddress = '';
            databaseAddress = $("#indexConfig_databaseAddress").val();
            if (databaseAddress != "" && databaseAddress != null) {
                args += "&databaseAddress=" + encodeURIComponent(databaseAddress);
                count += 1;
            }
            var viewSchema = '';
            viewSchema = $("#indexConfig_viewSchema").val();
            if (viewSchema != "" && viewSchema != null) {
                args += "&viewSchema=" + encodeURIComponent(viewSchema);
                count += 1;
            }

            //有未填入的空白欄位
            if (count <= 11) {
                alert("有未填入的空白欄位!!");
                return false;
            }

            return args;
        }

        $(document).ready(function () {

            $("#inline").fancybox({});
            $("select[name='colorpicker-picker']").simplecolorpicker({picker: true});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});

            //傳送查詢條件
            $("#insertIndexConfig").click(function () {
                var args = getArgs_InsertIndexConfig();

                $.ajax({
                    type: "POST",
                    url: '../monthly/indexConfigInsert_operate.jsp',
                    data: args,
                    success: function (html) {
                        alert("新增完成");
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("新增失敗,請確認輸入參數或稍後再試..");
                    }
                });

            });
        });
    </script>
</head>

<body>
<table class="table table-hover">
    <tbody>

    <tr>
        <td colspan="6" style="font-size:large;font-weight:bold">索引庫及機器相關設定</td>
    </tr>
    <tr>
        <td width="200">索引名稱<br>(index_name)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="WH_Blog_1%DATETIME%"
                               value="" id="indexConfig_indexName">
        </td>
        <td>索引庫類型<br>(index_type)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="synchronized" value=""
                               id="indexConfig_indexType">
        </td>
    </tr>
    <tr>
        <td>機器列表<br>(machine_name_list)</td>
        <td colspan="5"><input type="text" style="width:400px;height:30px" class="textInput"
                               placeholder="swd-searcher09;swd-searcher11;swd-searcher15" value=""
                               id="indexConfig_machineNameList">
        </td>
    </tr>
    <tr>
        <td>機器優先權<br>(priority)</td>
        <td colspan="5"><input type="text" style="width:400px;height:30px" class="textInput"
                               placeholder="swd-searcher09:20;swd-searcher11:20;swd-searcher15:20" value=""
                               id="indexConfig_priority">
        </td>
    </tr>
    <tr>
        <td>模組<br>(module)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="TDS" value=""
                               id="indexConfig_module">
        </td>
        <td>顧客站台<br>(customer)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="opview" value=""
                               id="indexConfig_customer">
        </td>
    </tr>
    <tr>
        <td>來源類型<br>(source_type)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="blog" value=""
                               id="indexConfig_sourceType">
        </td>
        <td>文章類型<br>(content_type)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="main" value=""
                               id="indexConfig_contentType">
        </td>
    </tr>
    <tr>
        <td colspan="6" style="font-size:large;font-weight:bold">資料庫相關設定</td>
    </tr>
    <tr>
        <td>檢視表名稱<br>(view_name)</td>
        <td colspan="5"><input type="text" style="width:400px;height:30px" class="textInput"
                               placeholder="vw_opv_blog_01_indexing_YEARMONTH" value="" id="indexConfig_viewName">
        </td>
    </tr>
    <tr>
        <td>資料庫類型<br>(database_type)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="mariadb" value=""
                               id="indexConfig_databaseType">
        </td>
        <td>資料庫位置<br>(database_address)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput"
                               placeholder="10.20.20.232:3306/wh_query" value="" id="indexConfig_databaseAddress">
        </td>
    </tr>
    <tr>
        <td>檢視表schema<br>(view_schema)</td>
        <td colspan="5">
            <textarea id="indexConfig_viewSchema" name="indexConfig_viewSchema"
                      style="width:650px;height:200px "></textarea>

        </td>
    </tr>


    <tr>
        <%--<td><input type="button" class="btn btn-primary" onclick="doRequestUsingGET()" value="查詢"></td>--%>
        <td colspan="6"><a href="#" type="button" class="btn btn-primary" style="width:155px;height:30px;font-size:14px"
                           id="insertIndexConfig"><span>新增</span></a></td>

    </tr>
    </tbody>
</table>


</body>
</html>
