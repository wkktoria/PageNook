package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Category;

import java.util.List;

public class CategoryDAO extends JpaDao<Category> implements GenericDAO<Category> {
    @Override
    public Category create(Category category) {
        return super.create(category);
    }

    @Override
    public Category update(Category category) {
        return super.update(category);
    }

    @Override
    public Category get(Object categoryId) {
        return super.find(Category.class, categoryId);
    }

    @Override
    public void delete(Object categoryId) {
        super.delete(Category.class, categoryId);
    }

    @Override
    public List<Category> listAll() {
        return super.findWithNamedQuery("Category.findAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Category.countAll");
    }

    public Category findByName(final String name) {
        List<Category> categoryList = super.findWithNamedQuery("Category.findByName", "name", name);

        if (categoryList != null && !categoryList.isEmpty()) {
            return categoryList.getFirst();
        }

        return null;
    }
}
