package io.github.wkktoria.pagenook.controller.admin.category;

import io.github.wkktoria.pagenook.controller.admin.BaseServlet;
import io.github.wkktoria.pagenook.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/update_category")
public class UpdateCategoryServlet extends BaseServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryService categoryService = new CategoryService(entityManagerFactory, request, response);
        categoryService.updateCategory();
    }
}