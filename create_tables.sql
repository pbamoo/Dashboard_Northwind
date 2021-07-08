DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS regions;
DROP TABLE IF EXISTS shippers;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS territories;
DROP TABLE IF EXISTS employee_territories;
DROP TABLE IF EXISTS order_details;


CREATE TABLE categories (
    categoryID smallint NOT NULL PRIMARY KEY,
    categoryName varchar(20) NOT NULL,
    description text,
    picture bytea
);

COPY categories
FROM 'C:\Users\Public\northwind_data_clean-master\categories.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE customers (
    customerID bpchar NOT NULL PRIMARY KEY,
    companyName varchar(40) NOT NULL,
    contactName varchar(30),
    contactTitle varchar(30),
    address varchar(60),
    city varchar(20),
    region varchar(20),
    postalCode varchar(10),
    country varchar(20),
    phone varchar(24),
    fax varchar(24)
);

COPY customers
FROM 'C:\Users\Public\northwind_data_clean-master\customers.csv'
DELIMITER ',' CSV HEADER;

CREATE TABLE employees (
    employeeID smallint NOT NULL PRIMARY KEY,
    lastName varchar(20) NOT NULL,
    firstName varchar(10) NOT NULL,
    title varchar(30),
    titleOfCourtesy varchar(25),
    birthDate date,
    hireDate date,
    address varchar(60),
    city varchar(20),
    region varchar(20),
    postalCode varchar(10),
    country varchar(20),
    homePhone varchar(24),
    extension varchar(4),
    photo bytea,
    notes text,
    reportsTo text,
    photoPath varchar(255)
);

COPY employees
FROM 'C:\Users\Public\northwind_data_clean-master\employees.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE suppliers (
    supplierID smallint NOT NULL PRIMARY KEY,
    companyName varchar(40) NOT NULL,
    contactName varchar(30),
    contactTitle varchar(30),
    address varchar(60),
    city varchar(20),
    region varchar(20),
    postalCode varchar(10),
    country varchar(20),
    phone varchar(24),
    fax varchar(24),
    homepage text
);

COPY suppliers
FROM 'C:\Users\Public\northwind_data_clean-master\suppliers.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE products (
    productID smallint NOT NULL PRIMARY KEY,
    productName varchar(40) NOT NULL,
    supplierID smallint,
    categoryID smallint,
    quantityPerUnit varchar(20),
    unitPrice real,
    unitsInStock smallint,
    unitsOnOrder smallint,
    reorderLevel smallint,
    discontinued integer NOT NULL,
	FOREIGN KEY (categoryID) REFERENCES categories,
	FOREIGN KEY (supplierID) REFERENCES suppliers
);

COPY products
FROM 'C:\Users\Public\northwind_data_clean-master\products.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE regions (
    regionID smallint NOT NULL PRIMARY KEY,
    regionDescription bpchar NOT NULL
);

COPY regions
FROM 'C:\Users\Public\northwind_data_clean-master\regions.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE shippers (
    shipperID smallint NOT NULL PRIMARY KEY,
    companyName varchar(40) NOT NULL,
    phone varchar(24)
);

COPY shippers
FROM 'C:\Users\Public\northwind_data_clean-master\shippers.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE orders (
    orderID smallint NOT NULL PRIMARY KEY,
    customerID bpchar,
    employeeID smallint,
    orderDate date,
    requiredDate date,
    shippedDate text,
    shipVia smallint,
    freight real,
    shipName varchar(40),
    shipAddress varchar(60),
    shipCity varchar(20),
    shipRegion varchar(20),
    shipPostalCode varchar(10),
    shipCountry varchar(20),
    FOREIGN KEY (customerID) REFERENCES customers,
    FOREIGN KEY (employeeId) REFERENCES employees
);

COPY orders
FROM 'C:\Users\Public\northwind_data_clean-master\orders.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE territories (
    territoryID varchar(20) NOT NULL PRIMARY KEY,
    territoryDescription bpchar NOT NULL,
    regionID smallint NOT NULL,
	FOREIGN KEY (regionID) REFERENCES regions
);

COPY territories
FROM 'C:\Users\Public\northwind_data_clean-master\territories.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE employee_territories (
    employeeID smallint NOT NULL,
    territoryID varchar(20) NOT NULL,
    PRIMARY KEY (employeeID, territoryID),
    FOREIGN KEY (territoryID) REFERENCES territories
);

COPY employee_territories
FROM 'C:\Users\Public\northwind_data_clean-master\employee_territories.csv'
DELIMITER ',' CSV HEADER;


CREATE TABLE order_details (
    orderID smallint NOT NULL,
    productID smallint NOT NULL,
    unit_price real NOT NULL,
    quantity smallint NOT NULL,
    discount real NOT NULL,
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (productID) REFERENCES products
);

COPY order_details
FROM 'C:\Users\Public\northwind_data_clean-master\order_details.csv'
DELIMITER ',' CSV HEADER;
