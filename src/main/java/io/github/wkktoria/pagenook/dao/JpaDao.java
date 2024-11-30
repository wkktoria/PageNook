package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.util.HibernateUtil;
import jakarta.persistence.Entity;
import jakarta.persistence.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;
import java.util.Map;
import java.util.Set;

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
    }

    public E update(E entity) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        session.merge(entity);

        transaction.commit();
        session.close();

        return entity;
    }

    public E find(Class<E> type, Object id) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        E entity = session.get(type, id);

        if (entity != null) {
            session.refresh(entity);
        }

        session.close();

        return entity;
    }

    public void delete(Class<E> type, Object id) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();

        Object reference = session.getReference(type, id);
        session.remove(reference);

        transaction.commit();
        session.close();
    }

    public List<E> findWithNamedQuery(final String queryName) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Query query = session.createNamedQuery(queryName, Entity.class);

        List<E> result = query.getResultList();

        session.close();

        return result;
    }

    public List<E> findWithNamedQuery(final String queryName, final String paramName, Object paramValue) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Query query = session.createNamedQuery(queryName, Entity.class);
        query.setParameter(paramName, paramValue);

        List<E> result = query.getResultList();

        session.close();

        return result;
    }

    public List<E> findWithNamedQuery(final String queryName, final Map<String, Object> parameters) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Query query = session.createNamedQuery(queryName, Entity.class);

        Set<Map.Entry<String, Object>> setParameters = parameters.entrySet();

        for (Map.Entry<String, Object> entry : setParameters) {
            query.setParameter(entry.getKey(), entry.getValue());
        }

        List<E> result = query.getResultList();

        session.close();

        return result;
    }

    public long countWithNamedQuery(final String queryName) {
        Session session = HibernateUtil.getSessionFactory().openSession();

        Query query = session.createNamedQuery(queryName, Entity.class);

        long result = (long) query.getSingleResult();

        session.close();

        return result;
    }
}
