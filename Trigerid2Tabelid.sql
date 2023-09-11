--SQL code
-- taabelid
create table room_type(
id int primary key identity(1,1),
description varchar(80),
max_capacity int
);

create table room(
id int primary key identity(1,1),
number varchar(10),
name varchar(40),
status varchar(10),
smoke bit,
room_type_id int,
FOREIGN kEY (room_type_id) references room_type(id));

create table logi(

id int PRIMARY KEY identity(1,1),

andmed TEXT,

kuupäev datetime,

kasutaja varchar(100));

--Lisamine triger

create trigger room_lisamine

on room

for insert

as

insert into logi(kuupäev, andmed, kasutaja)

select GETDATE(),

concat('Lisatud andmed: ',
inserted.number, ', ', 
inserted.name, ', ',
inserted.status, ', ',
inserted.smoke, ', ',
rt.description, ', ',
rt.max_capacity),

USER

from inserted

inner join room_type rt on inserted.id=rt.id;

--kontroll

insert into room_type(description, max_capacity)
values('trap hata', 15);
select * from room_type;

insert into room(number, name, status, smoke, room_type_id)
values('209', 'GYM', 'open', 1, 3);
select * from room;
select * from logi;

--Uuendamine triger

create trigger roomUuendamine

on room

for UPDATE

as

insert into logi(kuupäev, andmed, kasutaja)

select GETDATE(),

concat('Vanad andmed: ', 
deleted.number, ', ', 
deleted.name, ', ',
deleted.status, ', ',
deleted.smoke, ', ',
rt1.description, ', ',
rt1.max_capacity, 
' Uued andmed: ', 
inserted.number, ', ', 
inserted.name, ', ',
inserted.status, ', ',
inserted.smoke, ', ',
rt2.description, ', ',
rt2.max_capacity),

USER

from deleted

inner join inserted on deleted.id=inserted.id

inner join room_type rt1 on deleted.room_type_id=rt1.id

inner join room_type rt2 on inserted.room_type_id=rt2.id

--kontroll

select * from room;

update room

set room_type_id = 1

where number='209';

select * from room;

select * from logi;

--XAMPP
-- tabelid
create table room_type(
id int primary key AUTO_INCREMENT,
description varchar(80),
max_capacity int
);

create table room(
id int primary key AUTO_INCREMENT,
number varchar(10),
name varchar(40),
status varchar(10),
smoke bit,
room_type_id int,
FOREIGN kEY (room_type_id) references room_type(id));

create table logi(

id int PRIMARY KEY AUTO_INCREMENT,

andmed TEXT,

kuupäev datetime,

kasutaja varchar(100));

--Lisamine triger

insert into logi(kuupäev, andmed, kasutaja)
select NOW(),
concat('Uued andmed: ', 
new.number, ', ', 
new.name, ', ',
new.status, ', ',
new.smoke, ', ',
rt.description, ', ',
rt.max_capacity),
USER()
from room r
inner join room_type rt 
on r.room_type_id=rt.id
where r.id=new.id

--Uuendamine triger
insert into logi(kuupäev, andmed, kasutaja)
select NOW(),
concat('Vanad andmed: ', 
old.number, ', ', 
old.name, ', ',
old.status, ', ',
old.smoke, ', ',
rt1.description, ', ',
rt1.max_capacity, 
' Uued andmed: ', 
new.number, ', ', 
new.name, ', ',
new.status, ', ',
new.smoke, ', ',
rt2.description, ', ',
rt2.max_capacity),
USER()
from room r
inner join room_type rt1 on old.room_type_id=rt1.id
inner join room_type rt2 on new.room_type_id=rt2.id
where r.id=new.id
