<%@ page import="org.slf4j.LoggerFactory" %>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  User: wycai
  Date: 2015/4/15
  Time: 上午 11:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public static SimpleDateFormat sfYMD = new SimpleDateFormat("yyyy-MM-dd");
    public static SimpleDateFormat sfYMDhms = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static SimpleDateFormat sfYM = new SimpleDateFormat("yyMM");
    public static Logger logger = LoggerFactory.getLogger("web");
    final int perPageRecord = 10; // 顯示幾筆資料
%>

