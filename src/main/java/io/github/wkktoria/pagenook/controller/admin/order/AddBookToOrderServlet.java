package io.github.wkktoria.pagenook.controller.admin.order;

import io.github.wkktoria.pagenook.dao.BookDAO;
import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.BookOrder;
import io.github.wkktoria.pagenook.entity.OrderDetail;
import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/add_book_to_order")
public class AddBookToOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        final int bookId = Integer.parseInt(request.getParameter("bookId"));
        final int quantity = Integer.parseInt(request.getParameter("quantity"));

        BookDAO bookDAO = new BookDAO();
        Book book = bookDAO.get(bookId);

        HttpSession session = request.getSession();
        BookOrder order = (BookOrder) session.getAttribute("order");

        final float subtotal = quantity * book.getPrice();

        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setBook(book);
        orderDetail.setQuantity(quantity);
        orderDetail.setSubtotal(subtotal);

        final float newTotal = order.getTotal() + subtotal;
        order.setTotal(newTotal);

        order.getOrderDetails().add(orderDetail);

        request.setAttribute("book", book);
        session.setAttribute("newBookPendingToAddToOrder", true);

        final String resultPage = "add_book_result.jsp";
        CommonUtil.forwardToPage(resultPage, request, response);
    }
}
