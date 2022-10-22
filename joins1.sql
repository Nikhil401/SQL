use TE
--JOINS 
--JOIN CLAUSE - combine rows from 2 or more tables based on a common column
--TYPES - INNER,OUTER(LEFT,RIGHT,FULL),SELF,CROSS

create table Students
(
SID int Primary Key,
SName varchar(20) Not Null,
SDept int Unique Not null -- DID int unique Not Null
)

create table Student_Dept
(
DID int Primary Key,
DName varchar(20),
DHead varchar(20)
)

insert into Students values(1,'John',101),(2,'Peter',102),(3,'Sam',103),(4,'Lea',104),(5,'Lee',105),(6,'Shaun',106)
insert into Student_Dept values(101,'BCA','Jancy'),(102,'BBA','Dwayne'),(103,'BCOM','Jose'),(104,'BSC','Prince'),(105,'BBA','Stella'),(106,'BBM','Lisa')
select * from Students
select * from Student_Dept

--INNER JOIN - COMMON RECORDS FROM BOTH THE TABLES
select SID,SName,DID,DName,DHead from Students inner join Student_Dept on SDept=DID;

select * from Students

insert into Students values(7,'Paul',107),(8,'Daisy',108),(9,'Tom',109)

--Table alias
select Students.SID,Students.SName,Student_Dept.DID,Student_Dept.DName,Student_Dept.DHead 
from Students inner join Student_Dept on Students.SDept=Student_Dept.DID;

--Short alias for the tables
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s inner join Student_Dept as sd on s.SDept=sd.DID;

select * from Students
select * from Student_Dept

--OUTER JOIN - LEFT,RIGHT,FULL

--LEFT - Students(Left) and Student_Dept(Right)
--All the rows from the left table and replace the non-matching values with NULL in the right table
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s LEFT join Student_Dept as sd on s.SDept=sd.DID;

--RIGHT - Students(Left) and Student_Dept(Right)
--All the rows from the right table and replace the non-matching values with NULL in the left table
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s RIGHT join Student_Dept as sd on s.SDept=sd.DID;

insert into Student_Dept values(110,'MCA','JOANNE'),(111,'MBA','DEREK')

--All the rows from the right table AND left table and replace the non-matching values with NULL in the both table
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s FULL join Student_Dept as sd on s.SDept=sd.DID;


select * from Students
select * from Student_Dept
select * from Student_Rep

--alter the Students table
alter table Students add SRep varchar(20)

create table Student_Rep
(
SID int Primary Key,
SName varchar(20) unique Not Null
)

--JOIN 3 TABLES
select * from Students
select * from Student_Dept
select * from Student_Rep

select s.SID,s.SName,s.SRep,sd.DID,sd.DName,sd.DHead 
from Students as s 
inner join Student_Dept as sd on s.SDept=sd.DID 
inner join Student_Rep as sr on s.SRep=sr.SName

--SEQUENCE
--CREATE 

create table demo
(
TID int,
TName varchar(20)
)

create sequence TraineeID as int start with 100 increment by 2

insert into demo values(NEXT VALUE FOR TraineeID,'John')
insert into demo values(NEXT VALUE FOR TraineeID,'Sam')
insert into demo values(NEXT VALUE FOR TraineeID,'Paul')
insert into demo values(NEXT VALUE FOR TraineeID,'James')

select * from demo

create table demo1
(
TID int,
TName varchar(20)
)

insert into demo1 values(NEXT VALUE FOR TraineeID,'John')
insert into demo1 values(NEXT VALUE FOR TraineeID,'Sam')
insert into demo1 values(NEXT VALUE FOR TraineeID,'Paul')
insert into demo1 values(NEXT VALUE FOR TraineeID,'James')

select * from demo
select * from demo1

--TRUNCATE
truncate table demo1

--ALTER THE SEQUENCE AND RESET THE VALUE
alter sequence TraineeID restart with 1000 increment by 1

--drop sequence
drop sequence TraineeID

--INDEX
--Faster retrieval of data/improve performance
--Clustered(ONLY ONE) and Non-clustered index
--Avoid creating too many index on a table
--create an index on only frequently used columns

--CLUSTERED 
--PRIMARY KEY -> AUTOMATICALLY CLUSTERED INDEX IS CREATED
--LEAF NODE -> STRUCTURED FORMAT - CLUSTERED TABLE

--NON-CLUSTERED
--UNIQUE KEY -> AUTOMATICALLY UNIQUE NON-CLUSTERED INDEX IS CREATED 
--UNSTRUCTURED FORMAT

--create a clustered index on demo table
create clustered index ind_TID on demo(TID)

--create a non clustered index on demo table
create index ind_TName on demo(TName)

select * from Employee

--Filtered index
create index ind_EDes on Employee(EDesignation) where EDesignation='Trainee'

select * from Employee where EDesignation='Trainee'