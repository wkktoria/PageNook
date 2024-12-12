package io.github.wkktoria.pagenook.entity;

import org.junit.jupiter.api.Test;

import java.util.HashSet;
import java.util.Set;

import static org.junit.jupiter.api.Assertions.assertEquals;

class BookTest {
    @Test
    void testGetAverageRatingNoReviews() {
        Book book = new Book();

        Set<Review> reviews = new HashSet<>();
        book.setReviews(reviews);

        float averageRating = book.getAverageRating();

        assertEquals(0, averageRating);
    }

    @Test
    void testGetAverageRatingOneReview() {
        Book book = new Book();

        Set<Review> reviews = new HashSet<>();

        Review review = new Review();
        review.setRating(5);

        reviews.add(review);

        book.setReviews(reviews);

        float averageRating = book.getAverageRating();

        assertEquals(5, averageRating);
    }

    @Test
    void testGetAverageRatingFewReviews() {
        Book book = new Book();

        Set<Review> reviews = new HashSet<>();

        Review review1 = new Review();
        review1.setRating(5);

        Review review2 = new Review();
        review2.setRating(3);

        Review review3 = new Review();
        review3.setRating(4);

        reviews.add(review1);
        reviews.add(review2);
        reviews.add(review3);

        book.setReviews(reviews);

        float averageRating = book.getAverageRating();

        assertEquals(4, averageRating);
    }

    @Test
    void testGetRatingStringNoReviews() {
        float averageRating = 0;

        Book book = new Book();
        String ratingString = book.getRatingString(averageRating);

        assertEquals("off,off,off,off,off", ratingString);
    }

    @Test
    void testGetRatingStringAllMaxRatingReviews() {
        float averageRating = 5;

        Book book = new Book();
        String ratingString = book.getRatingString(averageRating);

        assertEquals("on,on,on,on,on", ratingString);
    }

    @Test
    void testGetRatingStringAverageRatingWithAHalf() {
        float averageRating = 3.5f;

        Book book = new Book();
        String ratingString = book.getRatingString(averageRating);

        assertEquals("on,on,on,half,off", ratingString);
    }

    @Test
    void testGetRatingStringAverageRatingWithAHalfAtLastPlace() {
        float averageRating = 4.5f;

        Book book = new Book();
        String ratingString = book.getRatingString(averageRating);

        assertEquals("on,on,on,on,half", ratingString);
    }
}