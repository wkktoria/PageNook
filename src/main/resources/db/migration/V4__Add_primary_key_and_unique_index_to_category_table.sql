alter table `category`
    add primary key (`category_id`),
    add unique index `category_id_UNIQUE` (`category_id` asc);