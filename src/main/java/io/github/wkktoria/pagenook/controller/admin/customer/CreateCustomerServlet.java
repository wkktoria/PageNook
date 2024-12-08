package io.github.wkktoria.pagenook.controller.admin.customer;

import io.github.wkktoria.pagenook.service.CustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/create_customer")
public class CreateCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerService customerService = new CustomerService(request, response);
        customerService.createCustomer();
    }
}
