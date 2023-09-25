-- 36 file
Create Clustered Index IX_DimEmployee_BaseRate
ON DimEmployee(FirstName);

Drop Index DimEmployee.PK_DimEmployee_DimmployeeKey

create table tblEmployee(
id int primary key,
Name nvarchar (50),
Salary int,
Gender nvarchar(10),
City nvarchar(50))

insert into tblEmployee  (id, Name, Salary, Gender, City)
values(3, 'BigBon', 9999, 'Male', 'AbuDabi')
insert into tblEmployee  (id, Name, Salary, Gender, City)
values(2, 'SmallVon', 1002, 'Female', 'Muligad')
insert into tblEmployee  (id, Name, Salary, Gender, City)
values(4, 'VongGrip', 4200, 'Male', 'Lidumari')
insert into tblEmployee  (id, Name, Salary, Gender, City)
values(6, 'Kukishh', 2293, 'Male', 'Lugansk')
insert into tblEmployee  (id, Name, Salary, Gender, City)
values(8, 'Chuits', 1100, 'Female', 'Hologana')

create clustered index IX_tblEmloyee_Name
on tbl_Employee(Name)

create clustered index IX_tblEmloyee_Gender_Salary
on tblEmployee(Gender DESC, Salary ASC)

Create NonClustered index IX_tblEmployee_Name
on tblEmployee(Name)

-- 37 fail

create table tblEmployee
(
id int primary key,
FirstName nvarchar(50),
LastNmae nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50))

insert into tblEmployee  (id, FirstName, LastNmae, Salary, Gender, City)
values(6, 'Bibus','Kukishh', 2293, 'Male', 'Lugansk')
insert into tblEmployee  (id, FirstName, LastNmae, Salary, Gender, City)
values(8, 'Jhones','Chuits', 1100, 'Female', 'Hologana')

Execute sp_helpindex tblEmployee

drop index tblEmployee.PK__tblEmplo__3213E83F6ACD50CB

Insert into tblEmployee Values(23,'Mike', 'Sandoz',4500,'Male','New York')
Insert into tblEmployee Values(24,'John', 'Menco',2500,'Male','London')

select * from tblEmployee

delete from tblEmployee
where FirstName='Mike'

Create Unique NonClustered Index UIX_tblEmployee_FirstName_LastName
On tblEmployee(FirstName, LastName)

ALTER TABLE tblEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

EXECUTE SP_HELPCONSTRAINT tblEmployee

CREATE UNIQUE INDEX IX_tblEmployee_City
ON tblEmployee(City)
WITH IGNORE_DUP_KEY

-- 38 file

Create NonClustered index IX_tblEmployee_Salary
on tblEmployee (Salary ASC)

select * from tblEmployee where Salary > 1500 and Salary < 8000

delete from tblEmployee where Salary = 2293
update tblEmployee set Salary=9000 where Salary = 1100
select * from tblEmployee

select * from tblEmployee order by Salary Desc

select Salary, COUNT(Salary) as Total
from tblEmployee
Group by Salary
