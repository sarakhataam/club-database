create function dependents_of(
    @id int
)
returns table
as
return 
    select 
        concat(fname,' ',lname) as full_name
    from
        dependents
    where
		member_id = @id

-- select * from dbo.dependents_of(8)
go
-----------------------------------

create function age_of(@id int)
returns int as
begin
	declare @age int
	select @age = year(CAST(GETDATE() AS DATE)) - year(BoD)  from members
	where id = @id
	return @age

end

--select dbo.age_of(2)
