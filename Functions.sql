use TE
--FUNCTION - > perform an action 
-- TYPES - SYSTEM AND USER-DEFINED
-- USER-DEFINED 
------------------
-- 1. SCALAR
-- 2. TABLE-VALUED -> INLINE TABLE-VALUED, MULTI-STATEMENT TABLE VALUED

-- 1. SCALAR
--return a single value
--returns keyword - any datatype

--CREATE FUNCTION
--@parameter -> table variables
--public int square(int a) -- square(10)
--{
--return a*a;
--}
create function Fn_Square(@a int)
returns int
as
begin
	return @a * @a
end

--call the function
select dbo.Fn_Square(4) as Result

select * from demo

select dbo.Fn_Square(TID),TName from demo

select dbo.Fn_Square(EID),EName from Employee

--scalar function to calculate the datediff
create function Fn_datediff(@DateField Date)
returns int
as
begin
	Declare @days int --declaration of the table variable
	Set @days=datediff(day,@DateField,Getdate()) --assigning the difference in days to @days
	return @days
end

alter function Fn_datediff(@DateField Date)
returns int
as
begin
	Declare @month int --declaration of the table variable
	Set @month=datediff(month,@DateField,Getdate()) --assigning the difference in month to @month
	return @month
end

alter function Fn_datediff(@DateField Date)
returns int
as
begin
	Declare @year int --declaration of the table variable
	Set @year=datediff(year,@DateField,Getdate()) --assigning the difference in year to @year
	return @year
end

--Select Clause
select TID,TName,DOJ,dbo.Fn_datediff(DOJ) as 'Days Elapsed' from demo;
--where clause
select TID,TName,DOJ,dbo.Fn_datediff(DOJ) as 'Days Elapsed' from demo where dbo.Fn_datediff(DOJ)>0;


select dbo.Fn_datediff('02/20/2000') as 'Age'

-- 2.TABLE-VALUED

-- INLINE TABLE-VALUED
--returns keyword - return the result in the form of table
--no begin and end is required
--update is possible
--Better performance

Select * from Employee

create function Fn_EmpByID(@empid int)
returns table
as
return(select * from Employee where EID=@empid)

--call the function 
Select * from Fn_EmpByID(11)

--MUTI-STATEMENT TABLE-VALUED
--returns keyword - own table structure
--begin and end is required
--update is not possible

create function Fn_SearchEmployee()
-- should match with the actual table (no of col,seq of col,datatype of col)
returns @EmpTable Table(EmpID int,EmpName varchar(20),EmpAge int)
as
begin
--insert into select 
	insert into @EmpTable
		select EID,EName,EAge from Employee;
	return
end

--call the function
select * from dbo.Fn_SearchEmployee()
--update dbo.Fn_SearchEmployee() -- Multi-statement

update dbo.Fn_SearchEmployee() set EmpAge=24 where EmpID=11--Object 'dbo.Fn_SearchEmployee' cannot be modified.

