package io.github.wkktoria.pagenook.service;

import io.github.wkktoria.pagenook.dao.ReviewDAO;
import io.github.wkktoria.pagenook.entity.Review;
import io.github.wkktoria.pagenook.util.CommonUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class ReviewService {
    private final ReviewDAO reviewDAO;
    private final HttpServletRequest request;
    private final HttpServletResponse response;

    public ReviewService(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;

        reviewDAO = new ReviewDAO();
    }

    public void listAllReview() throws ServletException, IOException {
        List<Review> listReview = reviewDAO.listAll();

        request.setAttribute("listReview", listReview);

        final String listPage = "review_list.jsp";
        CommonUtil.forwardToPage(listPage, request, response);
    }
}
