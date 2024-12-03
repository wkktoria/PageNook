package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "order_detail", indexes = {
        @Index(name = "order_fk_idx", columnList = "order_id"),
        @Index(name = "book_fk_2_idx", columnList = "book_id")
})
public class OrderDetail implements Serializable {
    private OrderDetailId id = new OrderDetailId();
    private Book book;
    private BookOrder bookOrder;
    private int quantity;
    private float subtotal;

    public OrderDetail() {
    }

    public OrderDetail(OrderDetailId id) {
        this.id = id;
    }

    public OrderDetail(OrderDetailId id, Book book, BookOrder bookOrder, int quantity, float subtotal) {
        this.id = id;
        this.book = book;
        this.bookOrder = bookOrder;
        this.quantity = quantity;
        this.subtotal = subtotal;
    }

    @EmbeddedId

    @AttributeOverrides({@AttributeOverride(name = "orderId", column = @Column(name = "order_id", nullable = false)),
            @AttributeOverride(name = "bookId", column = @Column(name = "book_id", nullable = false))})
    public OrderDetailId getId() {
        return this.id;
    }

    public void setId(OrderDetailId id) {
        this.id = id;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "book_id", insertable = false, updatable = false, nullable = false)
    public Book getBook() {
        return this.book;
    }

    public void setBook(Book book) {
        this.book = book;
        this.id.setBook(book);
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", insertable = false, updatable = false, nullable = false)
    public BookOrder getBookOrder() {
        return this.bookOrder;
    }

    public void setBookOrder(BookOrder bookOrder) {
        this.bookOrder = bookOrder;
        this.id.setBookOrder(bookOrder);
    }

    @Column(name = "quantity", nullable = false)
    public int getQuantity() {
        return this.quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Column(name = "subtotal", nullable = false, precision = 12, scale = 0)
    public float getSubtotal() {
        return this.subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }
}