SELECT f.*, cc.name AS category FROM film AS f
JOIN film_category AS c ON f.film_id = c.film_id
JOIN category AS cc ON c.category_id = cc.category_id
WHERE 
f.rating IN ('R', 'PG-13')
AND
c.category_id IN (11, 14)
AND 
f.film_id NOT IN (SELECT DISTINCT i.film_id FROM rental AS r
JOIN inventory AS i ON i.inventory_id = r.inventory_id);