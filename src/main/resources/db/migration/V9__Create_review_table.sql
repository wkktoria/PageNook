create table `review`
(
    `review_id`   int          not null auto_increment,
    `book_id`     int          not null,
    `customer_id` int          not null,
    `rating`      int          not null,
    `headline`    varchar(128) not null,
    `comment`     varchar(500) not null,
    `review_time` datetime     not null,
    primary key (`review_id`),
    unique index `review_id_UNIQUE` (`review_id` asc)
);

alter table `review`
    add index `book_fk_idx` (`book_id` asc);

alter table `review`
    add constraint `book_fk`
        foreign key (`book_id`) references `book` (`book_id`)
            on delete no action on update no action;

alter table `review`
    add index `customer_fk_idx` (`customer_id` asc);

alter table `review`
    add constraint `customer_fk`
        foreign key (`customer_id`) references `customer` (`customer_id`)
            on delete no action on update no action;