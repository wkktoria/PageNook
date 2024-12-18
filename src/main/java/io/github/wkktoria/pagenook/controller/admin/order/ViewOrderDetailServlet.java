package io.github.wkktoria.pagenook.controller.admin.order;

import io.github.wkktoria.pagenook.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/view_order")
public class ViewOrderDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderService orderService = new OrderService(request, response);
        orderService.viewOrderDetailForAdmin();
    }
}
