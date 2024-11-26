alter table `users`
    change column `user_id` `user_id` int not null auto_increment;

alter table `category`
    change column `category_id` `category_id` int not null auto_increment;