package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.BookOrder;
import io.github.wkktoria.pagenook.entity.Customer;
import io.github.wkktoria.pagenook.entity.OrderDetail;
import org.junit.jupiter.api.*;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
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
    }

    @AfterAll
    static void tearDown() {
        BaseDAOTest.tearDown();
    }

    @Order(1)
    @Test
    void testCreateOrderWithOneBook() {
        BookOrder order = new BookOrder();
        Customer customer = customerDAO.listAll().getFirst();

        order.setCustomer(customer);
        order.setFirstname(customer.getFirstname());
        order.setPhone(customer.getPhone());
        order.setAddressLine1(customer.getAddressLine1() + ", " + customer.getZipcode()
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
        order.setFirstname(customer.getFirstname());
        order.setPhone(customer.getPhone());
        order.setAddressLine1(customer.getAddressLine1() + ", " + customer.getZipcode()
                + " " + customer.getCity() + ", " + customer.getCountry());
        order.setPaymentMethod("Cash on Delivery");

        Set<OrderDetail> orderDetails = new HashSet<>();

        Book firstBook = bookDAO.get(1);
        OrderDetail firstBookOrderDetail = new OrderDetail();
        firstBookOrderDetail.setBook(firstBook);
        firstBookOrderDetail.setBookOrder(order);
        firstBookOrderDetail.setQuantity(1);
        firstBookOrderDetail.setSubtotal(firstBook.getPrice());

        orderDetails.add(firstBookOrderDetail);

        Book secondBook = bookDAO.get(2);
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
        final int orderId = 1;
        final int customerId = 1;

        BookOrder order = orderDAO.get(orderId, customerId);

        assertNotNull(order);
    }

    @Test
    void testGetByIdAndCustomerNull() {
        final int orderId = 1;
        final int customerId = -1;

        BookOrder order = orderDAO.get(orderId, customerId);

        assertNull(order);
    }

    @Order(2)
    @Test
    void testUpdateShippingAddress() {
        final int orderId = 2;
        BookOrder order = orderDAO.get(orderId);
        order.setAddressLine1("New Shipping Address");

        orderDAO.update(order);

        BookOrder updatedOrder = orderDAO.get(orderId);

        assertEquals("New Shipping Address", updatedOrder.getAddressLine1());
    }

    @Order(3)
    @Test
    void testUpdateOrderDetail() {
        final int orderId = 2;
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

    @Test
    void testCount() {
        long totalOrders = orderDAO.count();

        assertTrue(totalOrders > 0);
    }

    @Test
    void testDelete() {
        Integer orderId = orderDAO.listAll().getFirst().getOrderId();

        orderDAO.delete(orderId);

        BookOrder order = orderDAO.get(orderId);

        assertNull(order);
    }

    @Test
    void testListMostRecentSales() {
        List<BookOrder> recentOrders = orderDAO.listMostRecentSales();

        assertFalse(recentOrders.isEmpty());
    }
}