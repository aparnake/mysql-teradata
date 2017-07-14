
# Simple Inner JOIN 
 SELECT 
 	ac. customer_id,
 	ac.fav_color_id,
 	rc.no_purchases
 FROM
 	active_customer ac,
 	reward_customer rc
 WHERE
 	ac.customer_id = rc.customer_id;
 	
# Using JOIN Syntax
 SELECT 
 	ac. customer_id,
 	ac.fav_color_id,
 	rc.no_purchases
 FROM
 	 active_customer ac JOIN reward_customer rc ON ac.customer_id = rc.customer_id;

# LEFT JOIN  	 
 SELECT 
 	ac. customer_id,
 	ac.fav_color_id,
 	rc.no_purchases
 FROM
 	 active_customer ac LEFT JOIN reward_customer rc ON ac.customer_id = rc.customer_id;
 	 
# Create temp table with no of rentals > 30 : whale customers
drop temorary table if exists rewardUsers;
create temporary table rewardUsers
SELECT
	r.customer_id,
	count(r.rental_id) as num_rentals,
	max(rental_date)
FROM rental r
GROUP By 1
HAVING num_rentals >= 30;

# active customers with phone no's.
drop temorary table if exists activeUsers;
create temporary table activeUsers
SELECT
	c.*,
	a.phone
FROM customer c
		JOIN address a ON c.address_id = a.address_id
WHERE
	c.active = 1
GROUP By 1;

# all reward users that are also active users. 
SELECT 
	au.customer_id,
	au.email,
	au.first_name
FROM 
	activeUsers au, 
	rewardUsers ru
WHERE
	au.customer_id = ru.customer_id;
	
# all reward users and phone for all active users. 
SELECT 
	ru.customer_id,
	c.email,
	au.phone
FROM 
	rewardUsers ru
		JOIN customer c on r.customer_id = c.customer_id 
	    LEFT JOIN activeUsers au on au.customer_id = ru.customer_id
GROUP BY 1;
