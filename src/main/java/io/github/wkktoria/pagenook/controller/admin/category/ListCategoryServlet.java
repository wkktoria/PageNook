package io.github.wkktoria.pagenook.controller.admin.category;

import io.github.wkktoria.pagenook.controller.admin.BaseServlet;
import io.github.wkktoria.pagenook.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/list_category")
public class ListCategoryServlet extends BaseServlet {
    @Override
    protected void doGet(HttpServletRequest reqeust, HttpServletResponse response) throws ServletException, IOException {
        CategoryService categoryService = new CategoryService(entityManagerFactory, reqeust, response);
        categoryService.listCategory();
    }
}
