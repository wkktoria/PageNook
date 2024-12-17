package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Review;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewDAO extends JpaDao<Review> implements GenericDAO<Review> {
    @Override
    public Review create(Review review) {
        review.setReviewTime(new Date());
        return super.create(review);
    }

    @Override
    public Review update(Review review) {
        return super.update(review);
    }

    @Override
    public Review get(Object reviewId) {
        return super.find(Review.class, reviewId);
    }

    @Override
    public void delete(Object reviewId) {
        super.delete(Review.class, reviewId);
    }

    @Override
    public List<Review> listAll() {
        return super.findWithNamedQuery("Review.listAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Review.countAll");
    }

    public Review findByCustomerAndBook(final int customerId, final int bookId) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("customerId", customerId);
        parameters.put("bookId", bookId);

        List<Review> result = super.findWithNamedQuery("Review.findByCustomerAndBook", parameters);

        if (!result.isEmpty()) {
            return result.getFirst();
        }

        return null;
    }

    public long countByCustomer(final int customerId) {
        return super.countWithNamedQuery("Review.countByCustomer", "customerId", customerId);
    }
}
