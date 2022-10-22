-- TRIGGERS 
-- DDL TRIGGER - CREATE,ALTER,DROP
-- DML TRIGGER - INSERT,UPDATE,DELETE
-- CLR TRIGGER - COMMON LANGUAGE RUNTIME 
-- LOGON TRIGGER

-- 1. DML TRIGGER - INSTEAD OF,AFTER,FOR
use TE
--create trigger - restrict the access of DML
create trigger trg_demo_insert --trigger name
on demo -- table name
FOR INSERT
as
begin
	print 'You cannot insert into the demo table'
	Rollback transaction -- like the working of ctrl+z
end

select * from demo

insert into demo values(108,'Lisa','01/01/2022')

update demo set TName='Lisa' where TID=106

--alter trigger
alter trigger trg_demo_insert --trigger name
on demo -- table name
FOR INSERT, UPDATE, DELETE
as
begin
	print 'You cannot perform DML operation on demo table'
	Rollback transaction -- like the working of ctrl+z
end
--Restricting the access for DML operations on demo table
update demo set TName='James' where TID=106
insert into demo values(108,'Lisa','01/01/2022')
delete from demo where TID=106

--Restrict the access for a specific period of time
create trigger trg_demo_dml --trigger name
on demo -- table name
FOR INSERT, UPDATE, DELETE
as
begin
	if DATEPART(HH,GETDATE())>13
	BEGIN
		print 'You cannot insert into the demo table after 13:00PM'
		Rollback transaction -- like the working of ctrl+z
	END
end

--Restricting the access for DML operations on demo table after 13:00PM
update demo set TName='James' where TID=106
insert into demo values(108,'Lisa','01/01/2022')
delete from demo where TID=106

--Restrict the access for a specific period of time
--Restricting the access for DML operations on demo table before 13:00PM
alter trigger trg_demo_dml --trigger name
on demo -- table name
FOR INSERT, UPDATE, DELETE
as
begin
	if DATEPART(HH,GETDATE())<13
	BEGIN
		print 'You cannot insert into the demo table before 13:00PM'
		Rollback transaction -- like the working of ctrl+z
	END
end

--Restricting the access for DML operations on demo table before 13:00PM
update demo set TName='James' where TID=106
insert into demo values(108,'Jamie','01/01/2022')
delete from demo where TID=108
select * from demo

--Restrict the access for a specific day
--Restricting the access for DML operations on demo table for a specific day
alter trigger trg_demo_dml_day --trigger name
on demo1 -- table name
FOR INSERT, UPDATE, DELETE
as
begin
	if DATEPART(DW,GETDATE())=6 --FRIDAY
	BEGIN
		print 'You cannot perform DML into the demo table today'
		Rollback transaction -- like the working of ctrl+z
	END
end

select * from demo1
--Restrict the access for a specific day
insert into demo1 values(1004,'Tom')
update demo1 set TName='Jamie' where TID=1003

--2 TABLES ASSOCIATED WITH TRIGGER OPERATION - INSERTED AND DELETED

--Trigger to display the inserted set of records
create trigger trg_insert
on demo
For Insert
as
begin
	select * from inserted
end

select * from demo
insert into demo values(108,'Jamie','01/01/2022')
insert into demo values(110,'Joanne','01/01/2022')
insert into demo values(112,'Anna','01/01/2022')

--Trigger to display the deleted set of records
create trigger trg_delete
on demo
For Delete
as
begin
	select * from deleted
end

select * from demo
delete from demo where TID=110

--Trigger to display the updated set of records
create trigger trg_update
on demo
For Update
as
begin
	select * from inserted
	select * from deleted
end

update demo set TName='Anna' where TID=106

-- 2. DDL Trigger
-- Database Scope and Server Scope

--DATABASE SCOPE
create trigger trg_DDL_TE
on Database
For Create_Table,Alter_Table,Drop_Table
as
Begin
	Print 'You cannot perform DDL on TE'
	Rollback Transaction
End

create table demo3
(
id int
)

drop table demo2

--Disable the trigger
Disable trigger trg_DDL_TE on Database
--Enable the trigger
enable trigger trg_DDL_TE on Database

--Change to another database
use DLithe

create table demo4
(
id int
)

--SERVER SCOPE
create trigger trg_DDL_AllDB
on ALL Server
For Create_Table,Alter_Table,Drop_Table
as
Begin
	Print 'You cannot perform DDL on any Database'
	Rollback Transaction
End

--Change to another database
use dml

create table demo4
(
id int
)

--Change to another database
use Employee

create table demo4
(
id int
)

use TE
--INSTEAD OF AND AFTER

--INSTEAD OF
create trigger trg_insteadof_demo
on demo
instead of insert -- instead of performing the insert operation, the trigger performs the select operation
as
select * from demo

insert into demo values(108,'Jamie','01/01/2022')

--AFTER
create trigger trg_after_demo1
on demo1
After insert
as
	print 'After Trigger'

select * from demo1

insert into demo1 values(1005,'Mike')

alter trigger trg_after_demo1
on demo1
After insert
as
	print 'After Trigger';
	RaisError('Error',16,1);
	Rollback Transaction;

insert into demo1 values(1006,'Michael')
