package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.BookOrder;

import java.util.Date;
import java.util.List;

public class OrderDAO extends JpaDao<BookOrder> implements GenericDAO<BookOrder> {
    @Override
    public BookOrder create(BookOrder order) {
        order.setOrderDate(new Date());
        order.setPaymentMethod("Cash on Delivery");
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
}
