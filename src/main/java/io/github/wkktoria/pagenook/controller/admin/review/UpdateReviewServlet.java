package io.github.wkktoria.pagenook.controller.admin.review;

import io.github.wkktoria.pagenook.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/update_review")
public class UpdateReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReviewService reviewService = new ReviewService(request, response);
        reviewService.updateReview();
    }
}
