create table `customer`
(
    `customer_id`   int          not null auto_increment,
    `email`         varchar(64)  not null,
    `fullname`      varchar(30)  not null,
    `address`       varchar(128) not null,
    `city`          varchar(32)  not null,
    `country`       varchar(64)  not null,
    `phone`         varchar(15)  not null,
    `zipcode`       varchar(24)  not null,
    `password`      varchar(16)  not null,
    `register_date` datetime     not null,
    primary key (`customer_id`),
    unique index `customer_id_UNIQUE` (`customer_id` asc),
    unique index `email_UNIQUE` (`email` asc)
);