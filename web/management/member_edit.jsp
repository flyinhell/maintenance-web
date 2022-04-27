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

    if (act.equals("editPassword")) {
        accountEntity = accountDAO.getByUser(userAccount);
    } else if (act.equals("editEmail")) {
        accountEntity = accountDAO.getByUser(userAccount);
    }
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
                url: '../Management/MemberAction?' + args,
                success: function (message) {
                    alert(message);
                    $.fn.colorbox.close();

                },
                error: function (jqXHR) {
                    if (jqXHR.status === 0) return;
                    alert("修改維運人員失敗,請重新再試..");
                }
            });
        });

        $("#editEmail").on("click", function () {
            if (!verificationEmail()) {
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
                    alert("修改維運人員失敗,請重新再試..");
                }
            });
        });

        $("#save").on("click", function () {
            isExistAccount($('input[name="account"]').val());
        });

    });

    function isExistAccount(account) {
        //判斷帳號名稱是否存在，若不存在則繼續後續判斷
        $.ajax({
            url: '../Management/MemberAccountCheck',
            data: "account=" + account,
            success: function (result) {

                <c:if test="${act ne 'editPassword'}">
                if ($.trim(result) != 'false') {
                    alert("帳號已存在，請更換帳號名稱");
                    $('input[name="account"]').focus();
                    return false;
                }
                </c:if>
                if (!verification()) {
                    return false;
                }
                $('#memberForm').submit();
                $.fn.colorbox.close();

            },
            error: function (jqXHR) {
                if (jqXHR.status === 0) return;
                alert("確認成員失敗,請稍後再試..");
            }
        });
    }

    function verification() {
        var verificaltionResult = true;
        var account = $('input[name="account"]');
        var password = $('input[name="password"]');
        var checkPassword = $('input[name="checkPassword"]');

        args = args + "&act=editPassword";
        args = args + "&account=" + account.val();
        args = args + "&password=" + password.val();

        if (account.val() == '') {
            account.focus();
            alert("帳號未填寫!");
            verificaltionResult = false;
            return;
        } else if (countChinese(account.val()) > 0) {
            alert("帳號不可包含中文!!");
            account.focus();
            verificaltionResult = false;
            return;
        }

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
        } else if (checkPassword.val() == '') {
            password.focus();
            alert("確認密碼未填寫!");
            verificaltionResult = false;
            return;
        } else if (password.val() != checkPassword.val()) {
            password.focus();
            alert("密碼未一致!");
            verificaltionResult = false;
            return;
        }

        return verificaltionResult;
    }

    function verificationEmail() {
        var verificaltionResult = true;
        var account = $('input[name="account"]');
        var email = $('input[name="email"]');


        args = args + "&act=editEmail";
        args = args + "&account=" + account.val();
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

        if (account.val() == '') {
            account.focus();
            alert("帳號未填寫!");
            verificaltionResult = false;
            return;
        } else if (countChinese(account.val()) > 0) {
            alert("帳號不可包含中文!!");
            account.focus();
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
                            <c:when test="${act eq 'editPassword'}">edit</c:when>
                            <c:otherwise>new</c:otherwise>
                            </c:choose>">

        <div id="addMemberDIV" class="clearfix" style="padding:10px; background:#fff;">
            <c:choose>
            <c:when test="${act eq 'editPassword'}">
            <div id="COMPSet" class="selectDIV">

                <div class="form-horizontal clearfix">
                    <div align="center" valign="center">
                        <!-- 使用者資訊-->
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
                            <label class="control-label">確認密碼：</label>
                            <div class="controls">
                                <input type="password" class="input-large textInput"
                                       name="checkPassword" placeholder="請再次輸入密碼...">
                            </div>
                        </div>

                            <%--<div class="control-group">--%>
                            <%--<label class="control-label">郵件地址：</label>--%>
                            <%--<div class="controls">--%>
                            <%--<input type="text" class="input-large textInput"--%>
                            <%--name="email" value="${accountEntity.email}">--%>
                            <%--</div>--%>
                            <%--</div>--%>

                    </div>
                </div>
                <!--form-horizontal-->
                <div id="saveSet">
                    <a href="#" id="edit" class="btnstyleC"><span>儲存</span></a>
                    <a href="javascript:$.fn.colorbox.close();" class="btnstyleC"><span>取消</span></a>
                </div>

                </c:when>
                <c:when test="${act eq 'editEmail'}">
                <div id="COMPSet" class="selectDIV">

                    <div class="form-horizontal clearfix">
                        <div align="center" valign="center">
                            <!-- 使用者資訊-->
                            <div class="control-group">
                                <label class="control-label">帳號名稱：</label>

                                <div class="controls">
                                    <input type="text" class="input-large textInput"
                                           name="account" value="${accountEntity.userName}" disabled="disabled">
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">郵件地址：</label>

                                <div class="controls">
                                    <input type="text" class="input-large textInput"
                                           name="email" value="${accountEntity.email}">
                                </div>
                            </div>

                        </div>
                    </div>
                    <!--form-horizontal-->
                    <div id="saveSet">
                        <a href="#" id="editEmail" class="btnstyleC"><span>儲存</span></a>
                        <a href="javascript:$.fn.colorbox.close();" class="btnstyleC"><span>取消</span></a>
                    </div>
                    </c:when>

                    <c:otherwise>
                        <div id="COMPSet" class="selectDIV">
                            <h2>請輸入以下資料：</h2>

                            <div class="form-horizontal clearfix">
                                <div class="control-group">
                                    <label class="control-label">使用者帳號名稱：</label>

                                    <div class="controls">
                                        <input type="text" class="input-large textInput"
                                               name="account" placeholder="請輸入顯示名稱...">
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
                                    <label class="control-label">確認密碼：</label>

                                    <div class="controls">
                                        <input type="password" class="input-large textInput"
                                               name="checkPassword" placeholder="請再輸入密碼...">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">使用者郵件地址：</label>

                                    <div class="controls">
                                        <input type="text" class="input-large textInput"
                                               name="email" placeholder="請輸入郵件地址...">
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
