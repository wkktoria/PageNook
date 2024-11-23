package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Category;
import jakarta.persistence.EntityManagerFactory;

import java.util.List;

public class CategoryDAO extends JpaDao<Category> implements GenericDAO<Category> {
    public CategoryDAO(final EntityManagerFactory entityManagerFactory) {
        super(entityManagerFactory);
    }

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
}
