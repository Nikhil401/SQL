--GROUPING SETS - EXTENSION TO YOUR GROUP BY

select * from Employee

--Aggregate function
select count(EDeptNo) from Employee
--Aggregate function with Group by
select EDesignation,count(EDeptNo) from Employee group by EDesignation
--Aggregate function with Group by and Grouping sets
select EAge,count(EDeptNo) as Total_Emp,EDeptNo from Employee 
group by GROUPING SETS
(
(EAge,EDeptno)
)
order by EAge,EDeptno


--ROLLUP - EXTENSION OF GROUP BY CLAUSE

--Aggregate function with Group by
select EDesignation,count(EDeptNo) as Total_Emp from Employee group by EDesignation

select EDesignation,count(EDeptNo) as Total_Emp from Employee group by ROLLUP (EDesignation)

select coalesce(EDesignation,'Sub-Total') as Designation,count(EDeptNo) as Total_Emp from Employee group by ROLLUP (EDesignation)

select coalesce(EDesignation,'Total') as Designation,coalesce(cast(EAge as varchar),'Sub-total') as Age,
count(EDeptNo) as Total_Emp from Employee group by ROLLUP (EDesignation,EAge)

--CUBE - EXTENSION OF GROUP BY CLAUSE

--Aggregate function with Group by
select EDesignation,count(EDeptNo) as Total_Emp from Employee group by EDesignation

select EDesignation,count(EDeptNo) as Total_Emp from Employee group by CUBE (EDesignation)

select coalesce(EDesignation,'Sub-Total') as Designation,count(EDeptNo) as Total_Emp from Employee group by CUBE (EDesignation)

select coalesce(EDesignation,'Total') as Designation,coalesce(cast(EAge as varchar),'Sub-total') as Age,
count(EDeptNo) as Total_Emp from Employee group by ROLLUP (EDesignation,EAge)

select coalesce(EDesignation,'Total') as Designation,coalesce(cast(EAge as varchar),'Sub-total') as Age,
count(EDeptNo) as Total_Emp from Employee group by CUBE (EDesignation,EAge)
