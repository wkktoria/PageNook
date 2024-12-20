create table `article`
(
    `article_id` int         not null auto_increment,
    `title`      varchar(64) not null,
    `content`    text,
    primary key (`article_id`),
    unique index title_UNIQUE (`title` asc)
)