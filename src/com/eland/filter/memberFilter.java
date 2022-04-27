package com.eland.filter;

import com.eland.dao.AccountDAO;
import com.eland.pojo.model.AccountEntity;
import com.eland.pojo.view.UserInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * cookie參數檢查，檢查成功後會將參數放入session或request的attribute中
 * User: danielhsieh
 * Date: 2013/1/18
 * Time: 上午 10:04
 */
public class memberFilter implements Filter {

    FilterConfig filterConfig = null;
    public static Logger log = LoggerFactory.getLogger(memberFilter.class);

    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException,
            IOException {

        HttpServletRequest httpReq = (HttpServletRequest) req;
        HttpServletResponse httpResp = (HttpServletResponse) resp;
        boolean cookieAlive = false;
        Cookie[] cookies = httpReq.getCookies();

        String uName = "";
        //將cookie參數放入request scope中
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("user_name")) {
                    String value = cookie.getValue();
                    if (value != null && !value.equals("")) {
                        uName = value;
                        cookieAlive = true;
                    } else {
                        cookieAlive = false;
                        break;
                    }
                }
            }
        }

        String targetUri = httpReq.getRequestURI();
        if (!cookieAlive) {

            //若不存在任何cookie參數，代表尚未登入或過期，請重新登入
            httpResp.sendRedirect("../LogIn?target=" + targetUri);
            return;
        } else {

            //如果session內，使用者資訊物件遺失，再取cookie值重新塞入
            HttpSession session = httpReq.getSession();
            UserInfo userInfo = (UserInfo) session.getAttribute("userInfo");


            if (userInfo == null) {
                AccountDAO accountDAO = new AccountDAO();
                AccountEntity accountEntity = accountDAO.getByUser(uName);

                userInfo = new UserInfo();
                userInfo.setUser(uName);
                userInfo.setEmail(accountEntity.getEmail());

                session.setAttribute("userInfo", userInfo);
            }


            String url = httpReq.getRequestURL().toString();

            session.setAttribute("url", url);

            if (!url.equals("")) {
                try {
                    //更新最後登入時間

                    chain.doFilter(req, resp);
                } catch (Exception e) {
                    log.error("頁面發生錯誤： 使用者帳號=" + uName, e);
                    httpReq.getRequestDispatcher("../errorpages/500.jsp").forward(req, resp);
                } finally {
                    MDC.clear();
                }
            } else {
                httpResp.sendRedirect("../Check/CheckMainPage");
            }
        }
    }


}
