WITH store_sum AS (SELECT st.*, SUM(p.amount) FROM payment AS p
JOIN staff AS s ON p.staff_id = s.staff_id
JOIN store AS st ON s.store_id = st.store_id
WHERE TO_DATE('020107', 'MMDDYY') < p.payment_date AND p.payment_date < TO_DATE('030107', 'MMDDYY')
GROUP BY st.store_id
)

SELECT * from store_sum AS s
JOIN (
SELECT a.city_id, MAX(s.sum) FROM store_sum AS s
INNER JOIN address AS a ON s.address_id = a.address_id
GROUP BY a.city_id
) AS m ON s.sum = m.max
