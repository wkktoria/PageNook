package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.BookDAO;
import io.github.wkktoria.pagenook.dao.CategoryDAO;
import io.github.wkktoria.pagenook.dao.OrderDAO;
import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.Category;
import io.github.wkktoria.pagenook.util.CommonUtil;
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
    private final OrderDAO orderDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public BookService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        bookDAO = new BookDAO();
        categoryDAO = new CategoryDAO();
        orderDAO = new OrderDAO();
    }

    public void listBook(final String message) throws ServletException, IOException {
        List<Book> listBooks = bookDAO.listAll();
        request.setAttribute("listBook", listBooks);

        if (message != null) {
            request.setAttribute("message", message);
        }

        final String listPage = "book_list.jsp";
        CommonUtil.forwardToPage(listPage, request, response);
    }

    public void listBook() throws ServletException, IOException {
        listBook(null);
    }

    public void showBookNewForm() throws ServletException, IOException {
        List<Category> listCategory = categoryDAO.listAll();
        request.setAttribute("listCategory", listCategory);

        final String newPage = "book_form.jsp";
        CommonUtil.forwardToPage(newPage, request, response);
    }

    public void createBook() throws ParseException, ServletException, IOException {
        final String title = request.getParameter("title");
        Book existingBook = bookDAO.findByTitle(request.getParameter("title"));

        if (existingBook != null) {
            final String message = "Could not crete new book, because the book with title " + title
                    + " already exists.";
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

        CommonUtil.forwardToPage(destinationPage, request, response);
    }

    public void updateBook() throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("bookId"));
        final String title = request.getParameter("title");

        Book existingBook = bookDAO.get(bookId);
        Book bookByTitle = bookDAO.findByTitle(title);

        if (bookByTitle != null && !existingBook.equals(bookByTitle)) {
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

            try (InputStream inputStream = part.getInputStream()) {
                int bytesRead;
                int totalBytesRead = 0;

                while (totalBytesRead < size) {
                    bytesRead = inputStream.read(imageBytes, totalBytesRead, (int) (size - totalBytesRead));
                    if (bytesRead == -1) {
                        throw new IOException("Unexpected end of stream. Not all bytes has been read");
                    }
                    totalBytesRead += bytesRead;
                }

                book.setImage(imageBytes);
            } catch (IOException exception) {
                throw new ServletException("Error reading image");
            }
        }
    }

    public void deleteBook() throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("id"));

        if (bookDAO.get(bookId) == null) {
            final String message = "Could not find book with ID " + bookId + ", or it might have been deleted.";
            CommonUtil.showMessageBackend(message, request, response);
        } else {
            if (!bookDAO.get(bookId).getReviews().isEmpty()) {
                final String message = "Could not delete the book with ID " + bookId + ", because it has reviews.";
                CommonUtil.showMessageBackend(message, request, response);
            } else {
                long countByOrder = orderDAO.countOrderDetailByBook(bookId);

                if (countByOrder > 0) {
                    final String message = "Could not delete book with ID " + bookId
                            + ", because there are orders associated with it.";
                    CommonUtil.showMessageBackend(message, request, response);
                } else {
                    bookDAO.delete(bookId);

                    final String message = "The book has been deleted successfully.";
                    listBook(message);
                }
            }
        }
    }

    public void listBookByCategory() throws ServletException, IOException {
        Integer categoryId = Integer.parseInt(request.getParameter("id"));

        Category category = categoryDAO.get(categoryId);

        if (category == null) {
            final String message = "Sorry, the category with ID " + categoryId + " is not available.";
            CommonUtil.showMessageFrontend(message, request, response);
            return;
        }

        request.setAttribute("category", category);

        List<Book> listBook = bookDAO.listByCategory(categoryId);
        request.setAttribute("listBook", listBook);

        final String listPage = "frontend/book_list_by_category.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
        dispatcher.forward(request, response);
    }

    public void viewBookDetails() throws ServletException, IOException {
        final Integer bookId = Integer.parseInt(request.getParameter("id"));
        Book book = bookDAO.get(bookId);

        if (book == null) {
            final String message = "Sorry, the book with ID " + bookId + " is not available.";
            CommonUtil.showMessageFrontend(message, request, response);
            return;
        }

        request.setAttribute("book", book);

        final String detailsPage = "frontend/book_details.jsp";
        CommonUtil.forwardToPage(detailsPage, request, response);
    }

    public void search() throws ServletException, IOException {
        final String keyword = request.getParameter("keyword");
        List<Book> result;

        if (keyword.isEmpty()) {
            result = bookDAO.listAll();
        } else {
            result = bookDAO.search(keyword);
        }

        request.setAttribute("keyword", keyword);
        request.setAttribute("result", result);

        final String resultPage = "frontend/search_result.jsp";
        CommonUtil.forwardToPage(resultPage, request, response);
    }
}
