package io.github.wkktoria.pagenook.service;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import io.github.wkktoria.pagenook.entity.Book;
import io.github.wkktoria.pagenook.entity.BookOrder;
import io.github.wkktoria.pagenook.entity.Customer;
import io.github.wkktoria.pagenook.entity.OrderDetail;
import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.eclipse.jetty.server.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static io.github.wkktoria.pagenook.util.CommonUtil.forwardToPage;

public class PaymentService {

    private static final Logger LOGGER = LoggerFactory.getLogger(PaymentService.class);

    private static final String CLIENT_ID = System.getenv("PAYPAL_CLIENT_ID");
    private static final String CLIENT_SECRET = System.getenv("PAYPAL_CLIENT_SECRET");

    private String mode = "sandbox";

    private HttpServletRequest request;
    private HttpServletResponse response;

    public PaymentService(final HttpServletRequest request,
                          final HttpServletResponse response) {
        this.request = request;
        this.response = response;

        LOGGER.debug("CLIENT ID loaded: {}", CLIENT_ID != null);
        LOGGER.debug("CLIENT SECRET loaded: {}", CLIENT_SECRET != null);
    }

    public void authorizePayment(final BookOrder order) throws ServletException, IOException {
        Payer payer = getPayerInformation(order);
        RedirectUrls redirectUrls = getRedirectUrls();
        List<Transaction> transactions = getTransactionInformation(order);

        Payment requestPayment = new Payment();
        requestPayment.setPayer(payer)
                .setRedirectUrls(redirectUrls)
                .setIntent("authorize")
                .setTransactions(transactions);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
        try {
            Payment authorizedPayment = requestPayment.create(apiContext);
            String approvalUrl = getApprovalUrl(authorizedPayment);
            response.sendRedirect(approvalUrl);
        } catch (PayPalRESTException ex) {
            throw new ServletException("Error in authorizing payment");
        }
    }

    public void reviewPayment() throws ServletException, IOException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        if (paymentId == null || payerId == null) {
            throw new ServletException("Error in displaying payment review");
        }

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
        try {
            Payment payment = Payment.get(apiContext, paymentId);
            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().getFirst();
            ShippingAddress shippingAddress = transaction.getItemList().getShippingAddress();

            request.setAttribute("payer", payerInfo);
            request.setAttribute("recipient", shippingAddress);
            request.setAttribute("transaction", transaction);

            String reviewPage = "frontend/review_payment.jsp?paymentId=" + paymentId + "&payerId=" + payerId;
            forwardToPage(reviewPage, request, response);
        } catch (PayPalRESTException ex) {
            throw new ServletException("Error in getting payment details from PayPal");
        }
    }

    public Payment executePayment() throws ServletException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("payerId");

        LOGGER.info("Executing payment with ID: {}", paymentId);

        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);

        Payment payment = new Payment()
                .setId(paymentId);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);

        try {
            return payment.execute(apiContext, paymentExecution);
        } catch (PayPalRESTException ex) {
            LOGGER.error("Could not execute payment with ID: {}", paymentId);
            throw new ServletException("Error in executing payment");
        }
    }

    private Payer getPayerInformation(final BookOrder order) {
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        Customer customer = order.getCustomer();

        PayerInfo payerInfo = new PayerInfo();
        payerInfo.setFirstName(customer.getFirstname());
        payerInfo.setLastName(customer.getLastname());
        payerInfo.setEmail(customer.getEmail());

        payer.setPayerInfo(payerInfo);

        return payer;
    }

    private RedirectUrls getRedirectUrls() {
        String requestUrl = request.getRequestURL().toString();
        String requestUri = request.getRequestURI();
        String baseUrl = requestUrl.replace(requestUri, "").concat(request.getContextPath());

        String cancelUrl = baseUrl.concat("/view_cart");
        String returnUrl = baseUrl.concat("/review_payment");

        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl(cancelUrl);
        redirectUrls.setReturnUrl(returnUrl);

        return redirectUrls;
    }

    private Amount getAmountDetails(final BookOrder order) {
        Details details = new Details();
        details.setShipping(String.format("%.2f", order.getShippingFee()));
        details.setTax(String.format("%.2f", order.getTax()));
        details.setSubtotal(String.format("%.2f", order.getSubtotal()));

        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setDetails(details);
        amount.setTotal(String.format("%.2f", order.getTotal()));

        return amount;
    }

    private ShippingAddress getRecipientInformation(final BookOrder order) {
        String recipientName = order.getFirstname() + " " + order.getLastname();

        ShippingAddress shippingAddress = new ShippingAddress();
        shippingAddress.setRecipientName(recipientName)
                .setPhone(order.getPhone())
                .setLine1(order.getAddressLine1())
                .setLine2(order.getAddressLine2())
                .setCity(order.getCity())
                .setState(order.getState())
                .setCountryCode(order.getCountry())
                .setPostalCode(order.getZipcode());

        return shippingAddress;
    }

    private List<Transaction> getTransactionInformation(final BookOrder order) {
        Amount amount = getAmountDetails(order);

        ShippingAddress shippingAddress = getRecipientInformation(order);

        ItemList itemList = new ItemList();
        itemList.setShippingAddress(shippingAddress);

        List<Item> paypalItems = new ArrayList<>();
        Iterator<OrderDetail> iterator = order.getOrderDetails().iterator();

        while (iterator.hasNext()) {
            OrderDetail orderDetail = iterator.next();
            Book book = orderDetail.getBook();
            Integer quantity = orderDetail.getQuantity();

            Item paypalItem = new Item();
            paypalItem.setCurrency("USD")
                    .setName(book.getTitle())
                    .setQuantity(String.valueOf(quantity))
                    .setPrice(String.format("%.2f", book.getPrice()));

            paypalItems.add(paypalItem);
        }

        itemList.setItems(paypalItems);

        Transaction transaction = new Transaction();
        transaction.setDescription("Book ordered on PageNook.");
        transaction.setAmount(amount);
        transaction.setItemList(itemList);

        List<Transaction> transactionList = new ArrayList<>();
        transactionList.add(transaction);

        return transactionList;
    }

    private String getApprovalUrl(final Payment authorizedPayment) {
        String approvalUrl = null;

        List<Links> links = authorizedPayment.getLinks();

        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalUrl = link.getHref();
                break;
            }
        }

        return approvalUrl;
    }

}
