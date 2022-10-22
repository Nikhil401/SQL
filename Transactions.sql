USE TE
-- TRANSACTION 
-- ACCOUNTS - A(DEBIT) AND B(CREDIT)
-- ACID PROPERTY
-- ATOMICITY - SUCCESS-COMMIT/FAILURE-ROLLBACK
-- CONSISTENCY - SUCCESS-COMMIT/FAILURE-ROLLBACK <- STATE -> DATABASE
-- ISOLATION - MULTIPLE TRANSACTIONS -EACH TRANSACTION MUST BE INDEPENDENT
-- DURABILITY - PERMANENT CHANGES IN THE DATABASE

-- TYPES OF TRANSACTION
-- 1. AUTO-COMMIT - DEFAULT TRANSACTION
-- 2. EXPLICIT TRANSACTION - COMMIT,ROLLBACK,SAVEPOINT
-- 3. IMPLICIT TRANSACTION 

-- 1. AUTO-COMMIT
select * from demo1
insert into demo1 values(1006,'Cathy')

-- 2. EXPLICIT

-- COMMIT
BEGIN TRANSACTION
	insert into demo1 values(1007,'Andrea');
	delete from demo1 where TID=1000;
COMMIT TRANSACTION

--ROLLBACK
BEGIN TRANSACTION
	insert into demo1 values(1008,'Anna');
	delete from demo1 where TID=1007;
ROLLBACK TRANSACTION

-- TRANSACTION WITH CONDITIONAL STATEMENTS
BEGIN TRANSACTION
	IF(10<5)
	BEGIN
		insert into demo1 values(1009,'Anna');
		COMMIT TRANSACTION
	END
	ELSE
	BEGIN
		delete from demo1 where TID=1008;
		COMMIT TRANSACTION
	END

select * from demo1

-- SAVEPOINT - SAVE TRANSACTION
BEGIN TRANSACTION
	insert into demo1 values(1007,'Anna');
	--SAVEPOINT
	SAVE TRANSACTION insert_stmt
	delete from demo1 where TID=1006;
	ROLLBACK TRANSACTION insert_stmt
COMMIT TRANSACTION

BEGIN TRANSACTION
	insert into demo1 values(1008,'Anna');
	update demo1 set TName='Elsa' where TID=1007;
	--SAVEPOINT
	SAVE TRANSACTION insertupdate_stmt
	delete from demo1 where TID=1006;
	ROLLBACK TRANSACTION insertupdate_stmt
COMMIT TRANSACTION

-- 3.IMPLICIT

--@@ Global Table variable
--@@OPTIONS & 2 = 2 ->ASSIGNED FOR IMPLICIT TRANSACTION IN SQL SERVER
SELECT IIF(@@OPTIONS & 2 = 2,'ON','OFF') AS 'IMPLICIT TRANSACTION STATE'

SET IMPLICIT_TRANSACTIONS ON

insert into demo1 values(1009,'Jancy');
update demo1 set TName='Emily' where TID=1007;
ROLLBACK TRAN

select * from demo1

SET IMPLICIT_TRANSACTIONS OFF

-- MARK - DESCRIPTION ABOUT THE TRANSACTION
-- NAME - NAMING THE TRANSACTION
BEGIN TRANSACTION insertupdate_demo1 WITH MARK 'INSERTION & UPDATION IN DEMO1'
	insert into demo1 values(1009,'Andrea');
	update demo1 set TName='Emily' where TID=1007;
COMMIT TRANSACTION insertupdate_demo1

--View the transactions with MARK
select * from [msdb].[dbo].[logmarkhistory]

select * from sys.sysprocesses where open_tran=1

DBCC OPENTRAN -- SPID - 67

DBCC INPUTBUFFER(67) -- SPID - Server process ID - 67


