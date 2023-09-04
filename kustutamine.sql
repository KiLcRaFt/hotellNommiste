CREATE TRIGGER guestkustutamine
ON guest
FOR delete
AS
insert into logi(kuupaev, kasutaja, andmed, tegevus)
SELECT
GETDATE(), USER,
Concat(
deleted.first_name, ', ',
deleted.last_name, ', ',
deleted.member_since
), 'guest on kstutaud'
FROM deleted
