package io.github.wkktoria.pagenook.dao;

import jakarta.persistence.EntityManager;

public class JpaDao<T> {
    protected EntityManager entityManager;

    public JpaDao(final EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public T create(T entity) {
        entityManager.getTransaction().begin();

        entityManager.persist(entity);
        entityManager.flush();
        entityManager.refresh(entity);

        entityManager.getTransaction().commit();

        return entity;
    }
}
