Create procedure guestArvu
as
begin
Select Count(id) as KülalisteArvu
from guest
end;
--kontroll
exec guestArvu;
