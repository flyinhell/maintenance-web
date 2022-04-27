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
<%
    RequestWrapper reqWrapper = new RequestWrapper(request);
    String act = reqWrapper.getParameter("act");
    String userAccount = reqWrapper.getParameter("account");
    AccountDAO accountDAO = new AccountDAO();
    AccountEntity accountEntity = new AccountEntity();

    accountEntity = accountDAO.getByUser(userAccount);

    request.setAttribute("act", act);
    request.setAttribute("accountEntity", accountEntity);

%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../include/util.jsp" %>
<script type="text/javascript">
    var args = "1=1";
    $(document).ready(function () {

        $("#edit").on("click", function () {
            if (!verification()) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: '../Management/MemberAction?',
                data: args,
                success: function (message) {
                    alert(message);
                    $.fn.colorbox.close();

                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("修改密碼失敗..");

                }
            });
        });

        $("#save").on("click", function () {
            if (!verificationEamil()) {
                return false;
            }

            $.ajax({
                type: "POST",
                url: '../Management/MemberAction?',
                data: args,
                success: function (message) {
                    if (message) {
                        alert(message);
                    }

                    $.fn.colorbox.close();

                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("修改信箱失敗..");
                }
            });
        });

    });

    function verificationEamil() {
        var verificaltionResult = true;
        var account = $('input[name="account"]');
        var password = $('input[name="password"]');
        var email = $('input[name="email"]');

        args = args + "&act=updateEmail";
        args = args + "&account=" + account.val();
        args = args + "&password=" + password.val();
        args = args + "&email=" + email.val();

        $('input[name="email"]').each(function (index) {
            args = args + "&email=" + $(this).val();
            if ($(this).val() != '') {
                if (!isEmail($(this).val())) {
                    $(this).focus();
                    alert("Email格式錯誤!");
                    verificaltionResult = false;
                }
                return;
            } else {
                $(this).focus();
                alert("Email不可為空白");
                verificaltionResult = false;
                return;
            }
        });

        if (password.val() == '') {
            password.focus();
            alert("密碼未填寫!");
            verificaltionResult = false;
            return;
        } else if (countChinese(password.val()) > 0) {
            alert("密碼不可包含中文!!");
            password.focus();
            verificaltionResult = false;
            return;
        }
        return verificaltionResult;
    }

    function verification() {
        var verificaltionResult = true;
        var account = $('input[name="account"]');
        var password = $('input[name="password"]');
        var newPassword = $('input[name="newPassword"]');
        var checkNewPassword = $('input[name="checkNewPassword"]');

        args = args + "&act=updatePassword";
        args = args + "&account=" + account.val();
        args = args + "&password=" + password.val();
        args = args + "&newPassword=" + newPassword.val();

        if (password.val() == '') {
            password.focus();
            alert("密碼未填寫!");
            verificaltionResult = false;
            return;
        } else if (countChinese(password.val()) > 0) {
            alert("密碼不可包含中文!!");
            password.focus();
            verificaltionResult = false;
            return;
        }

        if (newPassword.val() == '') {
            newPassword.focus();
            alert("新密碼未填寫!");
            verificaltionResult = false;
            return;
        } else if (countChinese(newPassword.val()) > 0) {
            alert("新密碼不可包含中文!!");
            newPassword.focus();
            verificaltionResult = false;
            return;
        } else if (newPassword.val() != checkNewPassword.val()) {
            alert("修改密碼不一致!!");
            newPassword.focus();
            verificaltionResult = false;
            return;
        }


        return verificaltionResult;
    }

    //計算中文字 字數
    function countChinese(word) {
        var count = 0;
        for (var i = 0; i < word.length; i++) {
            var ascNum = word.charCodeAt(i);
            //扣除常用符號和英文字母
            if (!(ascNum >= 32 && ascNum <= 126)) {
                count++;
            }
        }
        return count;
    }

</script>
<div>
    <form method="post" action="../Management/MemberAction" id="memberForm">
        <input type="hidden" name="act"
               value="<c:choose>
                            <c:when test="${act eq 'list'}">edit</c:when>
                            <c:otherwise>new</c:otherwise>
                            </c:choose>">
        <div id="addMemberDIV" class="clearfix" style="padding:10px; background:#fff;">
            <c:choose>
                <c:when test="${act eq 'updatePassword'}">
                    <div id="COMPSet" class="selectDIV">
                        <h2>請輸入以下資料：</h2>

                        <div class="form-horizontal clearfix">
                            <div class="control-group">
                                <label class="control-label">帳號名稱：</label>
                                <div class="controls">
                                    <input type="text" class="input-large textInput"
                                           name="account" value="${accountEntity.userName}" disabled="disabled">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">密碼：</label>
                                <div class="controls">
                                    <input type="password" class="input-large textInput"
                                           name="password" placeholder="請輸入密碼...">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">新密碼：</label>
                                <div class="controls">
                                    <input type="password" class="input-large textInput"
                                           name="newPassword" placeholder="請輸入新密碼...">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">確認新密碼：</label>
                                <div class="controls">
                                    <input type="password" class="input-large textInput"
                                           name="checkNewPassword" placeholder="請輸入新密碼...">
                                </div>
                            </div>

                        </div>
                    </div>
                    <!--form-horizontal-->
                    <div id="saveSet">
                        <a href="#" id="edit" class="btnstyleC"><span>儲存</span></a>
                        <a href="javascript:$.fn.colorbox.close();" class="btnstyleC"><span>取消</span></a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div id="COMPSet" class="selectDIV">
                        <h2>請輸入信箱：</h2>

                        <div class="form-horizontal clearfix">
                            <div class="control-group">
                                <label class="control-label">帳號名稱：</label>
                                <div class="controls">
                                    <input type="text" class="input-large textInput"
                                           name="account" value="${accountEntity.userName}" disabled="disabled">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">密碼：</label>
                                <div class="controls">
                                    <input type="password" class="input-large textInput"
                                           name="password" placeholder="請輸入密碼...">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">新信箱：</label>
                                <div class="controls">
                                    <input type="text" class="input-large textInput"
                                           name="email" placeholder="請輸入信箱...">
                                </div>
                            </div>


                        </div>
                    </div>
                    <!--form-horizontal-->
                    <div id="saveSet">
                        <a href="#" id="save" class="btnstyleC"><span>儲存</span></a>
                        <a href="javascript:$.fn.colorbox.close();" class="btnstyleC"><span>取消</span></a>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
        <!--selectDIV-->

    </form>
    <!--COMPcontent-->
</div>
