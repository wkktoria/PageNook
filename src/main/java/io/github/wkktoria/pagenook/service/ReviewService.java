package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.BookDAO;
import io.github.wkktoria.pagenook.dao.ReviewDAO;
import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.Customer;
import io.github.wkktoria.pagenook.entity.Review;
import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class ReviewService {
    private final ReviewDAO reviewDAO;
    private final BookDAO bookDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public ReviewService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        reviewDAO = new ReviewDAO();
        bookDAO = new BookDAO();
    }

    public void listAllReview(final String message) throws ServletException, IOException {
        List<Review> listReview = reviewDAO.listAll();

        request.setAttribute("listReview", listReview);

        if (message != null) {
            request.setAttribute("message", message);
        }

        final String listPage = "review_list.jsp";
        CommonUtil.forwardToPage(listPage, request, response);
    }

    public void listAllReview() throws ServletException, IOException {
        listAllReview(null);
    }

    public void showReviewForm() throws ServletException, IOException {
        final int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book book = bookDAO.get(bookId);

        HttpSession session = request.getSession();
        session.setAttribute("book", book);

        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        Review existingReview = reviewDAO.findByCustomerAndBook(customer.getCustomerId(), bookId);

        String targetPage = "frontend/review_form.jsp";

        if (existingReview != null) {
            request.setAttribute("review", existingReview);
            targetPage = "frontend/review_info.jsp";
        }

        CommonUtil.forwardToPage(targetPage, request, response);
    }

    public void submitReview() throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("bookId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String headline = request.getParameter("headline");
        String comment = request.getParameter("comment");

        Review newReview = new Review();
        newReview.setHeadline(headline);
        newReview.setComment(comment);
        newReview.setRating(rating);

        Book book = new Book();
        book.setBookId(bookId);
        newReview.setBook(book);

        Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
        newReview.setCustomer(customer);

        reviewDAO.create(newReview);

        final String messagePage = "frontend/review_done.jsp";
        CommonUtil.forwardToPage(messagePage, request, response);
    }

    public void editReview() throws ServletException, IOException {
        Integer reviewId = Integer.parseInt(request.getParameter("id"));
        Review review = reviewDAO.get(reviewId);

        if (review == null) {
            final String message = "Could not find review with ID " + reviewId + ".";
            CommonUtil.showMessageBackend(message, request, response);
        } else {
            request.setAttribute("review", review);
            CommonUtil.forwardToPage("review_form.jsp", request, response);
        }
    }

    public void updateReview() throws ServletException, IOException {
        final Integer reviewId = Integer.parseInt(request.getParameter("reviewId"));
        final String headline = request.getParameter("headline");
        final String comment = request.getParameter("comment");

        Review review = reviewDAO.get(reviewId);
        review.setHeadline(headline);
        review.setComment(comment);

        reviewDAO.update(review);

        final String message = "The review has been updated successfully.";
        listAllReview(message);
    }
}
