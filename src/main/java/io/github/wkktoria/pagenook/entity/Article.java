package io.github.wkktoria.pagenook.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "article", schema = "pagenook", uniqueConstraints = {
        @UniqueConstraint(name = "title_UNIQUE", columnNames = {"title"})
})
@NamedQueries({
        @NamedQuery(name = "Article.findAll", query = "select a from Article a"),
        @NamedQuery(name = "Article.findByTitle", query = "select a from Article a where a.title = :title"),
        @NamedQuery(name = "Article.countAll", query = "select count(*) from Article a")
})
public class Article {
    private Integer articleId;
    private String title;
    private String content;

    public Article() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "article_id", nullable = false)
    public Integer getArticleId() {
        return articleId;
    }

    public void setArticleId(Integer articleId) {
        this.articleId = articleId;
    }

    @Column(name = "title", nullable = false, length = 64)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Lob
    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Article article = (Article) o;
        return Objects.equals(articleId, article.articleId);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(articleId);
    }
}