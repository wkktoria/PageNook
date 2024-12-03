package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.BookDAO;
import io.github.wkktoria.pagenook.entity.Book;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class BookService {
    private final BookDAO bookDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public BookService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        bookDAO = new BookDAO();
    }

    public void listBook() throws ServletException, IOException {
        List<Book> listBooks = bookDAO.listAll();

        request.setAttribute("listBook", listBooks);

        final String listPage = "book_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);

        dispatcher.forward(request, response);
    }
}
