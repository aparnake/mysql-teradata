
# MySQL Queues 

select payment.customer_id, count(payment.customer_id), sum(payment.amount)
from
	payment
group by 
	payment.customer_id;


select payment.customer_id, count(payment.customer_id)
from
	payment
group by 
	payment.customer_id;
select payment.customer_id, count(payment.customer_id)
from
	rental,payment
group by 
	payment.customer_id;
select rental.customer_id, count(rental.customer_id)
from
	rental
group by 
	rental.customer_id;
select count(rental.customer_id)
from
	rental
group by 
	rental.customer_id;
select rental.rental_id, count(rental.customer_id)
from
	rental
group by 
	rental.customer_id;
select rental.rentail_id, count(rental.customer_id)
from
	rental
group by 
	rental.customer_id;
select
	inventory.store_id,film.rating,sum(payment.amount)
from
	film,payment,inventory,rental
where
	payment.rental_id=rental.rental_id and
	rental.inventory_id=inventory.inventory_id and
	inventory.film_id=film.film_id and
	inventory.store_id= 1 and
	film.rating in ('R', 'PG-13')
group by 1, 2
order by 3 desc;
where
	payment.rental_id=rental.rental_id and
	rental.inventory_id=inventory.inventory_id and
	inventory.film_id=film.film_id and
	inventory.store_id=1 and
	film.rating in ('R' and 'PG-13')
group by 1, 2
order by 3 desc;
select
	inventory.store_id,film.rating,sum(payment.amount)
from
	film,payment,inventory,rental
where
	payment.rental_id=rental.rental_id and
	rental.inventory_id=inventory.inventory_id and
	inventory.fil_id=film.film_id and
	inventory.store_id=1 and
	film.rating in ('R' and 'PG-13')
group by 1, 2
order by 3 desc;
select film.title as FileTitle , count(film.title)
 from rental,inventory,film;
#How many times each movie has been rented out.
 select rental.rental_date,rental.inventory_id,inventory.film_id,film.title
 from rental,inventory,film
 where rental.inventory_id=inventory.inventory_id and 
 inventory.film_id = film.`film_id`
 
  #How many times each movie has been rented out.
 select film.title as FileTitle , count(film.title)
 from rental,inventory,film
 where rental.inventory_id=inventory.inventory_id and 
 inventory.film_id = film.`film_id`
 group by film.title
 order by count(film.title) desc
 
 #How many times each movie CD i.e Per CD has been rented out with revenue earned.
 select film.title , inventory.`inventory_id`,  inventory.`film_id`, inventory.`film_id`, rental.`inventory_id` , film.rental_rate  , count(inventory.`inventory_id`) as TotalRentals, film.rental_rate * count(rental.`inventory_id`) as Revenue
 from rental,inventory,film
 where 
 rental.`inventory_id` = inventory.`inventory_id` and
 inventory.`film_id` = film.film_id
 group by inventory.`inventory_id`
 order by film.title, Revenue desc
 
 #How many times each movie has been rented out with revenue earned.
 select film.title , film.rental_rate  , count(inventory.`film_id`) as TotalRentals , count(inventory.`film_id`) * film.rental_rate as revenue
 from rental,inventory,film
 where 
 rental.`inventory_id` = inventory.`inventory_id` and
 inventory.`film_id` = film.film_id
 group by inventory.`film_id`
 order by revenue desc
 
 #which customer brought in more money?
 select payment.`customer_id`,sum(payment.amount)
 from payment
 group by 1
 order by 2 desc
 
 #which store brought in more money?
 # Revenue by store.
select
		sum(payment.amount),
		inventory.`store_id`
from
	inventory,
	rental,
	payment
where
	inventory.inventory_id = rental.inventory_id and 
	rental.rental_id = payment.rental_id
group by
	inventory.`store_id`
order by
	inventory.`store_id` desc
	

#how many rentals each month
SELECT
	left(rental.rental_date,7),count(rental_id)
from
	rental
group by
	1
order by
	2 desc
	
#finding first and last date of each movie rental
select
	min(rental.rental_date),max(rental.rental_date),film.title
from
	rental,inventory,film
where
	rental.inventory_id=inventory.inventory_id and film.film_id=inventory.film_id
group by 
	film.title
	
#every customers last rental date
SELECT
	max(rental.rental_date),customer.`first_name`,customer.`last_name`
from 
	customer,rental
where
	rental.customer_id=customer.customer_id
group by 
	customer.customer_id
	
#revenue by month
select
	left(payment.payment_date,7),sum(payment.amount)	
from
	payment
group by	
	1
	
#Distinct
#how many distinct renters per month
select
	left(rental.rental_date,7),count(distinct(rental.customer_id)),count(rental.rental_id),count(rental.rental_id)/count(distinct(rental.customer_id)) as averagerentalpercustomer
from
	rental
group by 1
order by averagerentalpercustomer desc


#number of distinct films rented each month
select 
	left(rental.rental_date,7),count(distinct(inventory.film_id)),count(rental.rental_id),count(rental.rental_id)/count(distinct(inventory.film_id)) as AVG
from
	rental,inventory
where
	rental.inventory_id=inventory.inventory_id
group by
	1
	
#number of rentals in comedy, sports and family category
select
	count(rental.rental_id),category.name
from
	rental,`film_category`,inventory,category,film
where
	rental.inventory_id=inventory.inventory_id and
	film.film_id=film_category.film_id and
	film_category.category_id=category.category_id and
	inventory.film_id=film.film_id and
	category.name in ("comedy","sports","family")
group by
	2

#number of users who have rented atleast 3 times 
select
	rental.customer_id, count(rental.rental_id)
from
	rental
group by 1
having count(rental.rental_id) >= 3	


#revenue for store 1 where film is rated R or PG13
select
	inventory.store_id,film.rating,sum(payment.amount)
from
	film,payment,inventory,rental
where
	payment.rental_id=rental.rental_id and
	rental.inventory_id=inventory.inventory_id and
	inventory.fil_id=film.film_id and
	inventory.store_id=1 and
	film.rating in ('R' and 'PG-13')
group by
	1,2
order by 3 desc;
select
	inventory.store_id,film.rating,sum(payment.amount)
from
	film,payment,inventory,rental
where
	payment.rental_id=rental.rental_id and
	rental.inventory_id=inventory.inventory_id and
	inventory.fil_id=film.film_id and
	inventory.store_id=1 and
	film.rating in ('R' and 'PG-13')
group by
	1,2
order by 3 desc;
select
	rental.customer_id, count(rental.rental_id)
from
	rental
group by 1
having count(rental.rental_id) >= 3;
select
	rental.customer_id, count(rental.rental_id)
from
	rental
having count(rental.rental_id) >= 3	
group by 1;
select
	rental.customer_id, count(rental.rental_id)
from
	rental
having count(rental.rental_id) >= 3	
group by
	1;
select
	rental.customer_id, count(rental.rental_id)
from
	rental
having count(rental.rental_id) >=3	
group by
	1;
select
	rental.customer_id, count(rental.rental_id)
from
	rental
having count(rental.rental_id)>=3	
group by
	1;
select
	rental.customer_id, count(rental.rental_id)
from
	rental
having count(rental.rental.id)>=3	
group by
	1
