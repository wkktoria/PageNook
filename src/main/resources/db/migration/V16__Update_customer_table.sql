alter table `customer` rename column `fullname` to `firstname`;
alter table `customer` rename column `address` to `address_line1`;

alter table `customer`
    add column `lastname` varchar(30) not null default '';
alter table `customer`
    add column `address_line2` varchar(128) not null default '';
alter table `customer`
    add column `state` varchar(45) not null default '';
