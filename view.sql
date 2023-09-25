-- 39 file

create table tblEmployee
(
id int Primary Key,
name nvarchar(30),
Salary int,
Gender nvarchar(10),
Departmetid int)

create table tblDepartment
(
Deptid int primary key,
DeptName nvarchar(20))

insert into tblDepartment values(1, 'IT');
insert into tblDepartment values(2, 'Payroll');
insert into tblDepartment values(3, 'HR');
insert into tblDepartment values(4, 'Adminchik');

insert into tblEmployee values(1, 'Nikita', 4000, 'Male', 3);
insert into tblEmployee values(2, 'Nikitos', 4400, 'Male', 2);
insert into tblEmployee values(3, 'Nikitata', 5700, 'Female', 1);
insert into tblEmployee values(4, 'Nikolai', 2200, 'Male', 4);
insert into tblEmployee values(5, 'Nittra', 1500, 'Female', 1);

select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.Departmetid = tblDepartment.DeptId

Create View vWEmployeesByDepartment
as
select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.Departmetid = tblDepartment.DeptId

select * from vWEmployeesByDepartment

Create View vWITDepartment_Employees
as
select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.Departmetid = tblDepartment.DeptId
where tblDepartment.DeptName = 'IT'

select * from vWITDepartment_Employees

Create View vWEmployeesNonConfidentialData
as
select Id, Name, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.Departmetid = tblDepartment.DeptId

select * from vWEmployeesNonConfidentialData

Create View vWEmployeesCountByDepartment
as
select DeptName, COUNT(Id) as totalEmployees
from tblEmployee
join tblDepartment
on tblEmployee.Departmetid = tblDepartment.DeptId
group by DeptName

select * from vWEmployeesCountByDepartment

-- file 40

create view vWEmployeesDataExceptSalary
as
select Id, Name, Gender, Departmetid
from tblEmployee

select * from vWEmployeesDataExceptSalary

update vWEmployeesDataExceptSalary
set Name = 'NAIKIE' where id=5

select * from vWEmployeesDataExceptSalary

Delete from vWEmployeesDataExceptSalary where id=5;
insert into vWEmployeesDataExceptSalary values(5, 'NIKIE', 'Male', 2)

create view vwEmployeesDetailsByDepartment
as
select Id, Name, Salary, Gender, DeptName
from tblEmployee
join tblDepartment
on tblEmployee.Departmetid = tblDepartment.Deptid

select * from vwEmployeesDetailsByDepartment

update vwEmployeesDetailsByDepartment
set DeptName='IT' where Name ='Nikolai'

select * from vwEmployeesDetailsByDepartment

select * from tblEmployee;
select * from tblDepartment;
