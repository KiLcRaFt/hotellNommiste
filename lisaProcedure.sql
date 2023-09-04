Create procedure guestLisa
@first_name varchar(80),
@last_name varchar(80),
@member_since DATE
as
begin
Insert into guest(first_name, last_name, member_since)
values(@first_name,@last_name,@member_since);
Select * from guest;
select * from logi
end;
--kontroll
exec guestLisa 'John', 'skala', '2001/09/11';
