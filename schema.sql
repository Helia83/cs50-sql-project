-- customer table which represents the name, city and street of a customer
CREATE TABLE "customer" (
    "c_name" TEXT,
    "c_city" TEXT NOT NULL,
    "c_street" TEXT NOT NULL,
    PRIMARY KEY ("c_name")
);

-- branch table which represents the information like bank name and city's bank
CREATE TABLE "branch" (
    "b_name" TEXT,
    "b_city" TEXT NOT NULL,
    PRIMARY KEY ("b_name")
);

-- deposit table which represents information about account that the customer has created
CREATE TABLE "deposit" (
    "c_name" TEXT,
    "b_name" TEXT,
    "A_no" INTEGER UNIQUE,
    "balance" INTEGER NOT NULL CHECK("balance" != 0),
    PRIMARY KEY ("A_no"),
    FOREIGN KEY ("c_name") REFERENCES "customer"("c_name") ON DELETE CASCADE,
    FOREIGN KEY ("b_name") REFERENCES "branch"("b_name") ON DELETE CASCADE
);

-- borrow table which represents information about the money that customer has lent from a bank
CREATE TABLE "borrow" (
    "c_name" TEXT,
    "b_name" TEXT,
    "L_no" INTEGER UNIQUE,
    "amount" INTEGER NOT NULL CHECK ("amount" != 0),
    PRIMARY KEY ("L_no"),
    FOREIGN KEY ("c_name") REFERENCES "customer"("c_name") ON DELETE CASCADE,
    FOREIGN KEY ("b_name") REFERENCES "branch"("b_name") ON DELETE CASCADE
);

-- the indexes which created on these tables to speed up queries
CREATE INDEX "customer_index" ON "customer"("c_name");
CREATE INDEX "branch_index" ON "branch"("b_name");
CREATE INDEX "deposit_index" ON "deposit"("c_name");
CREATE INDEX "borrow_index" ON "borrow"("b_name");

-- create view
CREATE VIEW "Sun_acc" AS
SELECT "c_name" FROM "deposit"
WHERE "b_name" = "Sun";


