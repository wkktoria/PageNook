package io.github.wkktoria.pagenook.service;

import java.io.IOException;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

public class OrderService {
    private final OrderDAO orderDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public OrderService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        orderDAO = new OrderDAO();
    }

    public void listAllOrder(final String message) throws ServletException, IOException {
        List<BookOrder> listOrder = orderDAO.listAll();

        if (message != null) {
            request.setAttribute("message", message);
        }

        request.setAttribute("listOrder", listOrder);

        final String listPage = "order_list.jsp";
        CommonUtil.forwardToPage(listPage, request, response);
    }

    public void listAllOrder() throws ServletException, IOException {
        listAllOrder(null);
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
        order.setFirstname(recipientName);
        order.setPhone(recipientPhone);
        order.setAddressLine1(shippingAddress);
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

    public void viewOrderDetailForAdmin() throws ServletException, IOException {
        final int orderId = Integer.parseInt(request.getParameter("id"));

        BookOrder order = orderDAO.get(orderId);

        if (order == null) {
            final String message = "Could not find order with ID " + orderId + ".";
            CommonUtil.showMessageBackend(message, request, response);
        } else {
            request.setAttribute("order", order);
            final String detailPage = "order_detail.jsp";
            CommonUtil.forwardToPage(detailPage, request, response);

        }
    }

    public void listOrderByCustomer() throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        List<BookOrder> listOrders = orderDAO.listByCustomer(customer.getCustomerId());

        request.setAttribute("listOrders", listOrders);
        final String historyPage = "frontend/order_list.jsp";
        CommonUtil.forwardToPage(historyPage, request, response);
    }

    public void showOrderDetailForCustomer() throws ServletException, IOException {
        final int orderId = Integer.parseInt(request.getParameter("id"));

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("loggedCustomer");

        BookOrder order = orderDAO.get(orderId, customer.getCustomerId());

        request.setAttribute("order", order);
        final String detailPage = "frontend/order_detail.jsp";
        CommonUtil.forwardToPage(detailPage, request, response);
    }

    public void showEditOrderForm() throws ServletException, IOException {
        final Integer orderId = Integer.parseInt(request.getParameter("id"));

        if (orderDAO.get(orderId) == null) {
            final String message = "Could not find order with ID " + orderId + ".";
            CommonUtil.showMessageBackend(message, request, response);
        } else {
            HttpSession session = request.getSession();
            Object isPendingBook = session.getAttribute("newBookPendingToAddToOrder");

            if (isPendingBook == null) {
                BookOrder order = orderDAO.get(orderId);
                session.setAttribute("order", order);
            } else {
                session.removeAttribute("newBookPendingToAddToOrder");
            }

            final String editPage = "order_form.jsp";
            CommonUtil.forwardToPage(editPage, request, response);
        }
    }

    public void updateOrder() throws ServletException, IOException {
        HttpSession session = request.getSession();
        BookOrder order = (BookOrder) session.getAttribute("order");

        final String recipientName = request.getParameter("recipientName");
        final String recipientPhone = request.getParameter("recipientPhone");
        final String shippingAddress = request.getParameter("shippingAddress");
        final String paymentMethod = request.getParameter("paymentMethod");
        final String orderStatus = request.getParameter("orderStatus");

        order.setFirstname(recipientName);
        order.setPhone(recipientPhone);
        order.setAddressLine1(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setStatus(orderStatus);

        final String[] arrayBookId = request.getParameterValues("bookId");
        final String[] arrayPrice = request.getParameterValues("price");
        String[] arrayQuantity = new String[arrayBookId.length];

        for (int i = 1; i <= arrayQuantity.length; i++) {
            arrayQuantity[i - 1] = request.getParameter("quantity" + i);
        }

        Set<OrderDetail> orderDetails = order.getOrderDetails();
        orderDetails.clear();

        float totalAmount = 0;

        for (int i = 0; i < arrayBookId.length; i++) {
            final int bookId = Integer.parseInt(arrayBookId[i]);
            final int quantity = Integer.parseInt(arrayQuantity[i]);
            final float price = Float.parseFloat(arrayPrice[i]);
            final float subtotal = price * quantity;

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setBook(new Book(bookId));
            orderDetail.setQuantity(quantity);
            orderDetail.setSubtotal(subtotal);
            orderDetail.setBookOrder(order);

            orderDetails.add(orderDetail);

            totalAmount += subtotal;
        }

        order.setTotal(totalAmount);

        orderDAO.update(order);

        final String message = "The order with ID " + order.getOrderId() + " has been updated successfully.";
        listAllOrder(message);
    }

    public void deleteOrder() throws ServletException, IOException {
        Integer orderId = Integer.parseInt(request.getParameter("id"));

        if (orderDAO.get(orderId) == null) {
            final String message = "Could not find order with ID " + orderId + ", or it might have been deleted.";
            CommonUtil.showMessageBackend(message, request, response);
        } else {
            orderDAO.delete(orderId);
            final String message = "The order with ID " + orderId + " has been deleted.";
            listAllOrder(message);

        }
    }
}
