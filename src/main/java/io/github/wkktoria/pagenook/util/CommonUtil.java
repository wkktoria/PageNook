package io.github.wkktoria.pagenook.util;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class CommonUtil {
    public static void forwardToPage(final String page, final String message, HttpServletRequest request,
                                     HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("message", message);
        request.getRequestDispatcher(page).forward(request, response);
    }

    public static void forwardToPage(final String page, HttpServletRequest request,
                                     HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher(page).forward(request, response);
    }

    public static void showMessageFrontend(final String message, HttpServletRequest request,
                                           HttpServletResponse response) throws ServletException, IOException {
        forwardToPage("frontend/message.jsp", message, request, response);
    }

    public static void showMessageBackend(final String message, HttpServletRequest request,
                                          HttpServletResponse response) throws ServletException, IOException {
        forwardToPage("message.jsp", message, request, response);
    }
}
