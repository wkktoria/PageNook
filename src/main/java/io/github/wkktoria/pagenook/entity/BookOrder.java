package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

import static jakarta.persistence.GenerationType.IDENTITY;

@Entity
@Table(name = "book_order", indexes = {
        @Index(name = "customer_fk_2_idx", columnList = "customer_id")
})
@NamedQueries({
        @NamedQuery(name = "BookOrder.findAll", query = "select bo from BookOrder bo order by bo.orderDate desc"),
        @NamedQuery(name = "BookOrder.countByCustomer", query = "select count(bo.orderId) from BookOrder bo where bo.customer.customerId = :customerId"),
        @NamedQuery(name = "BookOrder.findByCustomer", query = "select bo from BookOrder bo where bo.customer.customerId = :customerId order by bo.orderDate desc"),
        @NamedQuery(name = "BookOrder.findByIdAndCustomer", query = "select bo from BookOrder bo where bo.orderId = :orderId and bo.customer.customerId = :customerId"),
        @NamedQuery(name = "BookOrder.countAll", query = "select count(*) from BookOrder bo")
})
public class BookOrder implements Serializable {
    private Integer orderId;
    private Customer customer;
    private Date orderDate;
    private String shippingAddress;
    private String recipientName;
    private String recipientPhone;
    private String paymentMethod;
    private float total;
    private String status;
    private Set<OrderDetail> orderDetails = new HashSet<>(0);

    public BookOrder() {
    }

    public BookOrder(Customer customer, Date orderDate, String shippingAddress, String recipientName,
                     String recipientPhone, String paymentMethod, float total, String status) {
        this.customer = customer;
        this.orderDate = orderDate;
        this.shippingAddress = shippingAddress;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.paymentMethod = paymentMethod;
        this.total = total;
        this.status = status;
    }

    public BookOrder(Customer customer, Date orderDate, String shippingAddress, String recipientName,
                     String recipientPhone, String paymentMethod, float total, String status, Set<OrderDetail> orderDetails) {
        this.customer = customer;
        this.orderDate = orderDate;
        this.shippingAddress = shippingAddress;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.paymentMethod = paymentMethod;
        this.total = total;
        this.status = status;
        this.orderDetails = orderDetails;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "order_id", unique = true, nullable = false)
    public Integer getOrderId() {
        return this.orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "customer_id", nullable = false)
    public Customer getCustomer() {
        return this.customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "order_date", nullable = false, length = 19)
    public Date getOrderDate() {
        return this.orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    @Column(name = "shipping_address", nullable = false, length = 256)
    public String getShippingAddress() {
        return this.shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    @Column(name = "recipient_name", nullable = false, length = 30)
    public String getRecipientName() {
        return this.recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    @Column(name = "recipient_phone", nullable = false, length = 15)
    public String getRecipientPhone() {
        return this.recipientPhone;
    }

    public void setRecipientPhone(String recipientPhone) {
        this.recipientPhone = recipientPhone;
    }

    @Column(name = "payment_method", nullable = false, length = 20)
    public String getPaymentMethod() {
        return this.paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    @Column(name = "total", nullable = false, precision = 12, scale = 0)
    public float getTotal() {
        return this.total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    @Column(name = "status", nullable = false, length = 20)
    public String getStatus() {
        return this.status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "bookOrder", cascade = CascadeType.ALL, orphanRemoval = true)
    public Set<OrderDetail> getOrderDetails() {
        return this.orderDetails;
    }

    public void setOrderDetails(Set<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        BookOrder order = (BookOrder) o;
        return Objects.equals(orderId, order.orderId);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(orderId);
    }

    @Transient
    public int getBookCopies() {
        int total = 0;

        for (final OrderDetail orderDetail : orderDetails) {
            total += orderDetail.getQuantity();
        }

        return total;
    }
}