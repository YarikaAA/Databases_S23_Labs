CREATE TABLE "orders" (
  "orderId" integer NOT NULL,
  "date" date NOT NULL,
  "customerId" integer NOT NULL,
  "customerName" text NOT NULL,
  "city" text NOT NULL,
  "itemId" integer NOT NULL,
  "itemName" text NOT NULL,
  "quant" integer NOT NULL,
  "price" real NOT NULL,
  PRIMARY KEY("orderId", "itemId")
);