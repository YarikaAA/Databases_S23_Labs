CREATE TABLE "book" (
  "id" serial NOT NULL PRIMARY KEY,
  "name" text NOT NULL,
  "publisher" text NOT NULL
);

CREATE TABLE "teacher" (
  "id" serial NOT NULL PRIMARY KEY,
  "name" text NOT NULL,
  "room" text NOT NULL,
  "grade" smallint NOT NULL
);

CREATE TABLE "loan" (
  "id" serial NOT NULL PRIMARY KEY,
  "school" text NOT NULL,
  "teacherId" integer NOT NULL REFERENCES teacher.id,
  "course" text NOT NULL,
  "bookId" integer NOT NULL REFERENCES book.id,
  "loanDate" date NOT NULL
);
