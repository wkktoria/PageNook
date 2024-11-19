package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Users;
import jakarta.persistence.EntityManager;

import java.util.List;

public class UsersDAO extends JpaDao<Users> implements GenericDAO<Users> {
    public UsersDAO(final EntityManager entityManager) {
        super(entityManager);
    }

    @Override
    public Users create(Users user) {
        return super.create(user);
    }

    @Override
    public Users update(Users entity) {
        return super.update(entity);
    }

    @Override
    public Users get(Object userId) {
        return super.find(Users.class, userId);
    }

    @Override
    public void delete(Object userId) {
        super.delete(Users.class, userId);
    }

    @Override
    public List<Users> listAll() {
        return super.findWithNamedQuery("Users.findAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Users.countAll");
    }
}
