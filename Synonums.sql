use TE

--SYNONYM - SIMILAR NAME
--TABLE ALIAS/ALTERNATIVE NAME FOR YOUR TABLE,VIEW,PROCEDURE,FUNCTION,TRIGGER ETC

--Table - EmployeeSalaryDetails - EmpSal

create synonym dep for Department

select * from dep
select * from Department

--synonyms - where they get stored in SQL Server
Select * from sys.synonyms 

--VIEWS - Virtual Tables - depend on a table - System Views(SQL Server),User-Defined views(Custom)
--TYPES - User-Defined views(Custom)
--------------------------------------
--SIMPLE - SINGLE TABLE
--COMPLEX - MORE THAN ONE TABLE 

-- 1.Simple View
select * from Employee

create view Emp_View
as
select * from Employee where EDesignation='Trainee'

--Retrieve the view
select * from Employee
select * from Emp_View

--insert into a simple view - will automatically reflect the changes in the original table
insert into Emp_View values(11,'Mike','Trainee',25,100)

--update in a simple view
update Emp_View set EAge=24 where EID=11

--delete in a simple view
delete from Emp_View where EID=11

--2. Complex View

--Result of 2 tables - using join clause
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s inner join Student_Dept as sd on s.SDept=sd.DID;

create view Student_Dep
as
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s inner join Student_Dept as sd on s.SDept=sd.DID;

select * from Student_Dep
select * from Students

--insert in a complex view
insert into Student_Dep values(15,'Sammy',103,'MCOM','Lisa')--View or function 'Student_Dep' is not updatable because the modification affects multiple base tables.

--update in a complex view
update Student_Dep set SName='Shawn' where SID=6

--delete in a complex view
delete from Student_Dep where SID=6--View or function 'Student_Dep' is not updatable because the modification affects multiple base tables.

--CAST() FUNCTION - TYPECASTING

select cast(12.365 as int) as Result

select cast(12.365 as varchar) as Result

select cast('2022-10-06' as datetime) as 'Current date'

--CONVERT() FUNCTION

select convert(int,12.3654) as Result

--COALESCE()

select COALESCE(NULL,NULL,'SQL',NULL,'SERVER')
select COALESCE(NULL,1,'SQL',NULL,'SERVER')

--CURRENT_USER
select CURRENT_USER

--IIF() - Working of ternary operator

select IIF(1>5,10,5) as Result

select * from Employee

create view Emp_Training_Status
as
select EID, EName, IIF(EDesignation='Trainee','Training in Process','Training Completed') as 'Training Status' from Employee

select * from Emp_Training_Status

--CHOOSE()

select CHOOSE(3,'C#','SQL','ANGULAR','REACT') as Result

select * from demo
alter table demo add DOJ datetime

update demo set DOJ=cast('2022-10-06' as datetime) where TID=100
update demo set DOJ=cast('2022-1-06' as datetime) where TID=104
update demo set DOJ=cast('2022-7-06' as datetime) where TID=102
update demo set DOJ=cast('2021-10-06' as datetime) where TID=106

select TID,TName,DOJ,CHOOSE(MONTH([DOJ]),'Jan','Feb','Mar','Apr','May','June','July',
'Aug','Sep','Oct','Nov','Dec') as 'Month' from demo;

--CASE Statement - multiple conditions
--Simple
--Searched
select * from Employee 

--Simple
select EID,EName,EDEsignation,
CASE EDesignation	
	WHEN 'Junior S/W Engineer' THEN 'Junior S/W Engineer -  PROBATION FOR 6 MONTHS'
	WHEN 'Senior S/W Engineer' THEN 'Senior S/W Engineer -  Approved for Client Projects'
	ELSE 'UNDERGOING TRAINING'
END
AS 'Employee designation details'
from Employee

--Searched
select EID,EName,EDEsignation,
CASE
	WHEN EDesignation='Junior S/W Engineer' THEN 'Junior S/W Engineer -  PROBATION FOR 6 MONTHS'
	WHEN EDesignation='Senior S/W Engineer' THEN 'Senior S/W Engineer -  Approved for Client Projects'
	ELSE 'UNDERGOING TRAINING'
END
AS 'Employee designation details'
from Employee

--Searched
select EID,EName,EDesignation,EAge,
CASE
	WHEN EAge >= 24 AND EAge <= 26  THEN 'CHECK PREVIOUS WORK EXP'
	WHEN EAge > 26 and EAge <28 THEN 'GET THE LIST OF PREVIOUS PROJECTS'
ELSE 'UNDERGOING TRAINING'
END
AS 'Employee designation details'
from Employee

SELECT ASCII('A'), ASCII('B');  

SELECT CONCAT('Hello', 'Pallavi');  

SELECT LEFT('Hello Pallavi', 5), RIGHT(' GoodMorning Pallavi', 7);  

SELECT REPLICATE('Prathu', 4) AS Result;  

Select floor(5.7);

Select power(2,5);

Select sqrt(9);

Select cos(0);

--print the only date of given value
SELECT DAY('2000-06-18 04:10:11') as Day_Output --as Month_Output, as Year_Output

--add the 2 year to the given year
SELECT DATEADD(year, 2, '2001/06/18') as DateAdd_Output

--Find the difference between the year
SELECT DATEDIFF(year, '2000/06/18', '2022/06/18') as DateDiff_Output

--Check if the enter date is valid or not
SELECT ISDATE('2022-10-07') as Valid_dateOutput --1
SELECT ISDATE('Invalid!') as Invalid_dateOutput --0

--Gives the specific part of date
SELECT DATEPART(MONTH, '2022/06/18') as DatePart_Output

--Gives the date from its part
SELECT DATEFROMPARTS(2000, 06, 18) as DateFrom_Output

--Gives the date and time of SQL server
SELECT SYSDATETIME() as SysDateTime_Output

--print the current date with time
SELECT CURRENT_TIMESTAMP as Current_Date_Time
