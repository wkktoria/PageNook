create table `order_detail`
(
    `order_id` int   not null,
    `book_id`  int   not null,
    `quantity` int   not null,
    `subtotal` float not null
);

alter table `order_detail`
    add index `order_fk_idx` (`order_id` asc),
    add index `book_fk_2_idx` (`book_id` asc);

alter table `order_detail`
    add constraint `order_fk`
        foreign key (`order_id`) references `book_order` (`order_id`)
            on delete no action on update no action,
    add constraint `book_fk_2`
        foreign key (`book_id`) references `book` (`book_id`)
            on delete no action on update no action;