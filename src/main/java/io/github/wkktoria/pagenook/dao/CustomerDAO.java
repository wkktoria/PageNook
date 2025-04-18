package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Customer;
import io.github.wkktoria.pagenook.util.HashGeneratorUtil;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerDAO extends JpaDao<Customer> implements GenericDAO<Customer> {
    @Override
    public Customer create(Customer customer) {
        customer.setRegisterDate(new Date());
        return super.create(customer);
    }

    @Override
    public Customer update(Customer customer) {
        return super.update(customer);
    }

    @Override
    public Customer get(Object id) {
        return super.find(Customer.class, id);
    }

    @Override
    public void delete(Object id) {
        super.delete(Customer.class, id);
    }

    @Override
    public List<Customer> listAll() {
        return super.findWithNamedQuery("Customer.findAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Customer.countAll");
    }

    public Customer findByEmail(final String email) {
        List<Customer> result = super.findWithNamedQuery("Customer.findByEmail", "email", email);

        if (!result.isEmpty()) {
            return result.getFirst();
        }

        return null;
    }

    public Customer checkLogin(final String email, final String password) {
        Map<String, Object> parameters = new HashMap<>() {{
            put("email", email);
            put("password", HashGeneratorUtil.generateMD5(password));
        }};
        List<Customer> listCustomer = super.findWithNamedQuery("Customer.checkLogin", parameters);

        if (!listCustomer.isEmpty()) {
            return listCustomer.getFirst();
        }

        return null;
    }
}
