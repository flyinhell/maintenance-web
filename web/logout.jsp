<%@ page contentType="text/html; charset=UTF-8" language="java" session="true" %>
<%
    request.setCharacterEncoding("utf-8");
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server

    //清除Session
    session.invalidate();

    //將cookie清除，即存活時間設為0
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("user_name")) {
                cookie.setMaxAge(0);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
        }
    }
    response.sendRedirect("LogIn");
    return;
%>