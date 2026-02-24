package io.github.wkktoria.pagenook.controller.frontend.order;

import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import io.github.wkktoria.pagenook.service.OrderService;
import io.github.wkktoria.pagenook.service.PaymentService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import static io.github.wkktoria.pagenook.util.CommonUtil.forwardToPage;

@WebServlet("/execute_payment")
public class ExecutePaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PaymentService paymentService = new PaymentService(request, response);
        Payment payment = paymentService.executePayment();

        OrderService orderService = new OrderService(request, response);
        Integer orderId = orderService.placeOrderPaypal(payment);

        HttpSession session = request.getSession();
        session.setAttribute("orderId", orderId);

        PayerInfo payerInfo = payment.getPayer().getPayerInfo();
        Transaction transaction = payment.getTransactions().getFirst();

        session.setAttribute("payer", payerInfo);
        session.setAttribute("transaction", transaction);

        String receiptPage = "frontend/payment_receipt.jsp";
        forwardToPage(receiptPage, request, response);
    }

}
