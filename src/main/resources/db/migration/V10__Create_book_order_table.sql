create table `book_order`
(
    `order_id`         int          not null auto_increment,
    `customer_id`      int          not null,
    `order_date`       datetime     not null,
    `shipping_address` varchar(256) not null,
    `recipient_name`   varchar(30)  not null,
    `recipient_phone`  varchar(15)  not null,
    `payment_method`   varchar(20)  not null,
    `total`            float        not null,
    `status`           varchar(20)  not null,
    primary key (`order_id`),
    unique index `order_id_UNIQUE` (`order_id` asc)
);

alter table `book_order`
    add index `customer_fk_2_idx` (`customer_id` asc);

alter table `book_order`
    add constraint `customer_fk_2`
        foreign key (`customer_id`) references `customer` (`customer_id`)
            on delete no action on update no action;