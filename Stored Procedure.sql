-DIFFERENCES BETWEEN FUNCTION AND STORED PROCEDURE
--STORED PROCEDURE
--------------------
--1. Perform a task in an orderly manner
--2. Procedures cannot be used within a query
--3. DML can be performed
--4. Call a function in a procedure

--FUNCTION 
------------
--1. Perform Calculations/operations - with or without parameters
--2. Functions can be used within a query (select)
--3. No DML
--4. Cannot call a procedure in a function

--STORED PROCEDURE - Sub-routine/sub-program
---------------------------------------------
-- Combine all the set of queries which are frequently accessed into a Stored Procedure(Select,Insert,Delete,Update)
-- Save time
-- Improve the performance
-- Stored in the form of pre-compiled code
-- Create a Stored Prcedures - input/ouput parameters

--TYPES - SYSTEM & USER-DEFINED

select * from Employee
--Procedure with no parameters
create procedure sp_TotalEmpByDesignation
as
Begin
	select EDesignation,count(EDeptNo) as Total_Emp_Designation from Employee Group By EDesignation
end

--execute a procedure
exec sp_TotalEmpByDesignation

--Procedure with Input Parameter - by default
create procedure sp_EmpByName(@empname varchar(20))
as
Begin
	select * from Employee where EName=@empname
End

--execute the procedure
execute sp_EmpByName @empname='John'
--or
execute sp_EmpByName 'Peter'
--or
exec sp_EmpByName 'Sam'

--Procedure with Output Parameter - OUTPUT keyword

create procedure sp_TotalEmp(@totalemp int OUTPUT)
as
Begin
	Select @totalemp=count(EID) from Employee
End

--execute the procedure with ouput parameter
--execute the below three lines at once
Declare @Result int
exec sp_TotalEmp @Result OUTPUT --OUPUT is mandatory
Print @Result

--int add(int a)
--{
--return a*a;
--}

--void Main()
--{
--int result=add(10);
--cout<<result;
--}


--TEMPORARY PROCEDURES - created and reflected in the tempdb(under Sysytem Databases)
-- GLOBAL AND LOCAL

--All database objects that are created for temporary purpose are prefixed with:
--Local - #
--Global - ##

create procedure #Temp
as Begin
print 'Local Temp Procedure'
end

--CREATE A TEMP TABLE
create table #temptable
(
id int
)

create procedure ##GlobalTemp
as Begin
print 'Global Temp Procedure'
end

--ADVANTAGES
--1. Reduce Network Traffic
--2. Improved Performance
--3. Reusable
--4. Secure the information