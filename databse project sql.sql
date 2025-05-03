
 -- drop database if exists project;

create database if not exists project;

use project;
create table books_table
(
book_id int primary key,
title varchar(50),
author varchar(40),
publication_year int
);

create table authors_table
(
author_id int primary key,
author_name varchar(40)
);

create table members_table
(
member_id int primary key auto_increment,
member_name varchar(30),
address varchar(60),
email varchar(25),
phone_number varchar(15)
);

create table loans_table
(
loan_id int primary key,
member_id int,
book_id int,
loan_date varchar(15),
return_date varchar(15),

constraint member_fk
foreign key(member_id)
references members_table(member_id),

constraint book_fk
foreign key(book_id)
references books_table(book_id)
);

create table reservations_table
(
reservation_id int primary key,
member_id int,
book_id int,
reservation_date varchar(15),

constraint members_fk
foreign key(member_id)
references members_table(member_id),

constraint books_fk
foreign key(book_id)
references books_table(book_id)
);




