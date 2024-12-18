package io.github.wkktoria.pagenook.controller.frontend.shoppingcart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;

@WebServlet("/update_cart")
public class UpdateCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] arrayBookIds = request.getParameterValues("bookId");
        String[] arrayQuantities = new String[arrayBookIds.length];

        for (int i = 1; i <= arrayBookIds.length; i++) {
            String aQuantity = request.getParameter("quantity" + i);
            arrayQuantities[i - 1] = aQuantity;
        }

        int[] bookIds = Arrays.stream(arrayBookIds).mapToInt(Integer::parseInt).toArray();
        int[] quantities = Arrays.stream(arrayQuantities).mapToInt(Integer::parseInt).toArray();

        ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("cart");
        cart.updateCart(bookIds, quantities);

        final String cartPage = request.getContextPath().concat("/view_cart");
        response.sendRedirect(cartPage);
    }
}
