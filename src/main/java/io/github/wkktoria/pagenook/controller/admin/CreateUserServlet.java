package io.github.wkktoria.pagenook.controller.admin;

import io.github.wkktoria.pagenook.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/create_user")
public class CreateUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final String email = request.getParameter("email");
        final String fullName = request.getParameter("fullname");
        final String password = request.getParameter("password");

        UserService userService = new UserService(request, response);
        userService.createUser(email, fullName, password);
        userService.listUsers("New user has been created successfully.");
    }
}
