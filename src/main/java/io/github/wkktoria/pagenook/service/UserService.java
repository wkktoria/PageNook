package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.UserDAO;
import io.github.wkktoria.pagenook.entity.User;
import io.github.wkktoria.pagenook.util.CommonUtil;
import io.github.wkktoria.pagenook.util.HashGeneratorUtil;
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
        this.request = request;
        this.response = response;

        userDAO = new UserDAO();
    }

    public void listUser() throws ServletException, IOException {
        listUser(null);
    }

    public void listUser(String message) throws ServletException, IOException {
        List<User> userList = userDAO.listAll();

        request.setAttribute("listUser", userList);
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
            CommonUtil.showMessageBackend(message, request, response);
        } else {
            User newUser = new User(email, fullName, password);
            userDAO.create(newUser);
            listUser("New user has been created successfully.");
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
        } else {
            user.setPassword(null);
            request.setAttribute("user", user);
        }

        CommonUtil.forwardToPage(destinationPage, request, response);
    }

    public void updateUser() throws ServletException, IOException {
        final int userId = Integer.parseInt(request.getParameter("userId"));
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullname");
        String password = request.getParameter("password");

        User userByEmail = userDAO.findByEmail(email);

        if (userByEmail != null && !Objects.equals(userByEmail.getUserId(), userId)) {
            final String message = "Could not update user. User with email " + email + " already exists.";
            CommonUtil.showMessageBackend(message, request, response);
        } else {
            User userById = userDAO.get(userId);
            userById.setFullName(fullName);
            userById.setEmail(email);

            if (password != null && !password.isEmpty()) {
                userById.setPassword(HashGeneratorUtil.generateMD5(password));
            }

            userDAO.update(userById);
            listUser("User has been updated successfully.");
        }
    }

    public void deleteUser() throws ServletException, IOException {
        final int userId = Integer.parseInt(request.getParameter("id"));

        if (userDAO.get(userId) == null) {
            final String message = "Could not find user with ID " + userId + ".";
            CommonUtil.showMessageBackend(message, request, response);
        } else if (userId == 1) {
            final String message = "The default admin user account cannot be deleted.";
            CommonUtil.showMessageBackend(message, request, response);
        } else {
            userDAO.delete(userId);
            listUser("User has been deleted successfully.");
        }
    }

    public void login() throws ServletException, IOException {
        final String email = request.getParameter("email");
        final String password = request.getParameter("password");

        boolean loginResult = userDAO.checkLogin(email, password);

        if (loginResult) {
            request.getSession().setAttribute("useremail", email);
            CommonUtil.forwardToPage("/admin/", request, response);
        } else {
            final String message = "Login failed.";
            CommonUtil.forwardToPage("login.jsp", message, request, response);
        }
    }
}
