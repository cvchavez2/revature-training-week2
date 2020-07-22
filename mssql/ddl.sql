-- data definition language
-- we need to connect to our database
use master;
go

-- CREATE

create database PizzaStoreDB;  -- gets an instance of model and name it PizzaStoreDB
go -- project

create schema Pizza; -- namespace
go

-- create schema User; -- namespace
-- go

-- constraints = datatype, key, default, check, null, 
-- number datatypes = tinyint (int8), smallint(int16), int (int32), bigint (int64), numeric, decimal, money
-- text datatypes = text, ntext, varchar (based on ascii), nvarchar (based on unicode utf-8), char (ascii), nchar (utf-8)
-- datetime datatypes = date, time, datetime, datetime2 (provides more precission - supports nanoseconds)
-- boolean datatype = bit
create table Pizza.Pizza
(
  PizzaId int primary key, -- (no need to include not null) from a normalization standpoint whateever is in Pizza does not go in PizzaDB
  -- OR
  -- constraint PK_PizzaId (PizzaId) primary key,
  Name nvarchar(250) not null,
  DateModified datetime2(0) not null, -- 0 there means hours minutes seconds (this is like datetime), for nanoseconds is 7
  -- UserModified,
  -- Modulus,
  IsValid bit not null,-- any system touching this database need to validate this data
  -- ensure info we are dealing with is valid
);

create table Pizza.Crust -- this are dependencies because are not attached to PizzaId
(

);

create table Pizza.Size
(

);

create table Pizza.Topping
(

);
-- ALTER

-- DROP

-- TRUNCATE