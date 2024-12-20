package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Review;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

/**
 * The book and customer database tables should contain some records to make these tests work properly.
 */
class ReviewDAOTest {
    private static ReviewDAO reviewDAO;
    private static BookDAO bookDAO;
    private static CustomerDAO customerDAO;

    @BeforeAll
    static void setUp() {
        BaseDAOTest.setUp();
        reviewDAO = new ReviewDAO();
        bookDAO = new BookDAO();
        customerDAO = new CustomerDAO();

        reviewDAO.create(new Review(bookDAO.listAll().getFirst(),
                customerDAO.listAll().getFirst(), 5, "Test Review",
                "This is a test review.", new Date()));
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Test
    void testCreate() {
        Review review = new Review();
        review.setBook(bookDAO.listAll().getFirst());
        review.setCustomer(customerDAO.listAll().getFirst());
        review.setHeadline("Test Review");
        review.setRating(5);
        review.setComment("This is a test review.");

        Review savedReview = reviewDAO.create(review);

        assertTrue(savedReview.getReviewId() > 0);
    }

    @Test
    void testGet() {
        Integer reviewId = reviewDAO.listAll().getFirst().getReviewId();

        Review review = reviewDAO.get(reviewId);

        assertNotNull(review);
    }

    @Test
    void testUpdate() {
        Review review = reviewDAO.listAll().getFirst();
        review.setHeadline("Updated Test Review");

        Review updatedReview = reviewDAO.update(review);

        assertEquals("Updated Test Review", updatedReview.getHeadline());
    }

    @Test
    void testListAll() {
        List<Review> listReview = reviewDAO.listAll();

        assertFalse(listReview.isEmpty());
    }

    @Test
    void testCount() {
        long totalReviews = reviewDAO.count();

        assertTrue(totalReviews > 0);
    }

    @Test
    void testDelete() {
        Integer reviewId = reviewDAO.listAll().getFirst().getReviewId();

        reviewDAO.delete(reviewId);

        assertNull(reviewDAO.get(reviewId));
    }

    @Test
    void testFindByCustomerAndBookFound() {
        int customerId = customerDAO.listAll().getFirst().getCustomerId();
        int bookId = bookDAO.listAll().getFirst().getBookId();

        Review result = reviewDAO.findByCustomerAndBook(customerId, bookId);

        assertNotNull(result);
    }

    @Test
    void testFindByCustomerAndBookNotFound() {
        int customerId = -1;
        int bookId = -1;

        Review result = reviewDAO.findByCustomerAndBook(customerId, bookId);

        assertNull(result);
    }

    @Test
    void testListMostRecent() {
        List<Review> recentReviews = reviewDAO.listMostRecent();

        assertFalse(recentReviews.isEmpty());
    }
}