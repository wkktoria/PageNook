package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.BookDAO;
import io.github.wkktoria.pagenook.dao.CategoryDAO;
import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.Category;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class BookService {
    private final BookDAO bookDAO;
    private final CategoryDAO categoryDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public BookService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
    }

    public void listBook(final String message) throws ServletException, IOException {
        List<Book> listBooks = bookDAO.listAll();
        request.setAttribute("listBook", listBooks);

        if (message != null) {
            request.setAttribute("message", message);
        }

        final String listPage = "book_list.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);

        dispatcher.forward(request, response);
    }

    public void listBook() throws ServletException, IOException {
        listBook(null);
    }

    public void showBookNewForm() throws ServletException, IOException {
        List<Category> listCategory = categoryDAO.listAll();
        request.setAttribute("listCategory", listCategory);

        final String newPage = "book_form.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(newPage);
        dispatcher.forward(request, response);
    }

    public void createBook() throws ParseException, ServletException, IOException {
        final String title = request.getParameter("title");
        Book existingBook = bookDAO.findByTitle(request.getParameter("title"));

        if (existingBook != null) {
            final String message = "Could not crete new book, because the book with title " + title + " already exists.";
            listBook(message);
            return;
        }

        Book newBook = new Book();
        readBookFields(newBook);

        Book createdBook = bookDAO.create(newBook);

        if (createdBook != null && createdBook.getBookId() > 0) {
            final String message = "A new book has been created successfully.";
            listBook(message);
        }
    }

    public void editBook() throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("id"));
        Book book = bookDAO.get(bookId);

        String destinationPage = "book_form.jsp";

        if (book == null) {
            destinationPage = "message.jsp";

            final String message = "Could not find book with ID " + bookId + ".";
            request.setAttribute("message", message);
        } else {
            List<Category> listCategory = categoryDAO.listAll();

            request.setAttribute("book", book);
            request.setAttribute("listCategory", listCategory);

        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(destinationPage);
        dispatcher.forward(request, response);
    }

    public void updateBook() throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("bookId"));
        final String title = request.getParameter("title");

        Book existingBook = bookDAO.get(bookId);
        Book bookByTitle = bookDAO.findByTitle(title);

        if (!existingBook.equals(bookByTitle)) {
            final String message = "Could not update book, because there's another book having the same title.";
            listBook(message);

            return;
        }

        readBookFields(existingBook);

        bookDAO.update(existingBook);

        final String message = "The book has been updated successfully.";
        listBook(message);
    }

    private void readBookFields(Book book) throws ServletException, IOException {
        final String title = request.getParameter("title");
        final String author = request.getParameter("author");
        final String description = request.getParameter("description");
        final String isbn = request.getParameter("isbn");
        float price = Float.parseFloat(request.getParameter("price"));

        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        Date publishDate;
        try {
            publishDate = dateFormat.parse(request.getParameter("publishDate"));
        } catch (ParseException e) {
            e.printStackTrace();
            throw new ServletException("Error parsing publish date (format is MM/dd/yyyy)");
        }

        book.setTitle(title);
        book.setAuthor(author);
        book.setDescription(description);
        book.setIsbn(isbn);
        book.setPrice(price);
        book.setPublishDate(publishDate);

        final Integer categoryId = Integer.parseInt(request.getParameter("category"));
        Category category = categoryDAO.get(categoryId);
        book.setCategory(category);

        Part part = request.getPart("bookImage");
        if (part != null && part.getSize() > 0) {
            long size = part.getSize();
            byte[] imageBytes = new byte[(int) size];

            InputStream inputStream = part.getInputStream();
            inputStream.read(imageBytes);
            inputStream.close();

            book.setImage(imageBytes);
        }
    }
}
