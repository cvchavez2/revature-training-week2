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
  PizzaId int not null primary key, -- (no need to include not null) from a normalization standpoint whateever is in Pizza does not go in PizzaDB
  CrustId int null foreign key references Pizza.Crust(CrustId), -- least
  SizeId int null,
  [Name] nvarchar(250) not null,
  DateModified datetime2(0) not null, -- 0 there means hours minutes seconds (this is like datetime), for nanoseconds is 7
  -- UserModified,
  -- Modulus,
  -- IsValid bit not null,-- any system touching this database need to validate this data
  -- ensure info we are dealing with is valid
  -- constraint PK_PizzaId (PizzaId) primary key,
  Active bit not null default 1,
  constraint SizeId foreign key references Pizza.Size(SizeId)
);

create table Pizza.Crust -- this are dependencies because are not attached to PizzaId
(
  CrustId int not null,
  [Name] nvarchar(100) not null,
  Active bit not null,
  constraint CrustId primary key,
  constraint Active default 1,

);

create table Pizza.Size
(
  SizeId int not null,
  [Name] nvarchar(100) not null,
  Active bit not null,
);

create table Pizza.Topping
(
  ToppingId int not null,
  [Name] nvarchar(100) not null,
  Active bit not null,
);

create table Pizza.PizzaTopping
(
  PizzaToppingId int not null,
  PizzaId int not null,
  ToppingId int not null,
  Active bit not null,
)
go 

-- ALTER
alter table Pizza.Size
  add constraint PK_Size_SizeId SizeId primary key

alter table Pizza.Topping
  add constraint PK_Topping_ToppingId ToppingId primary key -- constraint Pk_<table name>_<Id> <Id>

alter table Pizza.PizzaTopping
  add constraint PK_PizzaTopping_PizzaToppingId PizzaToppingId primary key

alter table Pizza.PizzaTopping
  add constraint PK_PizzaTopping_PizzaId PizzaId foreign key references Pizza.Pizza(PizzaId)

alter table Pizza.PizzaTopping
  add constraint PK_PizzaTopping_ToppingId ToppingId foreign key references Pizza.Pizza(ToppingId)
go

-- DROP
-- replication, backup, failover
drop table Pizza.Pizza;
drop schema Pizza;
drop database PizzaStoreDB; -- development

-- TRUNCATE
-- delete current structure and data and then it reconstructs 
truncate table Pizza.Pizza;
truncate schema Pizza;
truncate database PizzaStoreDb;