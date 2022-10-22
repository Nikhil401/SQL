-- SUBQUERY 
-- QUERY WITHIN A QUERY - NESTED QUERY
-- SELECT,INSERT,UPDATE,DELETE 
-- WHERE,FROM
-- OUTER QUERY(MAIN QUERY) - INNER QUERY(NESTED QUERY) - 32 LEVELS

USE TE

select * from Employee
select * from Department

--WHERE CLAUSE - SUBQUERY

--single table
select EID,EName,EAge from Employee where EAge IN(select DISTINCT EAge from Employee where EAge<26)

--more than one table
select EID,EName,EAge,EDeptNo from Employee where EDeptNo IN(select DID from Department where Dname IN('Admin','Training'))

--SELECT CLAUSE - SUBQUERY - CORRELATED SUBQUERY

--single table
select EID,EName,(select EDeptNo from Employee ie where ie.EID=oe.EID) as 'Emp No' from Employee oe;

select * from Students
select * from Student_Dept
select * from Student_Rep

--more than one table

select SID,SName,(select DID from Student_Dept dep where dep.DID=stud.SDept) as 'Dept No' from Students stud;

--FROM CLAUSE - SUBQUERY

--single table
select SID,SName,SDept from (select DISTINCT count(SDept) as 'Total Departments' from Students) 
as i_stud,Students as o_stud
where o_stud.SID =i_stud.[Total Departments] 

--based on the assumption of SDept as the Score column
select SID,SName,SDept from (select DISTINCT avg(SDept) as 'Average Department' from Students) 
as i_stud,Students as o_stud
where o_stud.SDept <i_stud.[Average Department] 

--more than one table
select SID,SName,SDept from (select DISTINCT avg(DID) as 'Average Department' from Student_Dept) 
as i_stud,Students as o_stud
where o_stud.SDept < i_stud.[Average Department] 

--INSERT STATEMENT - SUBQUERY
select * from demo
select * from demo1

--INSERT INTO SELECT - Copying contents from one table to another
insert into demo1 select TID,TName from demo 

insert into demo1 select TID,TName from demo where TID IN(Select TID from demo where TID>102)

--UPDATE - SUBQUERY

UPDATE demo1 set TID=1000 where TName IN(select TName from demo where TName='John')

--DELETE -SUBQUERY

delete from demo1 where TID IN(Select TID from demo)


--TYPES OF SUB QUERIES
--1. INDEPENDENT NESTED QUERY
--2. DEPENDENT NESTED QUERY(CORRELATED QUERY)

--INDEPENDENT SUB QUERIES
--IN,NOT IN, ANY, ALL

select * from Employee
select * from Department

--100,101,102,103,104 - Any one is true
select * from Department where DID=ANY(select Distinct EDeptNo from Employee)

select * from Department where DID=Any(select avg(EDeptno) from Employee)

--100,101,102,103,104 - All the conditions must be satisfied
--105 and 1-6 did not have a matching values - FALSE
select * from Department where DID=ALL(select Distinct EDeptNo from Employee)

select * from Department where DID=ALL(select avg(EDeptno) from Employee) -- 102

--CORRELATED SUBQUERY

--EXISTS

select * from Department where exists(select EDeptNo from Employee where Department.DID=Employee.EDeptNo)
