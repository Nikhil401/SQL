create database MY_APP

USE MY_APP;

create table Registration
(
id int primary key Identity(1,1),
username varchar(25),
useremail varchar(40),
password varchar(25),
mobile varchar(25)
)
select * from Registration
set identity_insert Registration on

insert into Registration(id,username,useremail,password,mobile)Values
(1,'prathu','prathu@gmail.com','prathu@123','867688767675');
