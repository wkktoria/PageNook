package io.github.wkktoria.pagenook.controller.admin.review;

import io.github.wkktoria.pagenook.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/edit_review")
public class EditReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReviewService reviewService = new ReviewService(request, response);
        reviewService.editReview();
    }
}
