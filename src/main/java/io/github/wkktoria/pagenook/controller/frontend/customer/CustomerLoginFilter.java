package io.github.wkktoria.pagenook.controller.frontend.customer;

import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class CustomerLoginFilter implements Filter {
    private static final String[] loginRequiredUrls = {
            "/view_profile", "/edit_profile", "/update_profile", "/write_review"
    };

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);

        final String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        if (path.startsWith("/admin/")) {
            chain.doFilter(request, response);
            return;
        }

        boolean loggedIn = session != null && session.getAttribute("loggedCustomer") != null;

        final String requestUrl = httpRequest.getRequestURL().toString();

        if (!loggedIn && isLoginRequired(requestUrl)) {
            final String queryString = httpRequest.getQueryString();
            String redirectUrl = requestUrl;

            if (queryString != null) {
                redirectUrl = redirectUrl.concat("?").concat(queryString);
            }

            session.setAttribute("redirectUrl", redirectUrl);

            final String loginPage = "frontend/login.jsp";
            CommonUtil.forwardToPage(loginPage, (HttpServletRequest) request, (HttpServletResponse) response);
        } else {
            chain.doFilter(request, response);
        }
    }

    private boolean isLoginRequired(final String requestUrl) {
        for (String loginRequiredUrl : loginRequiredUrls) {
            if (requestUrl.contains(loginRequiredUrl)) {
                return true;
            }
        }
        return false;
    }
}
