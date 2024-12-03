package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Book;

import java.util.Date;
import java.util.List;

public class BookDAO extends JpaDao<Book> implements GenericDAO<Book> {
    @Override
    public Book update(Book entity) {
        return super.update(entity);
    }

    @Override
    public Book get(Object id) {
        return null;
    }

    @Override
    public void delete(Object id) {

    }

    @Override
    public List<Book> listAll() {
        return super.findWithNamedQuery("Book.findAll");
    }

    @Override
    public long count() {
        return 0;
    }

    @Override
    public Book create(Book book) {
        book.setLastUpdateTime(new Date());
        return super.create(book);
    }

    @Override
    public Book find(Class<Book> type, Object id) {
        return super.find(type, id);
    }

    @Override
    public void delete(Class<Book> type, Object id) {
        super.delete(type, id);
    }
}
