create procedure edit_budget
@dno1 int,
@dno2 int,
@amount int
as 
begin
	begin transaction
	update departments 
	set budget = budget + @amount
	where dno = @dno1

	update departments 
	set budget = budget - @amount
	where dno = @dno2

	declare @budget int
	select @budget = budget from departments
	where dno = @dno2
	if(@budget > 0)
		commit
	else 
		rollback
end