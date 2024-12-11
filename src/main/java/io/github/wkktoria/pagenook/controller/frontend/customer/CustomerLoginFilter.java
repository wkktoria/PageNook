package io.github.wkktoria.pagenook.controller.frontend.customer;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class CustomerLoginFilter implements Filter {
    private static final String[] loginRequiredUrls = {
            "/view_profile", "/edit_profile", "/update_profile"
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
            final String loginPage = "frontend/login.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(loginPage);
            dispatcher.forward(request, response);
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
