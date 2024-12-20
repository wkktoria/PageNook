package io.github.wkktoria.pagenook.controller.admin;

import io.github.wkktoria.pagenook.dao.*;
import io.github.wkktoria.pagenook.entity.BookOrder;
import io.github.wkktoria.pagenook.entity.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import static io.github.wkktoria.pagenook.util.CommonUtil.forwardToPage;

@WebServlet("/admin/")
public class AdminHomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO orderDAO = new OrderDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        UserDAO userDAO = new UserDAO();
        BookDAO bookDAO = new BookDAO();
        CustomerDAO customerDAO = new CustomerDAO();

        List<BookOrder> listMostRecentSales = orderDAO.listMostRecentSales();
        request.setAttribute("listMostRecentSales", listMostRecentSales);

        List<Review> listMostRecentReviews = reviewDAO.listMostRecent();
        request.setAttribute("listMostRecentReviews", listMostRecentReviews);

        long totalUsers = userDAO.count();
        request.setAttribute("totalUsers", totalUsers);

        long totalBooks = bookDAO.count();
        request.setAttribute("totalBooks", totalBooks);

        long totalCustomers = customerDAO.count();
        request.setAttribute("totalCustomers", totalCustomers);

        long totalReviews = reviewDAO.count();
        request.setAttribute("totalReviews", totalReviews);

        long totalOrders = orderDAO.count();
        request.setAttribute("totalOrders", totalOrders);

        final String homepage = "index.jsp";
        forwardToPage(homepage, request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
