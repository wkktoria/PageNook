package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.CustomerDAO;
import io.github.wkktoria.pagenook.entity.Customer;
import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class CustomerService {
    private final CustomerDAO customerDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public CustomerService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        customerDAO = new CustomerDAO();
    }

    public void listCustomers() throws ServletException, IOException {
        List<Customer> listCustomer = customerDAO.listAll();

        request.setAttribute("listCustomer", listCustomer);

        final String listPage = "customer_list.jsp";
        CommonUtil.forwardToPage(listPage, request, response);
    }
}
