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
    public Users get(Object id) {
        return null;
    }

    @Override
    public void delete(Object id) {

    }

    @Override
    public List<Users> listAll() {
        return List.of();
    }

    @Override
    public long count() {
        return 0;
    }
}
