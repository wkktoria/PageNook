package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.OrderDAO;
import io.github.wkktoria.pagenook.entity.BookOrder;
import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

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
}
