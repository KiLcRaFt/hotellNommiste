--32 funktsioonid
Create Function fn_ILTVF_GetEmployees()
returns table
as
return(Select EmployeeKey, FirstName, Cast(BirthDate as date) as DOB
from DimEmployee)

select * from dbo.fn_ILTVF_GetEmployees();

Create Function dn_MSTVF_GetEmployees()
returns @Table table (EmployeeKey int, FirstName nvarchar(20), DOB Date)
as
BEGIN
Insert into @Table
Select EmployeeKey, FirstName, Cast(BirthDate as Date)
from DimEmployee
return
END

select * from dbo.dn_MSTVF_GetEmployees();
select * from dbo.fn_ILTVF_GetEmployees();

Update dn_MSTVF_GetEmployees() set FirstName='Sam1' where EmployeeKey=1


--33 funktsioonid

Create Function fn_GetEmployeeNameById(@Id int)
Returns nvarchar(20)
as
Begin
Return(Select FirstName from DimEmployee where EmployeeKey=@Id)
end

Select dbo.fn_GetEmployeeNameById(2);

GO
exec sp_helptext 'dbo.fn_GetEmployeeNameById';
GO

Alter Function fn_GetEmployeeNameById(@Id int)
Returns nvarchar(20)
with SchemaBinding
as
Begin
Return(Select FirstName from dbo.DimEmployee where EmployeeKey=@Id)
end

drop table DimEmployee;

--34 ajutisedTabelid

Create Table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails Values(1, 'Absolut');
insert into #PersonDetails Values(2, 'Lil Peep');
insert into #PersonDetails Values(3, 'Tinker');

select * from #PersonDetails;

select name from tempdb..sysobjects
where name like '#PersonDetails%';

Create Procedure spCreateLocalTempTable
as
Begin
Create Table #PersonDetails(Id int, Name nvarchar(20))
insert into #PersonDetails Values(1, 'Absolut');
insert into #PersonDetails Values(2, 'Lil Peep');
insert into #PersonDetails Values(3, 'Tinker');
select * from #PersonDetails
end

exec spCreateLocalTempTable;

Create Table ##EmployeDetails(Id int, Name nvarchar(20));
select * from ##EmployeDetails;

-- 35 indeksidServeris

Select * from DimEmployee where BaseRate >35 and BaseRate < 50

Create index IX_DimEmployee_BaseRate
on DimEmployee (BaseRate ASC)

exec sys.sp_helpindex @Objname = 'DimEmployee'

select EmployeeKey, FirstName, BaseRate
from DimEmployee with(index(IX_DimEmployee_BaseRate))

drop index DimEmployee.FirstNameLastName
