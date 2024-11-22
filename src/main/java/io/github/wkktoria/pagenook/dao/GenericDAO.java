package io.github.wkktoria.pagenook.dao;

import java.util.List;

public interface GenericDAO<E> {
    E create(E entity);

    E update(E entity);

    E get(Object id);

    void delete(Object id);

    List<E> listAll();

    long count();
}
