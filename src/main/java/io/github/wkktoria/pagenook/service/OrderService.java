package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.controller.frontend.shoppingcart.ShoppingCart;
import io.github.wkktoria.pagenook.dao.OrderDAO;
import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.BookOrder;
import io.github.wkktoria.pagenook.entity.Customer;
import io.github.wkktoria.pagenook.entity.OrderDetail;
import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.*;

public class OrderService {
    private final OrderDAO orderDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public OrderService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        orderDAO = new OrderDAO();
    }

    public void listAllOrder() throws ServletException, IOException {
        List<BookOrder> listOrder = orderDAO.listAll();

        request.setAttribute("listOrder", listOrder);

        final String listPage = "order_list.jsp";
        CommonUtil.forwardToPage(listPage, request, response);
    }

    public void showCheckoutForm() throws ServletException, IOException {
        final String checkoutPage = "frontend/checkout.jsp";
        CommonUtil.forwardToPage(checkoutPage, request, response);
    }

    public void placeOrder() throws ServletException, IOException {
        final String recipientName = request.getParameter("recipientName");
        final String recipientPhone = request.getParameter("recipientPhone");
        final String address = request.getParameter("address");
        final String city = request.getParameter("city");
        final String zipcode = request.getParameter("zipcode");
        final String country = request.getParameter("country");
        final String paymentMethod = request.getParameter("paymentMethod");

        final String shippingAddress = address + ", " + city + ", " + zipcode + ", " + country;

        BookOrder order = new BookOrder();
        order.setRecipientName(recipientName);
        order.setRecipientPhone(recipientPhone);
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);

        HttpSession session = request.getSession();

        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        order.setCustomer(customer);

        ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
        Map<Book, Integer> items = shoppingCart.getItems();
        Iterator<Book> iterator = items.keySet().iterator();

        Set<OrderDetail> orderDetails = new HashSet<>();

        while (iterator.hasNext()) {
            Book book = iterator.next();
            Integer quantity = items.get(book);
            float subtotal = quantity * book.getPrice();

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setBook(book);
            orderDetail.setBookOrder(order);
            orderDetail.setQuantity(quantity);
            orderDetail.setSubtotal(subtotal);

            orderDetails.add(orderDetail);
        }

        order.setOrderDetails(orderDetails);
        order.setTotal(shoppingCart.getTotalAmount());

        orderDAO.create(order);
        shoppingCart.clear();

        final String message = "Thank you. Your order has been received. We will deliver your books within a few days.";
        CommonUtil.showMessageFrontend(message, request, response);
    }
}
