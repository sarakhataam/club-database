create view employee_view
as select fname+' '+lname as full_name, dno from employees
go
create view member_view
as select fname+' '+lname as full_name, date_of_join from members
