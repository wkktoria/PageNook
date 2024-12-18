package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.BookOrder;

import java.util.Date;
import java.util.List;

public class OrderDAO extends JpaDao<BookOrder> implements GenericDAO<BookOrder> {
    @Override
    public BookOrder create(BookOrder order) {
        order.setOrderDate(new Date());
        order.setStatus("Processing");
        return super.create(order);
    }

    @Override
    public BookOrder get(Object orderId) {
        return super.find(BookOrder.class, orderId);
    }

    @Override
    public void delete(Object id) {

    }

    @Override
    public List<BookOrder> listAll() {
        return super.findWithNamedQuery("BookOrder.findAll");
    }

    @Override
    public long count() {
        return 0;
    }

    public long countOrderDetailByBook(final int bookId) {
        return super.countWithNamedQuery("OrderDetail.countByBook", "bookId", bookId);
    }

    public long countByCustomer(final int customerId) {
        return super.countWithNamedQuery("BookOrder.countByCustomer", "customerId", customerId);
    }
}
