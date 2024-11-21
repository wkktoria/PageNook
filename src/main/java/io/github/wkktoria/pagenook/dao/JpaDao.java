package io.github.wkktoria.pagenook.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;

import java.util.List;

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

    public E find(Class<E> type, Object id) {
        E entity = entityManager.find(type, id);

        if (entity != null) {
            entityManager.refresh(entity);
        }

        return entity;
    }

    public void delete(Class<E> type, Object id) {
        entityManager.getTransaction().begin();

        Object reference = entityManager.getReference(type, id);
        entityManager.remove(reference);

        entityManager.getTransaction().commit();
    }

    public List<E> findWithNamedQuery(final String queryName) {
        Query query = entityManager.createNamedQuery(queryName);
        return query.getResultList();
    }

    public List<E> findWithNamedQuery(final String queryName, final String paramName, Object paramValue) {
        Query query = entityManager.createNamedQuery(queryName);
        query.setParameter(paramName, paramValue);
        return query.getResultList();
    }

    public long countWithNamedQuery(final String queryName) {
        Query query = entityManager.createNamedQuery(queryName);
        return (long) query.getSingleResult();
    }
}
