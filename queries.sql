-- Query questions 
-- 1 list all books in the library

select title
from books_table;

-- 2 list all members in the library

select member_name as Members
from members_table;

-- list all currently loaned books

/*select*
from loans_table
where return_date = 5/25/2022;*/

-- 3 list the books published in the year 2019

select*
from books_table
where publication_year = 2019;

-- 4  list the book_id's which are less than 10 from loans_table and order by asc order

select*
from loans_table
where book_id < 10
order by book_id asc;

-- 5 Show all currently loaned books

select l.loan_id, m.member_name, b.title, b.author, l.loan_date, l.return_date
from loans_table l
join members_table m on l.member_id = m.member_id
join books_table b on l.book_id = b.book_id
where l.return_date is null or l.return_date > current_date();

-- 6 list all book reservations

select r.reservation_id, m.member_name, b.title, b.author, r.reservation_date
from reservations_table r
join members_table m on r.member_id = m.member_id
join books_table b on r.book_id = b.book_id;

-- 7 find members who borrowed more than 5 books

select member_id, member_name
from members_table
where member_id in (
    select member_id
    from loans_table
    group by member_id
    having count(book_id) > 5
);


-- 8 list books borrowed by the member who borrowed the most books

select title
from books_table
where book_id in (
    select book_id
    from loans_table
    where member_id = (
        select member_id
        from loans_table
        group by member_id
        order by count(*) DESC
        limit 1
    )
);

-- 9 list books that have never been borrowed

select book_id, title
from books_table
where book_id not in (
    select distinct book_id
    from loans_table
);

-- 10 Find the top 3 members who have borrowed the most distinct books, 
-- along with their contact info and total number of books borrowed.

select
    m.member_id,
    m.member_name,
    m.email,
    m.phone_number,
    count(distinct l.book_id) as total_books_borrowed
from
    members_table m
join 
    loans_table l on m.member_id = l.member_id
where 
    l.book_id in (
        select book_id
        from books_table
        where publication_year > 2010
    )
group by
    m.member_id, m.member_name, m.email, m.phone_number
having
    count(distinct l.book_id) > 1
order by 
    total_books_borrowed desc
limit 3;



