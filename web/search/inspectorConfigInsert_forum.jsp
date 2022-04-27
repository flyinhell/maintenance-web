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
        function getArgs_InsertInspectorIndexConfig() {
            var args = '1=1';
            var count = 0;

            var indexName = '';
            indexName = $("#inspectorConfigInsert_indexName").val();
            if (indexName != "" && indexName != null) {
                args += "&indexName=" + encodeURIComponent(indexName);
                count += 1;
            }
            var informationIndexType = '';
            informationIndexType = $("#inspectorConfigInsert_information_indexType").val();
            if (informationIndexType != "" && informationIndexType != null) {
                args += "&informationIndexType=" + informationIndexType;
                count += 1;
            }
            var configIndexType = '';
            configIndexType = $("#inspectorConfigInsert_config_indexType").val();
            if (configIndexType != "" && configIndexType != null) {
                args += "&configIndexType=" + configIndexType;
                count += 1;
            }
            var informationDateRange = '';
            informationDateRange = $("#inspectorConfigInsert_information_date_range").val();
            if (informationDateRange != "" && informationDateRange != null) {
                args += "&informationDateRange=" + encodeURIComponent(informationDateRange);
                count += 1;
            }
            var immediate = '';
            immediate = $("#inspectorConfigInsert_config_immediate").val();
            if (immediate != "" && immediate != null) {
                args += "&immediate=" + encodeURIComponent(immediate);
                count += 1;
            }
            var informationPType2 = '';
            informationPType2 = $("#inspectorConfigInsert_information_pType2").val();
            if (informationPType2 != "" && informationPType2 != null) {
                args += "&informationPType2=" + encodeURIComponent(informationPType2);
                count += 1;
            }
            var standardSwitch = '';
            standardSwitch = $("#inspectorConfigInsert_config_standard_switch").prop('checked');
            if (standardSwitch != "" && standardSwitch != null) {
                args += "&standardSwitch=" + standardSwitch;

            }
            var staffSwitch = '';
            staffSwitch = $("#inspectorConfigInsert_config_staff_switch").prop('checked');
            if (staffSwitch != "" && staffSwitch != null) {
                args += "&staffSwitch=" + staffSwitch;

            }
            var advancedSwitch = '';
            advancedSwitch = $("#inspectorConfigInsert_config_advanced_switch").prop('checked');
            if (advancedSwitch != "" && advancedSwitch != null) {
                args += "&advancedSwitch=" + advancedSwitch;

            }
            var instantSwitch = '';
            instantSwitch = $("#inspectorConfigInsert_config_instant_switch").prop('checked');
            if (instantSwitch != "" && instantSwitch != null) {
                args += "&instantSwitch=" + instantSwitch;

            }
            var viewName = '';
            viewName = $("#inspectorConfigInsert_information_viewName").val();
            if (viewName != "" && viewName != null) {
                args += "&viewName=" + viewName;
                count += 1;
            }
            var databaseType = '';
            databaseType = $("#inspectorConfigInsert_information_databaseType").val();
            if (databaseType != "" && databaseType != null) {
                args += "&databaseType=" + databaseType;
                count += 1;
            }
            var databaseAddress = '';
            databaseAddress = $("#inspectorConfigInsert_information_databaseAddress").val();
            if (databaseAddress != "" && databaseAddress != null) {
                args += "&databaseAddress=" + encodeURIComponent(databaseAddress);
                count += 1;
            }
            var checkImmediateSql = '';
            checkImmediateSql = $("#inspectorConfigInsert_checkImmediateSql").val();
            if (checkImmediateSql != "" && checkImmediateSql != null) {
                args += "&checkImmediateSql=" + encodeURIComponent(checkImmediateSql);
                count += 1;
            }

            //有未填入的空白欄位
            if (count <= 9) {
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
            $("#inspectorConfigInsert_insertConfig").click(function () {
                var args = getArgs_InsertInspectorIndexConfig();

                $.ajax({
                    type: "POST",
                    url: '../search/inspectorConfigInsert_operate.jsp',
                    data: args,
                    success: function (html) {
                        alert("新增完成");
                    },
                    error: function (jqXHR) {
                        if (jqXHR.status === 0) return;
                        alert("新增失敗,請確認輸入參數或稍後再試789..");
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
                               value="" id="inspectorConfigInsert_indexName">
        </td>
        <td>索引庫類型<br>(index_type)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="synchronized" value=""
                               id="inspectorConfigInsert_information_indexType">
        </td>
    </tr>

    <tr>
        <td width="200">日期範圍<br>(date_range)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="1-31"
                               value="" id="inspectorConfigInsert_information_date_range">
        </td>
        <td>即時性<br>(immediate)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="0" value=""
                               id="inspectorConfigInsert_config_immediate">
        </td>
    </tr>
    <tr>
        <td width="200">索引檢測類型<br>(index_type)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="synchronized"
                               value="" id="inspectorConfigInsert_config_indexType">
        </td>
        <td>文章類型<br>(p_type_2)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="forum" value=""
                               id="inspectorConfigInsert_information_pType2">
        </td>
    </tr>
    <tr>
        <td>服務檢測開關<br></td>
        <td colspan="4">
            <input type="checkbox" id="inspectorConfigInsert_config_standard_switch" checked>&nbsp;標準(standard)
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" id="inspectorConfigInsert_config_staff_switch" checked>&nbsp;內部(staff-only)
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" id="inspectorConfigInsert_config_advanced_switch" checked>&nbsp;分流(advanced)
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="checkbox" id="inspectorConfigInsert_config_instant_switch" checked>&nbsp;通報(instant)
        </td>
    </tr>
    <tr>
        <td colspan="6" style="font-size:large;font-weight:bold">資料庫相關設定</td>
    </tr>
    <tr>
        <td>檢視表名稱<br>(view_name)</td>
        <td colspan="5"><input type="text" style="width:400px;height:30px" class="textInput"
                               placeholder="vw_opv_blog_01_indexing_YEARMONTH" value=""
                               id="inspectorConfigInsert_information_viewName">
        </td>
    </tr>
    <tr>
        <td>資料庫類型<br>(database_type)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput" placeholder="mariadb" value=""
                               id="inspectorConfigInsert_information_databaseType">
        </td>
        <td>資料庫位置<br>(database_address)</td>
        <td colspan="2"><input type="text" style="height:30px" class="textInput"
                               placeholder="10.20.20.232:3306/wh_query" value=""
                               id="inspectorConfigInsert_information_databaseAddress">
        </td>
    </tr>
    <tr>
        <td>檢測即時性SQL<br>(check_immediate_sql)</td>
        <td colspan="5">
            <textarea id="inspectorConfigInsert_checkImmediateSql" name="inspectorConfigInsert_checkImmediateSql"
                      style="width:650px;height:200px "></textarea>

        </td>
    </tr>


    <tr>
        <%--<td><input type="button" class="btn btn-primary" onclick="doRequestUsingGET()" value="查詢"></td>--%>
        <td colspan="6"><a href="#" type="button" class="btn btn-primary" style="width:155px;height:30px;font-size:14px"
                           id="inspectorConfigInsert_insertConfig"><span>新增</span></a></td>

    </tr>
    </tbody>
</table>


</body>
</html>
<%--/*--%>
<%----索引庫名稱(index_name)--%>
<%--索引庫類型(同步、非同步等)(index_type)--%>
<%--索引庫資料的日期範圍(date_range)--%>
<%----資料庫類型(database_type)--%>
<%----資料庫位置(database_address)--%>
<%----view表名稱(view_name)--%>
<%--索引庫的即時性設定(分鐘)，預設0則不檢查即時性(immediate)--%>
<%--標準開關(standard_inspect_switch)--%>
<%--內部開關(staff_inspect_switch)--%>
<%--分流開關(advanced_inspect_switch)--%>
<%----檢查即時性的sql語法(check_immediate_sql)--%>
<%--*/--%>
