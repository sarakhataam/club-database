create trigger is_aleardy_payed_cash_trig
on cash_fees
after insert
as
begin
	--2020-4-12 id:3
	--2020-3-13 id:3
	declare @date date, @id int, @rows_no int
	select @date = payment_date, @id = member_id from inserted as i

	select @rows_no = count(*)  from cash_fees
	where year(payment_date) = year(@date)
	 and member_id = @id
	 
	 if(@rows_no > 1)
		rollback transaction
end
go
--------------------------------------
create trigger is_aleardy_payed_installments_trig
on installments_fees
after insert
as
begin
	--2020-3-12 id:3
	--2020-3-13 id:3
	declare @date date, @id int, @rows_no int
	select @date = payment_date, @id = member_id from inserted as i

	select @rows_no = count(*)  from installments_fees
	where month(payment_date) = month(@date) and
	 year(payment_date) = year(@date)
	 and member_id = @id

	 if(@rows_no > 1)
		rollback transaction
end
go
--------------------------------------
create trigger is_aleardy_payed_sports_trig
on pay_sports_fees
after insert
as
begin
	--2020-3-12 sno:1 id:3
	--2020-3-13 sno:1 id:3 ->err
	declare @date date, @id int, @sno int, @rows_no int
	select @date = payment_date, @id = member_id, @sno = sno from inserted as i

	select @rows_no = count(*)  from pay_sports_fees
	where month(payment_date) = month(@date) and
	 year(payment_date) = year(@date)
	 and member_id = @id
	 and sno = @sno

	 if(@rows_no > 1)
		rollback transaction
end

go
-------------------------------
create trigger is_aleardy_payed_transports_trig
on pay_transports_fees
after insert
as
begin
	--2020-3-12 sno:1 id:3
	--2020-3-13 sno:1 id:3 ->err
	declare @date date, @id int, @rows_no int
	select @date = payment_date, @id = member_id from inserted as i

	select @rows_no = count(*)  from pay_transports_fees
	where month(payment_date) = month(@date) and
	 year(payment_date) = year(@date)
	 and member_id = @id

	 if(@rows_no > 1)
		rollback transaction
end
insert into pay_transports_fees
values( 1, 'VIP', '2022-08-02')
select * from pay_transports_fees