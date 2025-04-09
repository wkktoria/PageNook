create table `book`
(
    `book_id`          int          not null,
    `title`            varchar(128) not null,
    `author`           varchar(64)  not null,
    `description`      mediumtext   not null,
    `isbn`             varchar(15)  not null,
    `image`            longblob     not null,
    `price`            float        not null,
    `publish_date`     date         not null,
    `last_update_time` datetime     not null,
    `category_id`      varchar(45)  not null,
    primary key (`book_id`),
    unique index `book_id_UNIQUE` (`book_id` asc),
    unique index `title_UNIQUE` (`title` asc)
);

alter table `book`
    change column `book_id` `book_id` int not null auto_increment,
    change column `category_id` `category_id` int not null,
    add index `category_fk_idx` (`category_id` asc);

alter table `book`
    add constraint `category_fk`
        foreign key (`category_id`) references `category` (`category_id`)
            on delete no action on update no action;