package io.github.wkktoria.pagenook.controller.frontend.customer;

import io.github.wkktoria.pagenook.service.CustomerService;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class ShowCustomerRegisterFormServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerService customerService = new CustomerService(request, response);
        customerService.showCustomerRegistrationForm();
    }
}
