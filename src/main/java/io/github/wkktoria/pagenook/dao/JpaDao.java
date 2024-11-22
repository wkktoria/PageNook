package io.github.wkktoria.pagenook.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceException;
import jakarta.persistence.Query;

import java.util.List;

public class JpaDao<E> {
    protected EntityManagerFactory entityManagerFactory;

    public JpaDao(final EntityManagerFactory entityManagerFactory) {
        this.entityManagerFactory = entityManagerFactory;
    }

    public E create(E entity) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        entityManager.getTransaction().begin();

        entityManager.persist(entity);
        entityManager.flush();
        entityManager.refresh(entity);

        entityManager.getTransaction().commit();

        entityManager.close();

        return entity;
    }

    public E update(E entity) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        entityManager.getTransaction().begin();

        entity = entityManager.merge(entity);

        entityManager.getTransaction().commit();

        entityManager.close();

        return entity;
    }

    public E find(Class<E> type, Object id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        E entity = entityManager.find(type, id);

        if (entity != null) {
            entityManager.refresh(entity);
        }

        entityManager.close();

        return entity;
    }

    public void delete(Class<E> type, Object id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        // This prevents infinity loop when deleting nonexistent entity.
        try (entityManager) {
            entityManager.getTransaction().begin();
            Object reference = entityManager.getReference(type, id);
            entityManager.remove(reference);

            entityManager.getTransaction().commit();
        } catch (Exception e) {
            throw new PersistenceException();
        }
    }

    public List<E> findWithNamedQuery(final String queryName) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery(queryName);

        List<E> result = query.getResultList();

        entityManager.close();

        return result;
    }

    public List<E> findWithNamedQuery(final String queryName, final String paramName, Object paramValue) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery(queryName);
        query.setParameter(paramName, paramValue);

        List<E> result = query.getResultList();

        entityManager.close();

        return result;
    }

    public long countWithNamedQuery(final String queryName) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery(queryName);

        long result = (long) query.getSingleResult();

        entityManager.close();

        return result;
    }
}
