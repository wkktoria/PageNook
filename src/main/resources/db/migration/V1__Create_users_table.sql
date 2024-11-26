create table `users`
(
    `user_id`   int         not null,
    `email`     varchar(64) not null,
    `password`  varchar(16) not null,
    `full_name` varchar(30) not null
);