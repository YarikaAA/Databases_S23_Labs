CREATE TABLE "loan_books" (
  "school" text NOT NULL,
  "teacher" text NOT NULL,
  "course" text NOT NULL,
  "room" text NOT NULL,
  "grade" smallint NOT NULL,
  "book" text NOT NULL,
  "publisher" text NOT NULL,
  "loanDate" date NOT NULL,
  PRIMARY KEY("school", "teacher", "book")
);