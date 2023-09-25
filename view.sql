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

-- 41 file

create table tblProduct
(
ProductId int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into tblProduct Values(1, 'Peciles', 20)
insert into tblProduct Values(2, 'Teqila', 79)
insert into tblProduct Values(3, 'Rum', 61)
insert into tblProduct Values(4, 'Moonshine', 187)

Create table tblProductSales
(
ProductId int,
QuantitySold int
)

insert into tblProductSales values(1, 23)
insert into tblProductSales values(2, 6)
insert into tblProductSales values(1, 18)
insert into tblProductSales values(4, 92)
insert into tblProductSales values(3, 78)
insert into tblProductSales values(3, 11)
insert into tblProductSales values(2, 2)

create view vWTotalSalesByproduct
with SchemaBinding
as
select Name,
SUM(ISNULL((QuantitySold * UnitPrice), 0)) as TotalSales,
COUNT_BIG(*) as  TotalTransactios
from dbo.tblProductSales
join dbo.tblProduct
on dbo.tblProduct.ProductId = dbo.tblProductSales.ProductId
group by Name

select * from vWTotalSalesByproduct

Create Unique Clustered index UIX_vWTotalSalesByproduct_Name
on vWTotalSalesByproduct(Name)

EXECUTE SP_HELPCONSTRAINT vWTotalSalesByproduct

-- 42 file

Create View vWEmployeeDetails
@Gender nvarchar(20)
as
Select Id, Name, Gender, DepartmentId
from  tblEmployee
where Gender = @Gender


Create function fnEmployeeDetails(@Gender nvarchar(20))
Returns Table
as
Return 
(Select Id, Name, Gender, Departmetid
from tblEmployee where Gender = @Gender)

Select * from dbo.fnEmployeeDetails('Male')

Create View vWEmployeeDetailsSorted
as
Select Id, Name, Gender, Departmetid
from tblEmployee
order by Id

Create Table ##TestTempTable(Id int, Name nvarchar(20), Gender nvarchar(10))

Insert into ##TestTempTable values(101, 'Martin', 'Male')
Insert into ##TestTempTable values(102, 'Joe', 'Female')
Insert into ##TestTempTable values(103, 'Pam', 'Female')
Insert into ##TestTempTable values(104, 'James', 'Male')


Create View vwOnTempTable
as
Select Id, Name, Gender
from ##TestTempTable
