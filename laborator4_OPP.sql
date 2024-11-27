CREATE TABLE employees(
    idnp varchar(13) primary key,
    employee_name varchar(15) not null,
    email varchar(50) unique,
    department varchar(20) not null
);

CREATE TABLE accounts (
	user_id serial PRIMARY KEY,
	username VARCHAR (50) UNIQUE NOT NULL,
	password VARCHAR (50) NOT NULL,
	email VARCHAR (255) UNIQUE NOT NULL,
	created_on TIMESTAMP NOT NULL,
    last_login TIMESTAMP
);

DROP TABLE employees;
DROP TABLE accounts;

ALTER TABLE employees add  age int;
ALTER TABLE employees add is_concediu boolean;

INSERT INTO employees values('1234567891234', 'Alexandru Stas', 'alexandru@gmail.com', 'HR',34, false );
INSERT INTO employees values('5234567893234', 'Alexandra Man', 'sanda05@gmail.com', 'IT', 23, true);
INSERT INTO employees values('9234567891244', 'Otilia Lupusor', 'lupusor@gmail.com', 'Marketing', 50, false);
INSERT INTO employees values('2234567891245', 'Alexei Caraulan', 'alexei.caraulan@gmail.com', 'IT', 40, false);
INSERT INTO employees values('3534567891245', 'Victoria Cosmin', 'victomam.cosmin@gmail.com', 'Finance', 31, true);
INSERT INTO employees values('8534567891245', 'Sergiu Cosmin', 'sergiu.cosmin@gmail.com', 'Finance', 32, false);

INSERT INTO employees(idnp, employee_name, department) values('1234567891239', 'Marcela Nadus', 'IT');
INSERT INTO employees(idnp, employee_name, department) values('1234567891119', 'Marcela Nadus', 'IT');

SELECT * FROM employees WHERE is_concediu = true AND age > 20 AND age < 30 AND email LIKE '%@gmail.com';
SELECT * FROM employees where idnp = '1234567891239';
DELETE FROM employees where idnp = '1234567891239';

UPDATE employees SET age = 41 where idnp = '2234567891245';
UPDATE employees SET department = 'Accounting' where employee_name = 'Sergiu Cosmin';

INSERT INTO accounts values (1, 'Angelor', '124563', 'angelor.mn@gmail.com','2024-01-01 20:12:23', '2024-02-01 10:13:45');
INSERT INTO accounts values (2, 'Ariana', 'securePass!45', 'ariana.mn@gmail.com','2023-01-01 13:30:20', '2024-10-01 23:50:00');
INSERT INTO accounts values (3, 'Cristi', 'jesuiscristi', 'cris.mn@gmail.com','2021-01-01 10:40:10', '2024-11-11 12:12:12');
INSERT INTO accounts values (4, 'Alistar', 'skynet2024', 'alistar.mn@gmail.com','2019-01-04 09:20:03', '2024-03-07 14:16:10');

INSERT INTO accounts(user_id, username, password, email, created_on)  VALUES (5, 'John', '483384hede', 'john@gmail.com', '2024-01-01 10:00:00');

SELECT * FROM accounts where user_id = 5;
DELETE FROM  accounts;
UPDATE  accounts SET password = '23243odjff';
SELECT * FROM accounts;

-- INNER JOIN
CREATE TABLE customers(
    customers_id serial primary key ,
    first_name varchar(50) not null,
    last_name varchar(50) not null
);


CREATE TABLE orders (
    order_id serial primary key,
    customers_id int,
    order_date timestamp,
    item_name varchar(50) not null,
    FOREIGN KEY (customers_id) REFERENCES customers(customers_id)

);

INSERT INTO customers values(1, 'John', 'Doe');
INSERT INTO customers values(2, 'Jane', 'Smith');
INSERT INTO customers values(3, 'Emanuel', 'Doc');
INSERT INTO customers values(4, 'Bob', 'Johnson');
INSERT INTO customers values(5, 'Will', 'Decade');
INSERT INTO customers values(6, 'Nara', 'Smith');

INSERT INTO orders values (1,1, '2023-09-01', 'books');
INSERT INTO orders values (2,2, '2023-09-02', 'computer parts');
INSERT INTO orders values (3,3, '2023-09-03', 'mobile parts');
INSERT INTO orders values (5,2, '2023-09-05', 'electronics');
INSERT INTO orders values (4,5, '2023-09-04', 'zara clothes');
INSERT INTO orders values (6,6, '2023-09-06', 'Biologique Recherche');

UPDATE customers SET  first_name = 'Ion' where  customers_id = 1;
UPDATE orders SET item_name = 'ISL PARFUM' where order_id = 5;
SELECT customers_id, first_name, last_name from customers;
SELECT * FROM customers;--toti param
SELECT * FROM customers where customers_id = 3;
SELECT * FROM orders where order_date = '2023-09-06';


--We want the list of customers who have placed an order => inner join
SELECT o.order_id, c.first_name, c.last_name, o.order_date FROM orders o INNER JOIN customers c ON o.customers_id = c.customers_id;
SELECT o.order_id, c.first_name, c.last_name, o.item_name from orders o inner join customers c on o.customers_id = c.customers_id;


CREATE TABLE angajati(
    angajat_id serial primary key,
    angajat_nume varchar(50) not null,
    departament varchar(30) not null

);

CREATE TABLE projects(
    project_id serial primary key ,
    project_name varchar(50) not null,
    angajati_id int,
    FOREIGN KEY (angajati_id) references angajati(angajat_id)

);
INSERT INTO angajati values (1, 'Alice', 'HR');
INSERT INTO angajati values (2, 'John', 'IT');
INSERT INTO angajati values (3, 'Will', 'Marketing');
INSERT INTO angajati values (4, 'Michael', 'IT');
INSERT INTO angajati values (5, 'Ana', 'IT');

INSERT INTO projects values (101,'Project 1', 2);
INSERT INTO projects values (102,'Project 2', 3);
INSERT INTO projects values (103,'Project 3', 1);
INSERT INTO projects values (104,'Project 4', 2);
INSERT INTO projects values (105,'Project 5', 4);
INSERT INTO projects values (106,'Project 6');
INSERT INTO projects values (107,'Project 7', 2);

DELETE FROM projects WHERE project_id = 107;

--we want to get the list of all employees with the project they are assigned to,
-- even if they haven’t been assigned any projec =>left join
SELECT a.angajat_id, a.angajat_nume, p.project_name FROM angajati a LEFT JOIN projects p ON a.angajat_id = p.angajati_id;
SELECT a.angajat_id, a.angajat_nume, p.project_id FROM angajati a LEFT JOIN projects p ON a.angajat_id = p.angajati_id;


--it produces a complete set of records from Table B, with the matching records in Table A.
-- If there is no match, the left side will contain null.
--list of all projects with the employees they are assigned to =>RJ
SELECT a.angajat_id, a.angajat_nume, p.project_name FROM angajati a RIGHT JOIN projects p on a.angajat_id = p.angajati_id;
SELECT a.angajat_id, a.departament, p.project_name FROM angajati a RIGHT JOIN projects p on a.angajat_id = p.angajati_id;

--outer join. It returns all the rows where there is match in both the left and the right table.
-- the full list of employees and projects along with the employees
SELECT a.angajat_id, a.angajat_nume, p.project_name FROM angajati a FULL OUTER JOIN projects p on a.angajat_id = p.angajati_id;
SELECT a.angajat_id, a.departament, p.project_id FROM angajati a FULL OUTER JOIN projects p on a.angajat_id = p.angajati_id;