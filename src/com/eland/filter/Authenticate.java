package com.eland.filter;

import com.eland.dao.AccountDAO;
import com.eland.pojo.model.AccountEntity;
import com.eland.pojo.view.UserInfo;
import com.eland.util.OpviewMaintenanceUtil;
import com.eland.util.RequestWrapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * 登入後判斷帳號資訊是否正確導向求要的頁面
 * User:sphsu
 * Date: 2013/1/18
 */
public class Authenticate extends HttpServlet {

    public static Logger log = LoggerFactory.getLogger(Authenticate.class);

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {
        RequestWrapper reqWrapper = new RequestWrapper(request);
        String userAccount = reqWrapper.getParameter("account", "");   //使用者輸入帳號
        String userPassword = reqWrapper.getParameter("password", ""); //使用者輸入密碼
        String target = reqWrapper.getParameter("target", "");          //導頁的url


        boolean isVerification = true;                                //是否通過驗證
        int errorCode = 0;                                             //錯誤訊息
        AccountDAO accountDAO = new AccountDAO();

        AccountEntity accountEntity = accountDAO.getByUserPassWord(userAccount, userPassword);
        UserInfo userInfo = new UserInfo();
        if (accountEntity == null) {
            errorCode = 1;
            isVerification = false;
        }

        if (isVerification) {
            response.setHeader("Expires", "0");
            response.setHeader("Pragma", "no-cache");
            response.setHeader("Cache-Control", "must-revalidate");
            int cookieMaxAge = OpviewMaintenanceUtil.getCookieLiveTime();
            Cookie userNameCookie = new Cookie("user_name", userAccount);
            userNameCookie.setPath("/");
            userNameCookie.setMaxAge(cookieMaxAge);
            response.addCookie(userNameCookie);

            String rememberMe = reqWrapper.getParameter("rememberMe", "false");          //是否記住帳號

            //如果有設定記住帳號就將remember塞進cookie，沒有的話就清掉cookie
            if (rememberMe.equals("true")) {
                Cookie remember = new Cookie("remember", URLEncoder.encode(userAccount, "utf-8"));
                remember.setPath("/");
                remember.setMaxAge(cookieMaxAge);
                response.addCookie(remember);
            } else {
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("remember")) {
                            cookie.setMaxAge(0);
                            cookie.setPath("/");
                            response.addCookie(cookie);
                        }
                    }
                }
            }


            //更新最後登入時間
            userInfo.setEmail(accountEntity.getEmail());
            userInfo.setUser(userAccount);

            HttpSession session = request.getSession();
            session.setAttribute("userInfo", userInfo);

            if (!target.equals("")) {
                response.sendRedirect(target);
            } else {
                response.sendRedirect("/OpviewMaintenance/Copy/CopyMainPage");
            }
            return;
        } else {
            if (errorCode != 0) {
                target += "&errorCode=" + errorCode;
            }
            response.sendRedirect("LogIn?target=" + target);
            return;
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
            IOException {

    }
}
