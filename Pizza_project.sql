drop database if exists pizza;
create database pizza;
use pizza;
set foreign_key_checks=0;
CREATE TABLE person (
    Fname VARCHAR(15) NOT NULL ,
    age INT NOT NULL,
    sex CHAR
);
CREATE TABLE Frequents (
    Fname VARCHAR(15) NOT NULL,
    pizzeria VARCHAR(20) NOT NULL PRIMARY KEY
);
CREATE TABLE Eats (
    Fname VARCHAR(15) NOT NULL,
    pizza VARCHAR(20) NOT NULL PRIMARY KEY
);
CREATE TABLE Serves (
    pizzeria VARCHAR(20) NOT NULL,
    pizza VARCHAR(20) NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    PRIMARY KEY (pizzeria),
    UNIQUE KEY (pizza)
);
alter table person add phone_no int;
alter table person drop phone_no;
alter table person add constraint primary key(Fname);
alter table frequents add constraint unique key(Fname);
alter table Eats add constraint unique key(Fname);
alter table Serves add constraint unique key(price); 
alter table frequents drop primary key;
alter table person drop primary key;
alter table frequents drop index Fname;
alter table eats drop index Fname;
alter table serves drop primary key;
alter table serves drop index price;
alter table serves drop index pizza;
alter table Person modify age int not null;

show tables;
select*from person;
select*from person where age >20 and age <30;
SELECT 
    pizza, pizzeria, price
FROM
    serves
WHERE
    price = (SELECT 
            MAX(price)
        FROM
            serves);
SELECT 
    pizzeria
FROM
    eats
        JOIN
    serves USING (pizza)
WHERE
    price < 10 AND fname = 'Amy';

(SELECT 
    pizzeria
FROM
    frequents
        JOIN
    person USING (fname)
WHERE
    pizzeria NOT IN (SELECT 
            pizzeria
        FROM
            frequents
                JOIN
            person USING (fname)
        WHERE
            sex = 'f')) UNION (SELECT 
    pizzeria
FROM
    frequents
        JOIN
    person USING (fname)
WHERE
    pizzeria NOT IN (SELECT 
            pizzeria
        FROM
            frequents
                JOIN
            person USING (fname)
        WHERE
            sex = 'm'));
            
select pizzeria from serves where price =( select min(price)) and pizza = 'pepperoni';
insert into person (fname,age,sex) values ('Ken', '55', 'M');
select pizzeria from frequents join person using(fname) where age < 18;
select pizza, pizzeria from serves;
select pizza, count(pizza) as pizza from eats group by pizza order by count(pizza) desc limit 1;
delete from serves where pizzeria= 'Little Caesars' and pizza= 'sausage';
select distinct fname from person join eats using(fname) where (pizza = 'supreme' || pizza = 'pepperoni');
select distinct fname from person join frequents using(fname) where (pizzeria = 'Dominos' || pizzeria = 'pizza hut');
select*from eats where pizza= 'sausage' and pizza <> 'supreme';
select concat(eats.fname, eats.pizza)from eats left join (select fname, pizza from frequents join serves using(pizzeria)) 
	frequents on eats.Fname = frequents.fname and eats.pizza = frequents.pizza where frequents.pizza is null;
select eats.Fname from frequents right join (select * from eats join serves using(pizza)) eats on 
frequents.fname = eats.fname and frequents.pizzeria = eats.pizzeria where frequents.pizzeria is null;
select eats.Fname from frequents right join (select * from eats join serves using(pizza)) eats on 
frequents.Fname = eats.Fname and frequents.pizzeria = eats.pizzeria where frequents.pizzeria is null;
select min(price) as price, pizzeria from serves where pizza= 'pepperoni';