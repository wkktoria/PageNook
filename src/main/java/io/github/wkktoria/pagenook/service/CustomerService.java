package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.CustomerDAO;
import io.github.wkktoria.pagenook.dao.OrderDAO;
import io.github.wkktoria.pagenook.dao.ReviewDAO;
import io.github.wkktoria.pagenook.entity.Customer;
import io.github.wkktoria.pagenook.util.CommonUtil;
import io.github.wkktoria.pagenook.util.HashGeneratorUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.*;

public class CustomerService {
    private final CustomerDAO customerDAO;
    private final ReviewDAO reviewDAO;
    private final OrderDAO orderDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public CustomerService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        customerDAO = new CustomerDAO();
        reviewDAO = new ReviewDAO();
        orderDAO = new OrderDAO();
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
            Customer newCustomer = new Customer();
            readCustomerFields(newCustomer);

            customerDAO.create(newCustomer);

            final String message = "New customer has been created successfully.";
            listCustomers(message);
        }
    }

    public void editCustomer() throws ServletException, IOException {
        final Integer customerId = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerDAO.get(customerId);

        String destinationPage = "customer_form.jsp";

        if (customer == null) {
            destinationPage = "message.jsp";

            final String message = "Could not find customer with ID " + customerId + ".";
            request.setAttribute("message", message);
        } else {
            generateCountryList();
            request.setAttribute("customer", customer);
        }

        CommonUtil.forwardToPage(destinationPage, request, response);
    }

    public void updateCustomer() throws ServletException, IOException {
        final Integer customerId = Integer.parseInt(request.getParameter("customerId"));
        final String email = request.getParameter("email");

        Customer customerByEmail = customerDAO.findByEmail(email);

        String message;

        if (customerByEmail != null && !Objects.equals(customerByEmail.getCustomerId(), customerId)) {
            message = "Could not update the customer with ID " + customerId
                    + ", because there's an existing customer having the same email.";
        } else {
            Customer customerById = customerDAO.get(customerId);
            readCustomerFields(customerById);

            customerDAO.update(customerById);

            message = "The customer has been updated successfully.";
        }

        listCustomers(message);
    }

    public void deleteCustomer() throws ServletException, IOException {
        final int customerId = Integer.parseInt(request.getParameter("id"));

        if (customerDAO.get(customerId) == null) {
            final String message = "Could not find customer with ID " + customerId
                    + ", or it has been deleted by another admin.";
            CommonUtil.showMessageBackend(message, request, response);
        } else {
            long reviewCount = reviewDAO.countByCustomer(customerId);
            long orderCount = orderDAO.countByCustomer(customerId);

            if (reviewCount > 0) {
                final String message = "Could not delete the customer with ID " + customerId + ", because he/she posted reviews for books.";
                CommonUtil.showMessageBackend(message, request, response);
            } else if (orderCount > 0) {
                final String message = "Could not delete customer with ID " + customerId + ", because he/she placed orders.";
                CommonUtil.showMessageBackend(message, request, response);
            } else {
                customerDAO.delete(customerId);
                listCustomers("Customer has been deleted successfully.");
            }
        }
    }

    public void registerCustomer() throws ServletException, IOException {
        final String email = request.getParameter("email");
        Customer existingCustomer = customerDAO.findByEmail(email);
        String message;

        if (existingCustomer != null) {
            message = "Could not register. The email " + email + " is already registered by another customer.";
        } else {
            Customer newCustomer = new Customer();
            readCustomerFields(newCustomer);

            customerDAO.create(newCustomer);

            message = "You have registered successfully. Thank you.<br/>"
                    + "<a href='login'>Click here</a> to login.";
        }

        CommonUtil.showMessageFrontend(message, request, response);
    }

    public void showLogin() throws ServletException, IOException {
        final String loginPage = "frontend/login.jsp";

        RequestDispatcher dispatcher = request.getRequestDispatcher(loginPage);
        dispatcher.forward(request, response);
    }

    public void doLogin() throws ServletException, IOException {
        final String email = request.getParameter("email");
        final String password = request.getParameter("password");

        Customer customer = customerDAO.checkLogin(email, password);

        if (customer == null) {
            final String message = "Login failed. Please check your email and password.";
            request.setAttribute("message", message);
            showLogin();
        } else {
            HttpSession session = request.getSession();
            request.getSession().setAttribute("loggedCustomer", customer);
            Object objectRedirectUrl = session.getAttribute("redirectUrl");

            if (objectRedirectUrl != null) {
                final String redirectUrl = objectRedirectUrl.toString();
                session.removeAttribute("redirectUrl");
                response.sendRedirect(redirectUrl);
            } else {
                showCustomerProfile();
            }
        }
    }

    public void showCustomerProfile() throws ServletException, IOException {
        final String profilePage = "frontend/customer_profile.jsp";
        CommonUtil.forwardToPage(profilePage, request, response);
    }

    public void showCustomerProfileEditForm() throws ServletException, IOException {
        final String editPage = "frontend/edit_profile.jsp";
        CommonUtil.forwardToPage(editPage, request, response);
    }

    public void updateCustomerProfile() throws ServletException, IOException {
        Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
        readCustomerFields(customer);
        customerDAO.update(customer);
        showCustomerProfile();
    }

    public void newCustomer() throws ServletException, IOException {
        generateCountryList();

        final String customerForm = "customer_form.jsp";
        CommonUtil.forwardToPage(customerForm, request, response);
    }

    public void showCustomerRegistrationForm() throws ServletException, IOException {
        generateCountryList();

        final String registerForm = "frontend/register_form.jsp";
        CommonUtil.forwardToPage(registerForm, request, response);
    }

    private void readCustomerFields(Customer customer) {
        final String email = request.getParameter("email");
        final String firstname = request.getParameter("firstname");
        final String lastname = request.getParameter("lastname");
        final String password = request.getParameter("password");
        final String phone = request.getParameter("phone");
        final String addressLine1 = request.getParameter("address1");
        final String addressLine2 = request.getParameter("address2");
        final String city = request.getParameter("city");
        final String state = request.getParameter("state");
        final String zipCode = request.getParameter("zipcode");
        final String country = request.getParameter("country");

        if (email != null && !email.isEmpty()) {
            customer.setEmail(email);
        }

        customer.setFirstname(firstname);
        customer.setLastname(lastname);
        customer.setPassword(password);
        customer.setPhone(phone);
        customer.setAddressLine1(addressLine1);
        customer.setAddressLine2(addressLine2);
        customer.setCity(city);
        customer.setState(state);
        customer.setZipcode(zipCode);
        customer.setCountry(country);
    }

    private void generateCountryList() {
        String[] countryCodes = Locale.getISOCountries();
        Map<String, String> mapCountries = new TreeMap<>();

        for (String countryCode : countryCodes) {
            Locale locale = Locale.forLanguageTag("und-" + countryCode);
            String code = locale.getCountry();
            String name = locale.getDisplayCountry();
            mapCountries.put(name, code);
        }

        request.setAttribute("mapCountries", mapCountries);
    }
}
