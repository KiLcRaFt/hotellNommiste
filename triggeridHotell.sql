CREATE TABLE guest(
id int not null PRIMARY KEY identity(1,1) ,
first_name varchar(80),
last_name varchar(80) NULL,
member_since date )

CREATE TABLE room_type(
id int not null PRIMARY KEY identity(1,1),
description varchar(80),
max_capacity int)

CREATE TABLE reservation(
id int not null PRIMARY KEY identity(1,1),
date_in date,
date_out date,
made_by varchar(20),
guest_id int,
foreign key (guest_id) REFERENCES guest(id))

CREATE TABLE reserved_room(
id int not null PRIMARY KEY identity(1,1),
number_of_rooms int,
room_type_id int,
reservation_id int,
status varchar(20)
foreign key (room_type_id) REFERENCES room_type(id),
foreign key (reservation_id) REFERENCES reservation(id));

CREATE TABLE room(
id int not null PRIMARY KEY identity(1,1),
number varchar(10),
name varchar(40),
status varchar(10),
smoke bit,
room_type_id int,
foreign key (room_type_id) REFERENCES room_type(id));


create table occupied_room(
id int not null primary key identity(1,1),
check_in datetime,
check_out datetime,
room_id int,
reservation_id int,
foreign key (room_id) references room(id),
foreign key (reservation_id) references reservation(id));

create table hosted_at(
id int not null primary key identity(1,1),
guest_id int,
occupied_room_id int,
foreign key (guest_id) references guest(id),
foreign key (occupied_room_id) references occupied_room(id));

CREATE TABLE AuditTable
(
    AuditRecordID INT IDENTITY(1, 1) ,
    EventType VARCHAR(128) ,
    PostTime VARCHAR(128) ,
    SPID INT ,
    UserName VARCHAR(128) ,
    DatabaseName VARCHAR(128) ,
    SchemaName VARCHAR(128) ,
    ObjectName VARCHAR(128) ,
    ObjectType VARCHAR(128) ,
    Parameters VARCHAR(2000) ,
    AlterTableActionList VARCHAR(2000) ,
    TSQLCommand VARCHAR(2000)
);

CREATE OR ALTER TRIGGER TR_Schema_Change ON DATABASE 
FOR DDL_TABLE_VIEW_EVENTS
AS
 
DECLARE @EventData XML;  
SET @EventData = EVENTDATA();  
 
INSERT INTO dbo.AuditTable ( EventType ,
                             PostTime ,
                             SPID ,
                             UserName ,
                             DatabaseName ,
                             SchemaName ,
                             ObjectName ,
                             ObjectType ,
                             Parameters ,
                             AlterTableActionList ,
                             TSQLCommand )
 VALUES (@EventData.value('(/EVENT_INSTANCE/EventType)[1]', 'VARCHAR(128)') ,
         @EventData.value('(/EVENT_INSTANCE/PostTime)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/SPID)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/UserName)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/SchemaName)[1]', 'VARCHAR(128)') ,
         @EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'VARCHAR(128)') ,
         @EventData.value('(/EVENT_INSTANCE/ObjectType)[1]', 'VARCHAR(128)') ,
         @EventData.value('(/EVENT_INSTANCE/Parameters)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/AlterTableActionList)[1]', 'VARCHAR(128)')  ,
         @EventData.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)') 
      );
 
GO

CREATE TABLE t1(a INT)

ALTER TABLE t1 ADD b INT 

DROP TABLE t1
 
SELECT * FROM dbo.AuditTable

SELECT QUOTENAME(OBJECT_SCHEMA_NAME(TR.object_id)) + '.' + QUOTENAME(TR.name) [Trigger_name],
       QUOTENAME(OBJECT_SCHEMA_NAME(T.object_id)) + '.' + QUOTENAME(T.name) [Parent_table_name],                 
       QUOTENAME(OBJECT_SCHEMA_NAME(V.object_id)) + '.' + QUOTENAME(V.name) [Parent_view_name]
FROM sys.triggers TR
LEFT JOIN sys.tables T
    ON TR.parent_id = T.object_id
LEFT JOIN sys.views V
    ON TR.parent_id = V.object_id
WHERE TR.parent_class = 1

SELECT name,
       parent_class_desc,
       type_desc,
       is_disabled
FROM sys.triggers
WHERE is_disabled = 0;

SELECT 
	t2.[name] TableTriggerReference
	, SCHEMA_NAME(t2.[schema_id]) TableSchemaName
	, t1.[name] TriggerName
FROM sys.triggers t1
	INNER JOIN sys.tables t2 ON t2.object_id = t1.parent_id
WHERE t1.is_disabled = 0
	AND t1.is_ms_shipped = 1
	AND t1.parent_class = 1

alter trigger markusAlterTable
on database
for ALTER_TABLE
as
begin
	insert into AuditTable(EventType, PostTime, SPID,UserName, DatabaseName, SchemaName, ObjectName, ObjectType, Parameters, AlterTableActionList,TSQLCommand)
	values('Alter Table', GETDATE(), @@SPID, USER, null, null, null, null, null, null, 'ALTER TABLE command executed')
end;

create table Proverka(ID int);
alter table Proverka ADD Test varchar(10);
select * from AuditTable;
drop table Proverka;

create trigger markusDropTable
on database
for DROP_TABLE
as
begin
	insert into AuditTable(EventType, PostTime, SPID,UserName, DatabaseName, SchemaName, ObjectName, ObjectType, Parameters, AlterTableActionList,TSQLCommand)
	values('DROP Table', GETDATE(), @@SPID, USER, null, null, null, null, null, null, 'DROP TABLE command executed')
end;

create table Proverka(ID int);
alter table Proverka ADD Test varchar(10);
select * from AuditTable;
drop table Proverka;
