package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.BookOrder;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public BookOrder get(final Integer orderId, final Integer customerId) {
        Map<String, Object> parameters = new HashMap<>() {
            {
                put("orderId", orderId);
                put("customerId", customerId);
            }
        };
        List<BookOrder> result = super.findWithNamedQuery("BookOrder.findByIdAndCustomer", parameters);

        if (!result.isEmpty()) {
            return result.getFirst();
        }

        return null;
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

    @Override
    public BookOrder update(BookOrder order) {
        return super.update(order);
    }

    public long countOrderDetailByBook(final int bookId) {
        return super.countWithNamedQuery("OrderDetail.countByBook", "bookId", bookId);
    }

    public long countByCustomer(final int customerId) {
        return super.countWithNamedQuery("BookOrder.countByCustomer", "customerId", customerId);
    }

    public List<BookOrder> listByCustomer(final int customerId) {
        return super.findWithNamedQuery("BookOrder.findByCustomer", "customerId", customerId);
    }
}
