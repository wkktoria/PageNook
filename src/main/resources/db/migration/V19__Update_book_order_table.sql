alter table `book_order` rename column `shipping_address` to `r_address_line1`;
alter table `book_order` rename column `recipient_name` to `r_firstname`;
alter table `book_order` rename column `recipient_phone` to `r_phone`;

alter table `book_order`
    add column `r_lastname` varchar(30) not null default '';
alter table `book_order`
    add column `r_address_line2` varchar(256) not null default '';
alter table `book_order`
    add column `r_country` varchar(4) not null default '';
alter table `book_order`
    add column `r_state` varchar(45) not null default '';
alter table `book_order`
    add column `r_zipcode` varchar(24) not null default '';
alter table `book_order`
    add column `r_city` varchar(32) not null default '';
alter table `book_order`
    add column `shipping_fee` float not null default 0;
alter table `book_order`
    add column `tax` float not null default 0;
alter table `book_order`
    add column `subtotal` float not null default 0;
