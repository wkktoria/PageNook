package io.github.wkktoria.pagenook.controller.admin.book;

import io.github.wkktoria.pagenook.service.BookService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;

@WebServlet("/admin/create_book")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024,
        maxRequestSize = 1024 * 1024
)
public class CreateBookServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookService bookService = new BookService(request, response);
        try {
            bookService.createBook();
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
    }
}
