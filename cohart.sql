

# COHART: Good for seeing retention. Looking for imprv in engaging our customers.
# Customers First Rental
DROP TEMPORARY TABLE IF EXISTS first_rental;
CREATE TEMPORARY TABLE first_rental
SELECT
	customer_id,
	min(rental_date) as first_time
FROM
	rental
GROUP BY 1;

-- cohart Size
DROP TEMPORARY TABLE IF EXISTS cohart_size;
CREATE TEMPORARY TABLE cohart_size
SELECT
	left(first_time,7) as month,
	count(customer_id) as num
FROM
	first_rental
GROUP BY 1;

-- Revenue Per User for each cohart and month
SELECT 
	r.*, left(f.first_time,7) as cohart, cs.num as cohart_size, p.amount
FROM
	rental r,
	JOIN first_rental f ON r.customer_id = f.customer_id
	JOIN cohart_size cs ON cs.month = left(f.first_time,7)
	JOIN payment p ON p.rental_id=rrental_id
;

SELECT 
	r.*
FROM
	rental r,
	JOIN first_rental fr ON r.customer_id = fr.customer_id

;











