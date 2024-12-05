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
    public Book get(Object bookId) {
        return super.find(Book.class, bookId);
    }

    @Override
    public void delete(Object bookId) {
        super.delete(Book.class, bookId);
    }

    @Override
    public List<Book> listAll() {
        return super.findWithNamedQuery("Book.findAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Book.countAll");
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

    public Book findByTitle(final String title) {
        List<Book> result = super.findWithNamedQuery("Book.findByTitle", "title", title);

        if (!result.isEmpty()) {
            return result.getFirst();
        }

        return null;
    }

    public List<Book> listByCategory(final Integer categoryId) {
        return super.findWithNamedQuery("Book.findByCategory", "categoryId", categoryId);
    }
}
