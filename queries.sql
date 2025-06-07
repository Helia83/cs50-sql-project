-- insert into the tables each values
INSERT INTO "customer" ("c_name", "c_city", "c_street")
VALUES
("Sara", "Tehran", "A10"),
("Amir", "Dubai", "b15"),
("Nina", "Rome", "P20"),
("Ali", "Moscow", "S13");

INSERT INTO "deposit" ("c_name", "b_name", "A_no", "balance")
VALUES
("Sara", "Sky", 5672, 2500),
("Amir", "Sun", 6695, 3800),
("Nina", "Sun", 3342, 2900),
("Ali", "Sun", 9672, 4200);

INSERT INTO "branch" ("b_name", "b_city")
VALUES
("Sun", "Dubai"),
("Sky", "Tehran");

INSERT INTO "borrow" ("c_name", "b_name", "L_no", "amount")
VALUES
("Sara", "Sky", 200, 5700),
("Nina", "Sun", 700, 3400);


-- Names of all customers who have accounts at the Sun branch.
SELECT "c_name" FROM "deposit"
WHERE "b_name" = "Sun";

-- Names of all customers who have borrow money from the Sun branch.
SELECT "c_name" FROM "borrow"
WHERE "b_name" = "Sun";


-- Write a query that changes the city name of a customer named Ali to Tehran.
UPDATE "customer" SET "c_city" = "Tehran"
WHERE "c_name" = "Ali";


-- Write a query that deletes loan number 700 from the borrow table.
DELETE FROM "borrow"
WHERE "L_no" = 700;


