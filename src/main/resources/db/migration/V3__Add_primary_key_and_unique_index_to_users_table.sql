alter table `users`
    add primary key (`user_id`),
    add unique index `user_id_UNIQUE` (`user_id` asc);