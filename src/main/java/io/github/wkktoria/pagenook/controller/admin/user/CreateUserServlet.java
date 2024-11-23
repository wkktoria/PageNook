package io.github.wkktoria.pagenook.controller.admin.user;

import io.github.wkktoria.pagenook.controller.admin.BaseServlet;
import io.github.wkktoria.pagenook.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/create_user")
public class CreateUserServlet extends BaseServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserService userService = new UserService(entityManagerFactory, request, response);
        userService.createUser();
    }
}
