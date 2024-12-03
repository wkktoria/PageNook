package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.*;

import java.io.Serializable;

import static jakarta.persistence.GenerationType.IDENTITY;

@Entity
@Table(name = "users")
@NamedQueries({
        @NamedQuery(name = "User.findAll", query = "select u from User u order by u.fullName"),
        @NamedQuery(name = "User.countAll", query = "select count(*) from User"),
        @NamedQuery(name = "User.findByEmail", query = "select u from User u where u.email = :email"),
        @NamedQuery(name = "User.checkLogin", query = "select u from User u where u.email = :email and u.password = :password")
})
public class User implements Serializable {
    private Integer userId;
    private String email;
    private String fullName;
    private String password;

    public User(Integer userId, String email, String fullName, String password) {
        this(email, fullName, password);
        this.userId = userId;
    }

    public User() {
    }

    public User(String email, String fullName, String password) {
        super();
        this.email = email;
        this.fullName = fullName;
        this.password = password;
    }

    @Column(name = "user_id")
    @Id
    @GeneratedValue(strategy = IDENTITY)
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Column(name = "full_name")
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
