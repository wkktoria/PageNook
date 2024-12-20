package io.github.wkktoria.pagenook.controller.admin.order;

import io.github.wkktoria.pagenook.dao.BookDAO;
import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/add_book_form")
public class ShowAddBookFormServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookDAO bookDAO = new BookDAO();
        List<Book> listBook = bookDAO.listAll();
        request.setAttribute("listBook", listBook);

        final String addFormPage = "add_book_form.jsp";
        CommonUtil.forwardToPage(addFormPage, request, response);
    }
}
