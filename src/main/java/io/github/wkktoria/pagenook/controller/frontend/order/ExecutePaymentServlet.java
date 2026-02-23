package io.github.wkktoria.pagenook.controller.frontend.order;

import com.paypal.api.payments.Payment;
import io.github.wkktoria.pagenook.service.OrderService;
import io.github.wkktoria.pagenook.service.PaymentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/execute_payment")
public class ExecutePaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PaymentService paymentService = new PaymentService(request, response);
        Payment payment = paymentService.executePayment();

        OrderService orderService = new OrderService(request, response);
        Integer orderId = orderService.placeOrderPaypal(payment);

        response.getWriter().println("Payment successful. Order ID: " + orderId);
    }

}
