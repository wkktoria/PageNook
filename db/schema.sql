create database `pagenookdb`;
use `pagenookdb`;

create table `users` (
	`user_id` int not null,
	`email` varchar(64) not null,
	`password` varchar(16) not null,
	`full_name` varchar(30) not null
);

create table `category` (
	`category_id` int not null,
	`name` varchar(30) not null
);

alter table `users`
add primary key(`user_id`),
add unique index `user_id_UNIQUE`(`user_id` asc);

alter table `category`
add primary key(`category_id`),
add unique index `category_id_UNIQUE`(`category_id` asc);

alter table `users`
change column `user_id` `user_id` int not null auto_increment;

alter table `category`
change column `category_id` `category_id` int not null auto_increment;

create table `book` (
	`book_id` int not null,
	`title` varchar(128) not null,
	`author` varchar(64) not null,
	`description` mediumtext not null,
	`isbn` varchar(15) not null,
	`image` blob not null,
	`price` float not null,
	`publish_date` date not null,
	`last_update_time` datetime not null,
	`category_id` varchar(45) not null,
	primary key(`book_id`),
	unique index `book_id_UNIQUE`(`book_id` asc),
	unique index `title_UNIQUE`(`title` asc)
);

alter table `book`
change column `book_id` `book_id` int not null auto_increment,
change column `category_id` `category_id` int not null,
add index `category_fk_idx`(`category_id` asc);

alter table `book`
add constraint `category_fk`
foreign key(`category_id`) references `category`(`category_id`)
on delete no action on update no action;

create table `customer` (
	`customer_id` int not null auto_increment,
	`email` varchar(64) not null,
	`fullname` varchar(30) not null,
	`address` varchar(128) not null,
	`city` varchar(32) not null,
	`country` varchar(64) not null,
	`phone` varchar(15) not null,
	`zipcode` varchar(24) not null,
	`password` varchar(16) not null,
	`register_date` datetime not null,
	primary key(`customer_id`),
	unique index `customer_id_UNIQUE`(`customer_id` asc),
	unique index `email_UNIQUE`(`email` asc)
);

create table `review` (
	`review_id` int not null auto_increment,
	`book_id` int not null,
	`customer_id` int not null,
	`rating` int not null,
	`headline` varchar(128) not null,
	`comment` varchar(500) not null,
	`review_time` datetime not null,
	primary key(`review_id`),
	unique index `review_id_UNIQUE`(`review_id` asc)
);

alter table `review`
add index `book_fk_idx`(`book_id` asc);

alter table `review`
add constraint `book_fk`
foreign key(`book_id`) references `book`(`book_id`)
on delete no action on update no action;

alter table `review`
add index `customer_fk_idx`(`customer_id` asc);

alter table `review`
add constraint `customer_fk`
foreign key(`customer_id`) references `customer`(`customer_id`)
on delete no action on update no action;

create table `book_order` (
	`order_id` int not null auto_increment,
	`customer_id` int not null,
	`order_date` datetime not null,
	`shipping_address` varchar(256) not null,
	`recipient_name` varchar(30) not null,
	`recipient_phone` varchar(15) not null,
	`payment_method` varchar(20) not null,
	`total` float not null,
	`status` varchar(20) not null,
	primary key(`order_id`),
	unique index `order_id_UNIQUE`(`order_id` asc)
);

alter table `book_order`
add index `customer_fk_2_idx`(`customer_id` asc);

alter table `book_order`
add constraint `customer_fk_2`
foreign key(`customer_id`) references `customer`(`customer_id`)
on delete no action on update no action;

create table `order_detail` (
	`order_id` int not null,
	`book_id` int not null,
	`quantity` int not null,
	`subtotal` float not null
);

alter table `order_detail`
add index `order_fk_idx`(`order_id` asc),
add index `book_fk_2_idx`(`book_id` asc);

alter table `order_detail`
add constraint `order_fk`
foreign key(`order_id`) references `book_order`(`order_id`)
on delete no action on update no action,
add constraint `book_fk_2`
foreign key(`book_id`) references `book`(`book_id`)
on delete no action on update no action;