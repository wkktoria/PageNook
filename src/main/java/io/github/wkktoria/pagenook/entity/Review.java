package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

import static jakarta.persistence.GenerationType.IDENTITY;

@Entity
@Table(name = "review", indexes = {
        @Index(name = "book_fk_idx", columnList = "book_id"),
        @Index(name = "customer_fk_idx", columnList = "customer_id")
})
@NamedQueries({
        @NamedQuery(name = "Review.listAll", query = "select r from Review r order by r.reviewTime desc"),
        @NamedQuery(name = "Review.countAll", query = "select count(r) from Review r"),
        @NamedQuery(name = "Review.findByCustomerAndBook",
                query = "select r from Review  r where r.customer.customerId = :customerId and r.book.bookId = :bookId"),
        @NamedQuery(name = "Review.countByCustomer", query = "select count(r.reviewId) from Review r where r.customer.customerId = :customerId"),
        @NamedQuery(name = "Review.mostFavoredBooks",
                query = "select r.book, count(r.book.bookId) as ReviewCount, avg(r.rating) as AverageRating from Review r "
                        + "group by r.book.bookId having avg(r.rating) >= 4.0 order by ReviewCount desc, AverageRating desc"),
})
public class Review implements Serializable {
    private Integer reviewId;
    private Book book;
    private Customer customer;
    private int rating;
    private String headline;
    private String comment;
    private Date reviewTime;

    public Review() {
    }

    public Review(Book book, Customer customer, int rating, String headline, String comment, Date reviewTime) {
        this.book = book;
        this.customer = customer;
        this.rating = rating;
        this.headline = headline;
        this.comment = comment;
        this.reviewTime = reviewTime;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "review_id", unique = true, nullable = false)
    public Integer getReviewId() {
        return this.reviewId;
    }

    public void setReviewId(Integer reviewId) {
        this.reviewId = reviewId;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_id", nullable = false)
    public Book getBook() {
        return this.book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "customer_id", nullable = false)
    public Customer getCustomer() {
        return this.customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Column(name = "rating", nullable = false)
    public int getRating() {
        return this.rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    @Column(name = "headline", nullable = false, length = 128)
    public String getHeadline() {
        return this.headline;
    }

    public void setHeadline(String headline) {
        this.headline = headline;
    }

    @Column(name = "comment", nullable = false, length = 500)
    public String getComment() {
        return this.comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "review_time", nullable = false, length = 19)
    public Date getReviewTime() {
        return this.reviewTime;
    }

    public void setReviewTime(Date reviewTime) {
        this.reviewTime = reviewTime;
    }

    @Transient
    public String getStars() {
        StringBuilder result = new StringBuilder();

        int numberOfStarsOn = rating;

        result.append("on,".repeat(Math.max(0, numberOfStarsOn)));

        result.append("off,".repeat(Math.max(0, 5 - (numberOfStarsOn + 1) + 1)));

        return result.substring(0, result.length() - 1);
    }
}