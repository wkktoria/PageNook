package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDAO extends JpaDao<User> implements GenericDAO<User> {
    @Override
    public User create(User user) {
        return super.create(user);
    }

    @Override
    public User update(User entity) {
        return super.update(entity);
    }

    @Override
    public User get(Object userId) {
        return super.find(User.class, userId);
    }

    @Override
    public void delete(Object userId) {
        super.delete(User.class, userId);
    }

    @Override
    public List<User> listAll() {
        return super.findWithNamedQuery("User.findAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("User.countAll");
    }

    public User findByEmail(final String email) {
        List<User> listUser = super.findWithNamedQuery("User.findByEmail", "email", email);

        if (listUser != null && !listUser.isEmpty()) {
            return listUser.getFirst();
        }

        return null;
    }

    public boolean checkLogin(final String email, final String password) {
        Map<String, Object> parameters = new HashMap<>() {{
            put("email", email);
            put("password", password);
        }};
        List<User> listUser = super.findWithNamedQuery("User.checkLogin", parameters);

        return listUser.size() == 1;
    }
}
