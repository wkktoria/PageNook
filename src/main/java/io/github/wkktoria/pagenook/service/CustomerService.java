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

    public void listCustomers(final String message) throws ServletException, IOException {
        List<Customer> listCustomer = customerDAO.listAll();

        if (message != null) {
            request.setAttribute("message", message);
        }

        request.setAttribute("listCustomer", listCustomer);

        final String listPage = "customer_list.jsp";
        CommonUtil.forwardToPage(listPage, request, response);
    }

    public void listCustomers() throws ServletException, IOException {
        listCustomers(null);
    }

    public void createCustomer() throws ServletException, IOException {
        final String email = request.getParameter("email");
        Customer existingCustomer = customerDAO.findByEmail(email);

        if (existingCustomer != null) {
            final String message = "Could not crete new customer. The email " + email + " is already registered by another customer.";
            listCustomers(message);
        } else {
            final String fullName = request.getParameter("fullname");
            final String password = request.getParameter("password");
            final String phone = request.getParameter("phone");
            final String address = request.getParameter("address");
            final String city = request.getParameter("city");
            final String zipCode = request.getParameter("zipcode");
            final String country = request.getParameter("country");

            Customer newCustomer = new Customer();
            newCustomer.setEmail(email);
            newCustomer.setFullname(fullName);
            newCustomer.setPassword(password);
            newCustomer.setPhone(phone);
            newCustomer.setAddress(address);
            newCustomer.setCity(city);
            newCustomer.setZipcode(zipCode);
            newCustomer.setCountry(country);

            customerDAO.create(newCustomer);

            final String message = "New customer has been created successfully.";
            listCustomers(message);
        }
    }
}
