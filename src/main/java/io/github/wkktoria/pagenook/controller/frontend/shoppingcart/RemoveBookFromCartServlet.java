package io.github.wkktoria.pagenook.controller.frontend.shoppingcart;

import io.github.wkktoria.pagenook.dao.BookDAO;
import io.github.wkktoria.pagenook.entity.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/remove_from_cart")
public class RemoveBookFromCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("bookId"));

        Object cartObject = request.getSession().getAttribute("cart");

        ShoppingCart shoppingCart = (ShoppingCart) cartObject;

        BookDAO bookDAO = new BookDAO();
        Book book = bookDAO.get(bookId);

        shoppingCart.removeItem(book);

        final String cartPage = request.getContextPath().concat("/view_cart");
        response.sendRedirect(cartPage);
    }
}
