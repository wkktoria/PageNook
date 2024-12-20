package io.github.wkktoria.pagenook.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;

import java.util.List;
import java.util.Map;
import java.util.Set;

public class JpaDao<E> {
    private static final EntityManagerFactory entityManagerFactory;

    static {
        entityManagerFactory = Persistence.createEntityManagerFactory("PageNook");
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
        entityManager.getTransaction().begin();

        Object reference = entityManager.getReference(type, id);
        entityManager.remove(reference);

        entityManager.getTransaction().commit();
        entityManager.close();
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

    public List<E> findWithNamedQuery(final String queryName, final Map<String, Object> parameters) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery(queryName);

        Set<Map.Entry<String, Object>> setParameters = parameters.entrySet();
        for (Map.Entry<String, Object> entry : setParameters) {
            query.setParameter(entry.getKey(), entry.getValue());
        }

        List<E> result = query.getResultList();

        entityManager.close();

        return result;
    }

    public List<E> findWithNamedQuery(final String queryName, int first, int max) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery(queryName);
        query.setFirstResult(first);
        query.setMaxResults(max);

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

    public long countWithNamedQuery(final String queryName, final String paramName, Object paramValue) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery(queryName);
        query.setParameter(paramName, paramValue);

        long result = (long) query.getSingleResult();

        entityManager.close();

        return result;
    }

    public List<Object[]> findWithNamedQueryObjects(final String queryName, int first, int max) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();

        Query query = entityManager.createNamedQuery(queryName);
        query.setFirstResult(first);
        query.setMaxResults(max);

        List<Object[]> result = query.getResultList();

        entityManager.close();

        return result;
    }

    public void close() {
        if (entityManagerFactory != null) {
            entityManagerFactory.close();
        }
    }
}
