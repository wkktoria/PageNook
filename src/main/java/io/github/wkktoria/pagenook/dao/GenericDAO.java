package io.github.wkktoria.pagenook.dao;

import java.util.List;

public interface GenericDAO<T> {
    T create(T entity);

    T update(T entity);

    T get(Object id);

    void delete(Object id);

    List<T> listAll();

    long count();
}
