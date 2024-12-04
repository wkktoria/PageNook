package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Book;

import java.util.Date;
import java.util.List;

public class BookDAO extends JpaDao<Book> implements GenericDAO<Book> {
    @Override
    public Book update(Book book) {
        book.setLastUpdateTime(new Date());
        return super.update(book);
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

    public Book findByTitle(final String title) {
        List<Book> result = super.findWithNamedQuery("Book.findByTitle", "title", title);

        if (!result.isEmpty()) {
            return result.getFirst();
        }

        return null;
    }
}
