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
import java.util.Objects;

public class UserService {
    private final UserDAO userDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public UserService(HttpServletRequest request, HttpServletResponse response) {
        EntityManagerFactory entityManagerFactory = Persistence
                .createEntityManagerFactory("PageNook");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
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

    public void editUser() throws ServletException, IOException {
        final int userId = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.get(userId);
        request.setAttribute("user", user);

        String destinationPage = "user_form.jsp";

        if (user == null) {
            destinationPage = "message.jsp";

            final String message = "Could not find user with ID " + userId + ".";
            request.setAttribute("message", message);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(destinationPage);
        dispatcher.forward(request, response);
    }

    public void updateUser() throws ServletException, IOException {
        final int userId = Integer.parseInt(request.getParameter("userId"));
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullname");
        String password = request.getParameter("password");

        User userById = userDAO.get(userId);
        User userByEmail = userDAO.findByEmail(email);

        if (userByEmail != null && !Objects.equals(userByEmail.getUserId(), userById.getUserId())) {
            final String message = "Could not update user. User with email " + email + " already exists.";
            request.setAttribute("message", message);

            RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
            dispatcher.forward(request, response);
        } else {
            User user = new User(userId, email, fullName, password);
            userDAO.update(user);
            listUsers("User has been updated successfully.");
        }
    }

    public void deleteUser() throws ServletException, IOException {
        final int userId = Integer.parseInt(request.getParameter("id"));

        if (userDAO.get(userId) == null) {
            final String message = "Could not find user with ID " + userId + ".";
            request.setAttribute("message", message);

            RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
            dispatcher.forward(request, response);
        } else if (userId == 1) {
            final String message = "The default admin user account cannot be deleted.";
            request.setAttribute("message", message);

            RequestDispatcher dispatcher = request.getRequestDispatcher("message.jsp");
            dispatcher.forward(request, response);
        } else {
            userDAO.delete(userId);
            listUsers("User has been deleted successfully.");
        }
    }
}
