package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.BookOrder;
import io.github.wkktoria.pagenook.entity.Customer;
import io.github.wkktoria.pagenook.entity.OrderDetail;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

/**
 * The customer and book database tables should contain some records to make these tests works properly.
 */
class OrderDAOTest extends BaseDAOTest {
    private static OrderDAO orderDAO;
    private static CustomerDAO customerDAO;
    private static BookDAO bookDAO;

    @BeforeAll
    static void setUp() {
        BaseDAOTest.setUp();

        orderDAO = new OrderDAO();
        customerDAO = new CustomerDAO();
        bookDAO = new BookDAO();

        orderDAO.create(new BookOrder(customerDAO.listAll().getFirst(), new Date(),
                "Test Address", "Test Recipient",
                "1234567890", "Test Payment Method",
                100, "Test Status"));
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Test
    void testCreateOrderWithOneBook() {
        BookOrder order = new BookOrder();
        Customer customer = customerDAO.listAll().getFirst();

        order.setCustomer(customer);
        order.setRecipientName(customer.getFullname());
        order.setRecipientPhone(customer.getPhone());
        order.setShippingAddress(customer.getAddress() + ", " + customer.getZipcode()
                + " " + customer.getCity() + ", " + customer.getCountry());
        order.setPaymentMethod("Cash on Delivery");

        Set<OrderDetail> orderDetails = new HashSet<>();
        OrderDetail orderDetail = new OrderDetail();

        Book book = bookDAO.listAll().getFirst();
        orderDetail.setBook(book);
        orderDetail.setBookOrder(order);
        orderDetail.setQuantity(1);
        orderDetail.setSubtotal(book.getPrice());

        orderDetails.add(orderDetail);

        order.setOrderDetails(orderDetails);

        BookOrder savedOrder = orderDAO.create(order);

        assertTrue(savedOrder != null && !savedOrder.getOrderDetails().isEmpty());
    }

    @Test
    void testCreateOrderWithFewBooks() {
        BookOrder order = new BookOrder();
        Customer customer = customerDAO.listAll().getFirst();

        order.setCustomer(customer);
        order.setRecipientName(customer.getFullname());
        order.setRecipientPhone(customer.getPhone());
        order.setShippingAddress(customer.getAddress() + ", " + customer.getZipcode()
                + " " + customer.getCity() + ", " + customer.getCountry());
        order.setPaymentMethod("Cash on Delivery");

        Set<OrderDetail> orderDetails = new HashSet<>();

        Book firstBook = bookDAO.listAll().getFirst();
        OrderDetail firstBookOrderDetail = new OrderDetail();
        firstBookOrderDetail.setBook(firstBook);
        firstBookOrderDetail.setBookOrder(order);
        firstBookOrderDetail.setQuantity(1);
        firstBookOrderDetail.setSubtotal(firstBook.getPrice());

        orderDetails.add(firstBookOrderDetail);

        Book secondBook = bookDAO.listAll().getLast();
        OrderDetail secondBookOrderDetail = new OrderDetail();
        secondBookOrderDetail.setBook(secondBook);
        secondBookOrderDetail.setBookOrder(order);
        secondBookOrderDetail.setQuantity(2);
        secondBookOrderDetail.setSubtotal(secondBook.getPrice() * 2);

        orderDetails.add(secondBookOrderDetail);

        order.setOrderDetails(orderDetails);

        BookOrder savedOrder = orderDAO.create(order);

        assertTrue(savedOrder != null && savedOrder.getOrderDetails().size() == 2);
    }

    @Test
    void testGet() {
        Integer orderId = orderDAO.listAll().getFirst().getOrderId();
        BookOrder order = orderDAO.get(orderId);

        assertNotNull(order);
    }

    @Test
    void testListAll() {
        List<BookOrder> listOrders = orderDAO.listAll();

        assertFalse(listOrders.isEmpty());
    }

    @Test
    void testListByCustomerNoOrders() {
        final int customerId = -1;

        List<BookOrder> listOrders = orderDAO.listByCustomer(customerId);

        assertTrue(listOrders.isEmpty());
    }

    @Test
    void testListByCustomerSomeOrders() {
        final int customerId = customerDAO.listAll().getFirst().getCustomerId();

        List<BookOrder> listOrders = orderDAO.listByCustomer(customerId);

        assertFalse(listOrders.isEmpty());
    }

    @Test
    void testGetByIdAndCustomerNotNull() {
        final int orderId = orderDAO.listAll().getFirst().getOrderId();
        final int customerId = customerDAO.listAll().getFirst().getCustomerId();

        BookOrder order = orderDAO.get(orderId, customerId);

        assertNotNull(order);
    }

    @Test
    void testGetByIdAndCustomerNull() {
        final int orderId = orderDAO.listAll().getFirst().getOrderId();
        final int customerId = -1;

        BookOrder order = orderDAO.get(orderId, customerId);

        assertNull(order);
    }

    @Test
    void testUpdateShippingAddress() {
        final int orderId = orderDAO.listAll().getFirst().getOrderId();
        BookOrder order = orderDAO.get(orderId);
        order.setShippingAddress("New Shipping Address");

        orderDAO.update(order);

        BookOrder updatedOrder = orderDAO.get(orderId);

        assertEquals("New Shipping Address", updatedOrder.getShippingAddress());
    }

    @Test
    void testUpdateOrderDetail() {
        final int orderId = orderDAO.listAll().getFirst().getOrderId();
        BookOrder order = orderDAO.get(orderId);
        Iterator<OrderDetail> iterator = order.getOrderDetails().iterator();

        while (iterator.hasNext()) {
            OrderDetail orderDetail = iterator.next();
            orderDetail.setQuantity(3);
            orderDetail.setSubtotal(120);
        }

        orderDAO.update(order);

        iterator = order.getOrderDetails().iterator();

        final int expectedQuantity = 3;
        final float expectedSubtotal = 120;

        while (iterator.hasNext()) {
            OrderDetail orderDetail = iterator.next();
            assertEquals(expectedQuantity, orderDetail.getQuantity());
            assertEquals(expectedSubtotal, orderDetail.getSubtotal(), 0);
        }
    }
}