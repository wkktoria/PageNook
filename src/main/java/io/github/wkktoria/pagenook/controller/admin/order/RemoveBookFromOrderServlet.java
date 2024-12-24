package io.github.wkktoria.pagenook.controller.admin.order;

import static io.github.wkktoria.pagenook.util.CommonUtil.forwardToPage;

import java.io.IOException;
import java.util.Iterator;
import java.util.Set;

import io.github.wkktoria.pagenook.entity.BookOrder;
import io.github.wkktoria.pagenook.entity.OrderDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/remove_book_from_order")
public class RemoveBookFromOrderServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		final int bookId = Integer.parseInt(request.getParameter("id"));
		HttpSession session = request.getSession();

		BookOrder order = (BookOrder) session.getAttribute("order");
		Set<OrderDetail> orderDetails = order.getOrderDetails();
		Iterator<OrderDetail> iterator = orderDetails.iterator();

		while (iterator.hasNext()) {
			OrderDetail orderDetail = iterator.next();

			if (orderDetail.getBook().getBookId().equals(bookId)) {
				final float newTotal = order.getTotal() - orderDetail.getSubtotal();
				order.setTotal(newTotal);

				iterator.remove();
			}
		}

		final String editOrderFormPage = "order_form.jsp";
		forwardToPage(editOrderFormPage, request, response);
	}

}
