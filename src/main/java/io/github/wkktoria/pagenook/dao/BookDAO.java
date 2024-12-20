package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Book;

import java.util.ArrayList;
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

    public List<Book> listNewBooks() {
        return super.findWithNamedQuery("Book.listNew", 0, 4);
    }

    public List<Book> search(final String keyword) {
        return super.findWithNamedQuery("Book.search", "keyword", keyword);
    }

    public long countByCategory(final Integer categoryId) {
        return super.countWithNamedQuery("Book.countByCategory", "categoryId", categoryId);
    }

    public List<Book> listBestSellingBooks() {
        return super.findWithNamedQuery("OrderDetail.bestSelling", 0, 4);
    }

    public List<Book> listMostFavoredBooks() {
        List<Book> mostFavoredBooks = new ArrayList<>();
        List<Object[]> result = super.findWithNamedQueryObjects("Review.mostFavoredBooks", 0, 4);

        if (!result.isEmpty()) {
            for (Object[] elements : result) {
                Book book = (Book) elements[0];
                mostFavoredBooks.add(book);
            }
        }

        return mostFavoredBooks;
    }
}
