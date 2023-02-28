CREATE TABLE "order" (
  "id" serial PRIMARY KEY,
  "date" date NOT NULL,
  "customerId" integer NOT NULL
);

CREATE TABLE "customer" (
  "id" serial PRIMARY KEY,
  "name" text NOT NULL,
  "cityId" integer NOT NULL
);

CREATE TABLE "city" (
  "id" serial PRIMARY KEY,
  "coords" text,
  "name" text NOT NULL
);

CREATE TABLE "item" (
  "id" serial PRIMARY KEY,
  "name" text NOT NULL,
  "price" real NOT NULL
);

CREATE TABLE "bucketItem" (
  "id" serial PRIMARY KEY,
  "itemId" integer NOT NULL,
  "orderId" integer NOT NULL,
  "quant" integer NOT NULL
);

INSERT INTO city(id, name) 
VALUES (1, 'Prague'), 
    (2, 'Madrid'), 
    (3, 'Moscow'); 
INSERT INTO item(id, name, price) 
VALUES (1, 'Net', 35.00), 
    (2, 'Racket', 65.00), 
    (3, 'Pack-3', 4.75), 
    (4, 'Pack-6', 5.00), 
    (5, 'Cover', 10.00); 
INSERT INTO customer(id, name, "cityId") 
VALUES (1, 'Martin', 1), 
    (2, 'Herman', 2), 
    (3, 'Pedro', 3); 
INSERT INTO "order"(id, date, "customerId") 
VALUES (1, '2011-02-23', 1), 
    (2, '2011-02-25', 2), 
    (3, '2011-02-27', 3); 
INSERT INTO "bucketItem"("orderId", "itemId", quant) 
VALUES (1, 1, 3), 
    (1, 2, 6), 
    (1, 3, 8), 
    (2, 4, 4), 
    (3, 2, 2), 
    (3, 5, 2);

-- number of items and sum
SELECT bi."orderId", SUM(bi."quant") AS "items_count", SUM(bi."quant" * i."price") AS "sum" FROM "bucketItem" AS bi 
JOIN "item" AS i ON i."id" = bi."itemId"
GROUP BY bi."orderId";

-- the "richest" customer
SELECT c.*, SUM(bi."quant" * i."price") FROM "customer" AS c
JOIN "order" AS o ON c."id" = o."customerId"
JOIN "bucketItem" AS bi ON c."id" = bi."orderId"
JOIN "item" AS i ON i."id" = bi."itemId"
GROUP BY c."id" ORDER BY SUM(bi."quant" * i."price") DESC LIMIT 1;