CREATE TRIGGER guestlisamine
ON guest
FOR INSERT
AS
insert into logi(kuupaev, kasutaja, andmed, tegevus)
SELECT
GETDATE(), USER,
Concat(
inserted.first_name, ', ',
inserted.last_name, ', ',
inserted.member_since
), 'guest on lisaud'
FROM inserted
