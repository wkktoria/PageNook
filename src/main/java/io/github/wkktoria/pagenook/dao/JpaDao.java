package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.util.HibernateUtil;
import jakarta.persistence.Entity;
import jakarta.persistence.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class JpaDao<E> {
    public E create(E entity) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        session.persist(entity);
        session.flush();
        session.refresh(entity);

        transaction.commit();
        session.close();

        return entity;
//        EntityManager entityManager = entityManagerFactory.createEntityManager();
//
//        entityManager.getTransaction().begin();
//
//        entityManager.persist(entity);
//        entityManager.flush();
//        entityManager.refresh(entity);
//
//        entityManager.getTransaction().commit();
//
//        entityManager.close();
//
//        return entity;
    }

    public E update(E entity) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        session.merge(entity);

        transaction.commit();
        session.close();

        return entity;
//        EntityManager entityManager = entityManagerFactory.createEntityManager();
//
//        entityManager.getTransaction().begin();
//
//        entity = entityManager.merge(entity);
//
//        entityManager.getTransaction().commit();
//
//        entityManager.close();
//
//        return entity;
    }

    public E find(Class<E> type, Object id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        E entity = session.get(type, id);

        if (entity != null) {
            session.refresh(entity);
        }

        session.close();

        return entity;

//        EntityManager entityManager = entityManagerFactory.createEntityManager();
//
//        E entity = entityManager.find(type, id);
//
//        if (entity != null) {
//            entityManager.refresh(entity);
//        }
//
//        entityManager.close();
//
//        return entity;
    }

    public void delete(Class<E> type, Object id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        Object reference = session.getReference(type, id);
        session.remove(reference);

        transaction.commit();
        session.close();

//        EntityManager entityManager = entityManagerFactory.createEntityManager();
//
//        // This prevents infinity loop when deleting nonexistent entity.
//        try (entityManager) {
//            entityManager.getTransaction().begin();
//            Object reference = entityManager.getReference(type, id);
//            entityManager.remove(reference);
//
//            entityManager.getTransaction().commit();
//        } catch (Exception e) {
//            throw new PersistenceException();
//        }
    }

    public List<E> findWithNamedQuery(final String queryName) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Query query = session.createNamedQuery(queryName, Entity.class);

        List<E> result = query.getResultList();

        session.close();

        return result;
//        EntityManager entityManager = entityManagerFactory.createEntityManager();
//
//        Query query = entityManager.createNamedQuery(queryName);
//
//        List<E> result = query.getResultList();
//
//        entityManager.close();
//
//        return result;
    }

    public List<E> findWithNamedQuery(final String queryName, final String paramName, Object paramValue) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Query query = session.createNamedQuery(queryName, Entity.class);
        query.setParameter(paramName, paramValue);

        List<E> result = query.getResultList();

        session.close();

        return result;
//        EntityManager entityManager = entityManagerFactory.createEntityManager();
//
//        Query query = entityManager.createNamedQuery(queryName);
//        query.setParameter(paramName, paramValue);
//
//        List<E> result = query.getResultList();
//
//        entityManager.close();
//
//        return result;
    }

    public long countWithNamedQuery(final String queryName) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Query query = session.createNamedQuery(queryName, Entity.class);

        long result = (long) query.getSingleResult();

        session.close();

        return result;
//        EntityManager entityManager = entityManagerFactory.createEntityManager();
//
//        Query query = entityManager.createNamedQuery(queryName);
//
//        long result = (long) query.getSingleResult();
//
//        entityManager.close();
//
//        return result;
    }
}
