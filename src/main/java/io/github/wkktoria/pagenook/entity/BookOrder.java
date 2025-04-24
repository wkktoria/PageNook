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
    private String addressLine1;
    private String addressLine2;
    private String firstname;
    private String lastname;
    private String phone;
    private String city;
    private String state;
    private String zipcode;
    private String country;
    private String paymentMethod;
    private float total;
    private float subtotal;
    private float shippingFee;
    private float tax;
    private String status;
    private Set<OrderDetail> orderDetails = new HashSet<>(0);

    public BookOrder() {
    }

    public BookOrder(Customer customer, Date orderDate, String addressLine1, String addressLine2, String firstname,
                     String lastname, String phone, String city, String state, String zipcode, String country,
                     String paymentMethod, float total, float subtotal, float shippingFee, float tax, String status) {
        this.customer = customer;
        this.orderDate = orderDate;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
        this.city = city;
        this.state = state;
        this.zipcode = zipcode;
        this.country = country;
        this.paymentMethod = paymentMethod;
        this.total = total;
        this.subtotal = subtotal;
        this.shippingFee = shippingFee;
        this.tax = tax;
        this.status = status;
    }

    public BookOrder(Customer customer, Date orderDate, String addressLine1, String addressLine2, String firstname,
                     String lastname, String phone, String city, String state, String zipcode, String country,
                     String paymentMethod, float total, float subtotal, float shippingFee, float tax, String status,
                     Set<OrderDetail> orderDetails) {
        this.customer = customer;
        this.orderDate = orderDate;
        this.addressLine1 = addressLine1;
        this.addressLine2 = addressLine2;
        this.firstname = firstname;
        this.lastname = lastname;
        this.phone = phone;
        this.city = city;
        this.state = state;
        this.zipcode = zipcode;
        this.country = country;
        this.paymentMethod = paymentMethod;
        this.total = total;
        this.subtotal = subtotal;
        this.shippingFee = shippingFee;
        this.tax = tax;
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

    @Column(name = "r_address_line1", nullable = false, length = 256)
    public String getAddressLine1() {
        return this.addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    @Column(name = "r_address_line2", nullable = false, length = 256)
    public String getAddressLine2() {
        return this.addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    @Column(name = "r_firstname", nullable = false, length = 30)
    public String getFirstname() {
        return this.firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    @Column(name = "r_lastname", nullable = false, length = 30)
    public String getLastname() {
        return this.lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    @Column(name = "r_phone", nullable = false, length = 15)
    public String getPhone() {
        return this.phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "r_city", nullable = false, length = 32)
    public String getCity() {
        return this.city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Column(name = "r_state", nullable = false, length = 45)
    public String getState() {
        return this.state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Column(name = "r_zipcode", nullable = false, length = 24)
    public String getZipcode() {
        return this.zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    @Column(name = "r_country", nullable = false, length = 4)
    public String getCountry() {
        return this.country;
    }

    public void setCountry(String country) {
        this.country = country;
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

    @Column(name = "subtotal", nullable = false, precision = 12, scale = 0)
    public float getSubtotal() {
        return this.subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }

    @Column(name = "shipping_fee", nullable = false, precision = 12, scale = 0)
    public float getShippingFee() {
        return this.shippingFee;
    }

    public void setShippingFee(float shippingFee) {
        this.shippingFee = shippingFee;
    }

    @Column(name = "tax", nullable = false, precision = 12, scale = 0)
    public float getTax() {
        return this.tax;
    }

    public void setTax(float tax) {
        this.tax = tax;
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