CREATE TABLE guest(
id counter PRIMARY KEY ,
first_name varchar(80),
last_name varchar(80),
member_since date )

CREATE TABLE room_type(
id counter PRIMARY KEY,
description varchar(80),
max_capacity int)

CREATE TABLE reservation(
id counter PRIMARY KEY,
date_in date,
date_out date,
made_by varchar(20),
guest_id int,
foreign key (guest_id) REFERENCES guest(id))

CREATE TABLE reserved_room(
id counter PRIMARY KEY,
number_of_rooms int,
room_type_id int,
reservation_id int,
status varchar(20),
foreign key (room_type_id) REFERENCES room_type(id),
foreign key (reservation_id) REFERENCES reservation(id));

CREATE TABLE room(
id counter PRIMARY KEY,
numbers varchar(10),
name varchar(40),
status varchar(10),
smoke bit,
room_type_id int,
foreign key (room_type_id) REFERENCES room_type(id));

create table occupied_room(
id counter primary key,
check_in datetime,
check_out datetime,
room_id int,
reservation_id int,
foreign key (room_id) references room(id),
foreign key (reservation_id) references reservation(id));

create table hosted_at(
id counter primary key,
guest_id int,
occupied_room_id int,
foreign key (guest_id) references guest(id),
foreign key (occupied_room_id) references occupied_room(id));
