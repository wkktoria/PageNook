package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.Embeddable;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

import java.io.Serializable;

@Embeddable
public class OrderDetailId implements Serializable {
    private Book book;
    private BookOrder bookOrder;

    public OrderDetailId() {
    }


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "book_id", insertable = false, updatable = false, nullable = false)
    public Book getBook() {
        return this.book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", insertable = false, updatable = false, nullable = false)
    public BookOrder getBookOrder() {
        return this.bookOrder;
    }

    public void setBookOrder(BookOrder bookOrder) {
        this.bookOrder = bookOrder;
    }
}
