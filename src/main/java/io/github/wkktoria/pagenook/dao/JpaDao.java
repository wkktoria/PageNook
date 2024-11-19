package io.github.wkktoria.pagenook.dao;

import jakarta.persistence.EntityManager;

public class JpaDao<E> {
    protected EntityManager entityManager;

    public JpaDao(final EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public E create(E entity) {
        entityManager.getTransaction().begin();

        entityManager.persist(entity);
        entityManager.flush();
        entityManager.refresh(entity);

        entityManager.getTransaction().commit();

        return entity;
    }

    public E update(E entity) {
        entityManager.getTransaction().begin();

        entity = entityManager.merge(entity);

        entityManager.getTransaction().commit();

        return entity;
    }
}
