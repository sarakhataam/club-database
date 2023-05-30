--1
create procedure get_info_member
@id int,
@month int,
@year int
as
begin
	declare @tbl table (id int,
					fname varchar(20),
					lname varchar(20),
					BoD date ,
					street varchar(20),
					no_of_building int,
					date_of_join date,
					sports_no int,
					class varchar(20))
	
	declare @sports_no int, @class varchar(20)

	insert into @tbl(id,fname,lname,BoD,street,no_of_building,date_of_join)
	select * from members where id = @id

	select @sports_no = count(*) from pay_sports_fees
	where member_id = @id and month(payment_date) = @month -- current month
	and year(payment_date) = @year -- current year

	select @class = class from pay_transports_fees
	where member_id = @id and month(payment_date) = @month -- current month
	and year(payment_date) = @year -- current year
	
	update @tbl
	set sports_no = @sports_no, class = @class
	select * from @tbl
end
go
--------------------------------------------------------
--3
create procedure get_sports_played_by
/*just select names of all sports palyed at any time*/
@id int
as
begin
	select name from sports
	where sno in (select sno 
		     from pay_sports_fees
		     where member_id = @id)
end
go
------------------------------------------------------
--4
create procedure get_payed_amount_by_instamllent
@id int
as
begin
	declare @fee_per_month int, @no_months int

	select @fee_per_month = fees from fees_constants
	where name = 'installment';

	select @no_months = count(payment_date)
	from installments_fees
	where member_id = @id

	declare @tbl table(amount_payed int, remaining_amount int)
	insert into @tbl
	values(@no_months * @fee_per_month, (12-@no_months) * @fee_per_month)
	select * from @tbl
end
go
-----------------------------------------------------
--5
create procedure is_payed_cash
/*assume the check for members who pay using cash*/
@id int,
@year int
as
begin
	declare @val int
	select @val = member_id from cash_fees
	where year(payment_date) = @year
		and member_id = @id ;

	if(@val is null) 
	begin
		select 'does NOT pay'
		return 0
	end
	else 
	begin
		select 'already payed'
		return 1
	end
end
go
--------------------------------------------
--6
create procedure is_payed_installments
/*assume the check for members who pay using installments*/
@id int,
@month int
as
begin
	select case when exists (select member_id from installments_fees
			where month(payment_date) = @month
			and member_id = @id) then 'already payed'
			else 'does NOT pay'
	end
end
go
------------------------------------------
--7
create procedure get_no_of_trainers_in_each_sport
as
begin
	/*distinct because in train table, trainer_ssn can appear
	 many times because it train several members*/
	select s.name, count( distinct t.trainer_ssn) as trainers_no
	from train t, sports s
	where t.sno = s.sno
	group by s.name
end
go
--------------------------------------------------
--8
create procedure get_no_of_buses_in_each_size
as
begin
	select (case when seats = 15 then 'mini'
		    when seats = 20 then 'small'
		    when seats = 30 then 'medium'
		    when seats = 45 then 'large' end) as size,
			count(bno) as buses_no
	from buses 
	group by seats;

end
go
--------------------------------------------------
--9
create procedure get_dep_manager
@dno int
as
begin
	select ssn, fname+' '+lname as full_name, d.manage_since 
	from employees e, departments d
	where d.dno = @dno and e.ssn = d.employee_ssn
end








