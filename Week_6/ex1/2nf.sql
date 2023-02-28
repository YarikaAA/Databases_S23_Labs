CREATE TABLE "order" (
  "id" integer NOT NULL,
  "date" date NOT NULL,
  "customerId" integer NOT NULL,
  PRIMARY KEY("id")
);

CREATE TABLE "customer" (
  "id" integer NOT NULL,
  "name" text NOT NULL,
  "city" text NOT NULL,
  PRIMARY KEY("id")
);

CREATE TABLE "item" (
  "id" integer NOT NULL,
  "name" text NOT NULL,
  "price" integer NOT NULL,
  PRIMARY KEY("id")
);

CREATE TABLE "bucketItem" (
  "id" integer NOT NULL,
  "itemId" integer NOT NULL,
  "orderId" integer NOT NULL,
  "quant" integer NOT NULL,
  PRIMARY KEY("id")
);