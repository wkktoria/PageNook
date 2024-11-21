package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.UserDAO;
import io.github.wkktoria.pagenook.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class UserService {
    private final UserDAO userDAO;
    private EntityManagerFactory entityManagerFactory;
    private EntityManager entityManager;
    private HttpServletRequest request;
    private HttpServletResponse response;

    public UserService(HttpServletRequest request, HttpServletResponse response) {
        entityManagerFactory = Persistence.createEntityManagerFactory("PageNook");
        entityManager = entityManagerFactory.createEntityManager();
        userDAO = new UserDAO(entityManager);

        this.request = request;
        this.response = response;
    }

    public void listUsers() throws ServletException, IOException {
        listUsers(null);
    }

    public void listUsers(String message) throws ServletException, IOException {
        List<User> userList = userDAO.listAll();

        request.setAttribute("listUsers", userList);
        request.setAttribute("message", message);

        final String listPage = "user_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
        dispatcher.forward(request, response);
    }

    public void createUser() throws ServletException, IOException {
        final String email = request.getParameter("email");
        final String fullName = request.getParameter("fullname");
        final String password = request.getParameter("password");

        if (userDAO.findByEmail(email) != null) {
            final String message = "Could not create user. A user with email " + email + " already exists.";
            request.setAttribute("message", message);

            RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
            dispatcher.forward(request, response);
        } else {
            User newUser = new User(email, fullName, password);
            userDAO.create(newUser);
            listUsers("New user has been created successfully.");
        }
    }
}
