-- 92 file
create trigger trMyFirstTrigger
ON Database
for CREATE_TABLE
as
begin
print 'New table created'
end

create Table Test4 (Id int)
select * from Test;

alter trigger trMyFirstTrigger
ON Database 
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
print 'A table just been created, modifield or deleted'
end

create table TEST2(id int)
insert into Test(Id) values(1);

alter trigger trMyFirstTrigger
ON Database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
Rollback
print 'You cannot create, alter or drop a table'
end

drop table TEST2

disable trigger trMyFirstTrigger on Database

drop trigger trMyFirstTrigger on Database

create trigger trRenameTable
on database
for RENAME
as
begin
print 'You just renamed something'
end

-- 93 file
create trigger tr_DatabaseScopeTrigger
on database
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as
begin
rollback
print 'You cannot create, alter or drop a table in the current database'
end

create trigger tr_ServerScopeTrigger
on ALL SERVER
for CREATE_TABLE, ALTER_TABLE, DROP_TABLE
as 
begin
rollback
print 'You cannot create, alter or drop a table in any database on the server'
end

disable trigger tr_ServerScopetrigger on all server

enable trigger tr_ServerScopetrigger on all server

drop trigger tr_ServerScopetrigger on all server

-- 94 file

create trigger tr_DatabaseScopeTrigger
ON DATABASE
for create_table
as
begin
print 'Database Scope Trigger'
end
go

create trigger tr_ServerScopeTrigger
ON all server
for create_table
as
begin
print 'Server Scope Trigger'
end
go

exec sp_settriggerorder
@triggername = 'tr_DatabaseScopeTrigger',
@order= 'none',
@stmttype = 'CREATE_TABLE',
@namespace='DATABASE'
GO

--96 file

create trigger tr_LogonAuditTriggers
on all server
for LOGON
as
begin
	declare @LoginName NVARCHAR(100)
	set @LoginName = ORIGINAL_LOGIN()
	IF(select count(*) from sys.dm_exec_sessions
		where is_user_process=1
		and original_login_name=@LoginName)>3
	begin
		print 'Fourth connection of ' + @LoginName + ' blocked'
		rollback
	end
end

Execute sp_readerrorlog
