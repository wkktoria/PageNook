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
}