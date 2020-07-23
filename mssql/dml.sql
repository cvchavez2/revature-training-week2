-- data manipulation language
use AdventureWorks2017;
go 

-- select

select * -- horizontal filter
from Person.Person; -- example of a select all

-- collation = character set is case insensitive
select firstname, lastname 
from Person.Person;

select firstname, lastname 
from Person.Person
where firstname = 'john' or lastname = 'john';

-- do a negation to make sure we have all entries
select firstname, lastname 
from Person.Person
where firstname <> 'john' and lastname <> 'john';

select *
from Person.Person
where (firstname >= 'k' and firstname < 'l') 
or (lastname >= 'k' and lastname < 'l');

select *
from Person.Person   -- every name that starts with k
where (firstname like 'k%') or (lastname like 'k%'); 
-- % is a wild care that means one or more chars

select *
from Person.Person -- every name that its name ends with k
where (firstname like '%k') or (lastname like '%k');

select *
from Person.Person -- _ wildcard, return all names with 3 chars that start with k
where (firstname like 'k__') or (lastname like '__k');

select *
from Person.Person -- [] bracket say, return all reecords that start with k and z
where (firstname like '[k,z]%') or (lastname like '[a-d]_k');
                  -- also, return all records that end up with k and before they have char from a to d

select firstname, lastname
from Person.Person
where firstname = 'john'
group by firstname, lastname

select firstname, lastname, count(*) as count -- aggregate count, average, sum
from Person.Person
where firstname = 'john'
group by firstname, lastname

select firstname, lastname, count(*) as count
from Person.Person
where firstname = 'john'
group by firstname, lastname
having count(*) > 1; -- having is to filter groups

select firstname, lastname, count(*) as johns
from Person.Person
where firstname = 'john'
group by firstname, lastname
having count(*) > 1 -- having is to filter groups
order by lastname desc, johns desc;

-- order of execution
-- from - load
-- where - filter
-- group by
-- having
-- select - after all that then we can print
-- order by

-- insert
select *
from Person.Address
where AddressLine1 like '5117 O%' and City like 'Leeds';

insert into Person.Address(AddressLine1, AddressLine2, City, StateProvinceID, PostalCode, SpatialLocation, rowguid, ModifiedDate)
values ('5117 Oak Creek Ct.',	'apt rand',	'Leeds',	14,	75400,	0xE6100000010C72C2B2242FE04A4016902E7EB1B7F8BF,	'fd069aaa-ad12-4a4c-a548-23b35dfeb240',	'2012-09-18 00:00:00.000');

-- update
update pa
set addressline2  = 'suite 200', addressline1 = '123 eelm st'
from Person.Address as pa
where AddressLine1 = 'suite 200';

-- delete
delete pa
from Person.Address as pa
where AddressLine1 = 'suite 200';
GO

-- view
create view vw_getpersons with schemabinding -- firstname and lastname cannot change
as 
select firstname, lastname
from Person.Person;
go

select * from vw_getpersons;
GO

alter view vw_getpersons with schemabinding -- firstname and lastname cannot change
as 
select firstname, middlename, lastname
from Person.Person;
go

drop view vm_getpersons;
go

-- function

-- stored procedure

-- join

-- union

-- trigger

-- transaction

-- ORM + Entity Framework Core + Data-First Approach