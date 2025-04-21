package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Review;
import org.junit.jupiter.api.*;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
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
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Order(1)
    @Test
    void testCreate() {
        Review review = new Review();
        review.setBook(bookDAO.get(1));
        review.setCustomer(customerDAO.get(1));
        review.setHeadline("Test Review");
        review.setRating(5);
        review.setComment("This is a test review.");

        Review savedReview = reviewDAO.create(review);

        assertTrue(savedReview.getReviewId() > 0);
    }

    @Test
    void testGet() {
        Integer reviewId = 1;

        Review review = reviewDAO.get(reviewId);

        assertNotNull(review);
    }

    @Order(2)
    @Test
    void testUpdate() {
        Review review = reviewDAO.get(2);
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
        Integer reviewId = 2;

        reviewDAO.delete(reviewId);

        assertNull(reviewDAO.get(reviewId));
    }

    @Test
    void testFindByCustomerAndBookFound() {
        int customerId = 1;
        int bookId = 1;

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