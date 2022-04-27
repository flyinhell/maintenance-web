<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="com.eland.dao.ViewIndexCustomInformationDAO" %>
<%@ page import="com.eland.pojo.model.VwIndexCustomInformationEntity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.eland.dao.CustomIndexCopyTaskDAO" %>
<%@ page import="com.eland.dao.CustomIndexCopyTaskKhcDevDAO" %>

<%--
  Created by IntelliJ IDEA.
  User: johnnyhuang
  Date: 2018/3/7
  Time: 上午 09:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../include/util.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<head>
    <script src="../js/sorttable.js"></script>
    <style type="text/css">
        /* Sortable tables */
        table.sortable thead {
            color: #000000;
            cursor: default;
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
        $(document).ready(function () {
            $("#inline").fancybox({});
            $(".iframe").colorbox({iframe: true, width: "80%", height: "80%"});
        });
    </script>
</head>

<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String type = reqWrapper.getParameter("type");
    int totalSize = 0;      //資料總筆數
    ViewIndexCustomInformationDAO ViewIndexCustomInformationDAO = new ViewIndexCustomInformationDAO();
    //未完成任務或失敗任務搜尋
    if (type.equals("unfinishedBuildIndexStatus")) {
        List<VwIndexCustomInformationEntity> indexStatusList = new LinkedList<VwIndexCustomInformationEntity>();
        try {
            indexStatusList = ViewIndexCustomInformationDAO.selectUnfinishedTask();
            indexStatusList.get(0).getSize();
            //  System.out.println("indexStatusList:"+indexStatusList);
            totalSize = indexStatusList.size();
            //  System.out.println("totalSize:"+totalSize);

        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexStatusList", indexStatusList);
        request.setAttribute("totalSize", totalSize);
        //自訂搜尋條件
    } else if (type.equals("definedCondition")) {
        String condition = new String(request.getParameter("condition").getBytes("ISO8859-1"), "UTF-8");
        List<VwIndexCustomInformationEntity> indexStatusList = new LinkedList<VwIndexCustomInformationEntity>();
        try {
            indexStatusList = ViewIndexCustomInformationDAO.selectByUserDefined(condition);
            totalSize = indexStatusList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexStatusList", indexStatusList);
        request.setAttribute("totalSize", totalSize);
        //依索引名稱搜尋條件
    } else if (type.equals("indexName")) {
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        String startTime = reqWrapper.getParameter("startTime");
        String endTime = reqWrapper.getParameter("endTime");
        String sortField = reqWrapper.getParameter("sortField");
        String sortType = reqWrapper.getParameter("sortType");

        List<VwIndexCustomInformationEntity> indexStatusList = new LinkedList<VwIndexCustomInformationEntity>();

        try {
            indexStatusList = ViewIndexCustomInformationDAO.selectByIndexName(indexName, startTime, endTime, sortField, sortType);
            totalSize = indexStatusList.size();
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexStatusList", indexStatusList);
        request.setAttribute("totalSize", totalSize);
    } else if (type.equals("indexStatus_update")){
        String indexName = new String(request.getParameter("indexName").getBytes("ISO8859-1"), "UTF-8");
        List<VwIndexCustomInformationEntity> indexStatusList = new LinkedList<VwIndexCustomInformationEntity>();
        CustomIndexCopyTaskDAO customIndexCopyTaskDAO = new CustomIndexCopyTaskDAO();
        try {
            if(!indexName.equals("")){
                customIndexCopyTaskDAO.updateStatus(indexName);
                indexStatusList = ViewIndexCustomInformationDAO.selectByIndexName(indexName,"","", "start_time", "desc");
                totalSize = indexStatusList.size();
            }
        } catch (Exception e) {
            logger.error("搜尋歷史紀錄 發生錯誤：", e);
        }
        request.setAttribute("indexStatusList", indexStatusList);
        request.setAttribute("totalSize", totalSize);
    }
%>

<body>
<%--<div style="font-size: 3px">--%>
<c:choose>
    <c:when test="${totalSize > 0}">
        <table class="sortable">
            <thead>
            <tr>
                <th style="padding:2px;" width="210">索引名稱<br>(index_name)</th>
                <th style="padding:2px;" width="190">建立時間<br>(start_time)</th>
                <th style="padding:2px;" width="120">建立狀況<br>(status)</th>
                <th style="padding:2px;" width="120">資料筆數<br>(records)</th>
                <th style="padding:2px;" width="120">複製機器<br>(copy_machine_name)</th>
                <th style="padding:2px;" width="120">複製狀況<br>(copy_status)</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${indexStatusList}" var="indexStatusList" begin="0" end="${totalSize-1}">
                <tr>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.indexName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.startTime}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.status}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.records}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.copyMachineName}</td>
                    <td style="padding: 6px;border-bottom: 1px solid #ddd">
                            ${indexStatusList.copyStatus}</td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <strong>找不到符合的資料</strong>
    </c:otherwise>
</c:choose>

<%--</div>--%>
</body>
