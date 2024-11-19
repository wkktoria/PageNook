package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
@NamedQueries({
        @NamedQuery(name = "Users.findAll", query = "select u from User u order by u.fullName"),
        @NamedQuery(name = "Users.countAll", query = "select count(*) from User")
})
public class User {
    private Integer userId;
    private String email;
    private String fullName;
    private String password;

    public User() {
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

    @Column(name = "email")
    public String getEmail() {
        return email;
    }

    public void setEmail(final String email) {
        this.email = email;
    }

    @Column(name = "full_name")
    public String getFullName() {
        return fullName;
    }

    public void setFullName(final String fullName) {
        this.fullName = fullName;
    }

    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(final String password) {
        this.password = password;
    }
}
