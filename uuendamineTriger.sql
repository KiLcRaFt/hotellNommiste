CREATE TRIGGER guestuuendamine
ON guest
FOR update
AS
insert into logi(kuupaev, kasutaja, andmed, tegevus)
SELECT
GETDATE(), USER,
Concat(
deleted.first_name, ', ',
deleted.last_name, ', ',
deleted.member_since, '\n Uued andmed ',
inserted.first_name, ', ',
inserted.last_name, ', ',
inserted.member_since
), 'guest on uuendatud'
FROM deleted inner join inserted
on deleted.id=inserted.id
