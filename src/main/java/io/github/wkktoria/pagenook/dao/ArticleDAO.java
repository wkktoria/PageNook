package io.github.wkktoria.pagenook.dao;

import io.github.wkktoria.pagenook.entity.Article;

import java.util.List;

public class ArticleDAO extends JpaDao<Article> implements GenericDAO<Article> {
    @Override
    public Article get(Object articleId) {
        return super.find(Article.class, articleId);
    }

    @Override
    public Article create(Article article) {
        return super.create(article);
    }

    @Override
    public Article update(Article article) {
        return super.update(article);
    }

    @Override
    public void delete(Object id) {
        super.delete(Article.class, id);
    }

    @Override
    public List<Article> listAll() {
        return super.findWithNamedQuery("Article.findAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Article.countAll");
    }

    public Article findByTitle(final String title) {
        List<Article> result = super.findWithNamedQuery("Article.findByTitle", "title", title);

        if (!result.isEmpty()) {
            return result.getFirst();
        }

        return null;
    }
}
