package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
@NamedQueries({
        @NamedQuery(name = "User.findAll", query = "select u from User u order by u.fullName"),
        @NamedQuery(name = "User.countAll", query = "select count(*) from User"),
        @NamedQuery(name = "User.findByEmail", query = "select u from User u where u.email = :email"),
        @NamedQuery(name = "User.checkLogin", query = "select u from User u where u.email = :email and u.password = :password")
})
public class User {
    private Integer userId;
    private String email;
    private String fullName;
    private String password;

    public User() {
    }

    public User(final String email, final String fullName, final String password) {
        this.email = email;
        this.fullName = fullName;
        this.password = password;
    }

    public User(final Integer userId, final String email, final String fullName, final String password) {
        this.userId = userId;
        this.email = email;
        this.fullName = fullName;
        this.password = password;
    }

    @Column(name = "user_id")
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(final Integer userId) {
        this.userId = userId;
    }

    @Column(name = "email", nullable = false)
    public String getEmail() {
        return email;
    }

    public void setEmail(final String email) {
        this.email = email;
    }

    @Column(name = "full_name", nullable = false)
    public String getFullName() {
        return fullName;
    }

    public void setFullName(final String fullName) {
        this.fullName = fullName;
    }

    @Column(name = "password", nullable = false)
    public String getPassword() {
        return password;
    }

    public void setPassword(final String password) {
        this.password = password;
    }
}
