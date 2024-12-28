package io.github.wkktoria.pagenook.controller.admin.order;

import java.io.IOException;

import io.github.wkktoria.pagenook.service.OrderService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/update_order")
public class UpdateOrderServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		OrderService orderService = new OrderService(request, response);
		orderService.updateOrder();
	}
}
