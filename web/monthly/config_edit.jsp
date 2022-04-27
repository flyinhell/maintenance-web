<%@ page import="com.eland.util.RequestWrapper" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eland.pojo.model.AccountEntity" %>
<%@ page import="com.eland.dao.AccountDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: wycai
  Date: 2015/5/27
  Time: 上午 11:03
  新增/修改 User 對應Auditor
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../include/util.jsp" %>

<div>
    <form method="post" action="../Management/MemberAction" id="memberForm">
        <div id="addMemberDIV" class="clearfix" style="padding:10px; background:#fff;">
            <div id="COMPSet" class="selectDIV">

                <div class="form-horizontal clearfix">
                    <div align="center" valign="center">
                        <input type="button" class="btn btn-primary" value="設定檔下載">
                        <input type="button" class="btn btn-warning" value="設定檔上傳">
                        <input type="button" class="btn btn-info" value="設定檔部署"></div>
                </div>
            </div>
            <!--form-horizontal-->
            <div id="saveSet">
                <a href="javascript:$.fn.colorbox.close();" class="btnstyleC"><span>離開</span></a>
            </div>
        </div>
        <!--selectDIV-->

    </form>
    <!--COMPcontent-->
</div>
