<%--
  User: wycai
  Date: 2015/4/15
  Time: 上午 11:21
  分頁顯示
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int showPages = 3;                                            //顯示目前頁碼的前後的幾頁
    if (totalSize > 0 && perPageRecord > 0 && recordFrom >= 0) {
        int totalPage = totalSize / perPageRecord;                //總共有多少頁
        if (totalSize % perPageRecord != 0) {
            totalPage = totalPage + 1;
        }
        int currentPage = recordFrom / perPageRecord + 1;         //算出目前頁數
        request.setAttribute("currentPage", currentPage);          // 存放目前頁面
        request.setAttribute("totalPage", totalPage);              //存放最後一頁
        request.setAttribute("showPages", showPages);             //存放目前頁碼的前後幾頁
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${totalPage>=1}"> <!--如果總頁數大於1才會進入執行分頁-->
    <div class="sabrosus">
        <c:if test="${currentPage>1}"> <!--判斷是否有上一頁及第一頁可click的button-->
            <a href="#" onclick="switchSearchMode((${currentPage-2}));" title="上一頁"><i class="icon-caret-left"></i></a>
            <a href="#" onclick="switchSearchMode(0);" title="第1頁">1</a>
        </c:if>
        <c:if test="${currentPage-showPages>showPages-1}"> <!--計算目前顯示的頁面前面是否還有頁面，以...顯示-->
            <span class="notClick">...</span>
        </c:if>
        <c:forEach var="pageNumber" begin="${currentPage-showPages<1?1:currentPage-showPages}"
                   end="${currentPage+showPages<=totalPage-1?currentPage+showPages:totalPage}">
            <c:if test="${pageNumber eq currentPage}"> <!--目前頁面-->
                <span class="current">${currentPage}</span>
            </c:if>
            <c:if test="${(pageNumber != 1) && (pageNumber != totalPage) && (pageNumber != currentPage)}"> <!--顯示目前頁面的前三頁及後三頁剔除第一頁及最後一頁-->
                <a href="#" onclick="switchSearchMode(${pageNumber-1});" title="跳到第${pageNumber}頁">${pageNumber}</a>
            </c:if>
        </c:forEach>
        <c:if test="${currentPage+showPages < totalPage-1}"> <!--計算目前顯示的頁面後面是否還有頁面，以...顯示-->
            <span class="notClick">...</span>
        </c:if>
        <c:if test="${currentPage<totalPage }"> <!--判斷是否為最後一頁，如果不是的話會顯示下一頁button及最後一頁可click的button-->
            <a href="#" onclick="switchSearchMode((${totalPage}-1));" title="最後一頁">${totalPage}</a>
            <a href="#" onclick="switchSearchMode((${currentPage}));" title="下一頁"><i class="icon-caret-right"></i></a>
        </c:if>
        <div class="jumpPage">
            <span>跳轉到：第</span>
            <select id="inputPage" class="input-mini" placeholder="選擇頁面"> <!--選擇跳轉頁面的下拉式選單-->
                <c:forEach var="pageNumber" begin="1" end="${totalPage}"> <!--下拉式選單中的資料-->
                    <option value="${pageNumber}" <c:if
                            test="${pageNumber eq currentPage}"> selected="selected"</c:if>>${pageNumber}</option>
                </c:forEach>
            </select>
            <span>頁</span>
            <a href="#" onclick="switchSearchMode((document.getElementById('inputPage').value-1))">GO</a>
            <!--讀取使用者選取的頁面資料進行頁面跳轉-->
        </div>
    </div>
</c:if>