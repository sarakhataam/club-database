use db
drop database club
create database club;
go
use club;

create type ssn_type from char(9)
create type name_type from varchar(20)
create type phone_type from char(11)
go

create table members (
	id int primary key not null,
	fname name_type ,
	lname name_type,
	BoD date,
	street name_type,
	no_of_building int,
	date_of_join date,

);


create table employees (
	ssn ssn_type primary key not null ,
	fname name_type,
	lname name_type,
	BoD date,
	salary int,
	dno int not null,
	work_since date,
	constraint pos_salary check(salary>0)
);

create table members_phones (
	member_id int not null,
	phone phone_type not null,
	primary key (member_id, phone)
);

create table employees_phones (
	employee_ssn ssn_type not null,
	phone phone_type not null,
	primary key (employee_ssn, phone)
);

create table employees_addresses (
	employee_ssn ssn_type not null,
	city name_type not null,
	street name_type,
	primary key (employee_ssn, city)
);

create table trainers (
	employee_ssn ssn_type primary key not null,
	medals int,
	experience int,
	constraint pos_values check(medals>=0 and experience>=0)
);

create table drivers (
	employee_ssn ssn_type primary key not null ,
	bno int not null,
	drive_since date,
);

create table departments (
	dno int primary key not null,
	employee_ssn ssn_type not null unique,
	name name_type unique,
	budget int,
	manage_since date
);





create table transports (
	class name_type primary key not null,
	fees int
);

create table buses (
	bno int primary key not null,
	seats int,
	class name_type not null
);

create table sports (
	sno int primary key not null,
	name name_type unique,
	monthly_subscription int
);

create table cash_fees (
	payment_date date,
	member_id int not null,
	primary key(payment_date, member_id)
);

create table installments_fees (
	payment_date date,
	member_id int not null,
	primary key(member_id, payment_date)
);

create table dependents (
	did int not null unique,
	fname name_type,
	lname name_type,
	member_id int not null,
	primary key(did, member_id)
);

create table tickets (
	payment_date date,
	did int not null,
	member_id int not null,
	primary key(member_id, payment_date, did),

);

create table train (
	member_id int not null,
	sno int not null,
	trainer_ssn ssn_type not null,
	primary key(member_id, sno, trainer_ssn)
);

create table pay_sports_fees (
	member_id int not null,
	sno int not null,
	payment_date date not null,
	primary key(member_id, sno, payment_date)
);

create table pay_transports_fees (
	member_id int not null,
	class name_type not null ,
	payment_date date not null,
	primary key(member_id, payment_date)
);
	
create table fees_constants (
	name name_type not null primary key,
	fees int not null
);

alter table pay_transports_fees
add foreign key (class) references transports(class),
	foreign key (member_id) references members(id)

alter table members_phones 
add foreign key (member_id) references members(id)


alter table employees_phones 
add foreign key (employee_ssn) references employees(ssn)

alter table employees_addresses
add foreign key (employee_ssn) references employees(ssn)

alter table trainers
add foreign key (employee_ssn) references employees(ssn) on delete cascade on update cascade

alter table drivers
add foreign key (employee_ssn) references employees(ssn) on delete cascade on update cascade,
	foreign key (bno) references buses(bno)

alter table departments
add foreign key (employee_ssn) references employees(ssn)

alter table buses
add foreign key (class) references transports(class)
 
alter table cash_fees
add foreign key (member_id) references members(id)

alter table installments_fees
add foreign key (member_id) references members(id)

alter table dependents
add foreign key (member_id) references members(id) on delete cascade on update cascade

alter table tickets
add foreign key (member_id) references members(id),
	foreign key (did) references dependents(did)

alter table train
add foreign key (member_id) references members(id),
	foreign key (sno) references sports(sno),
	foreign key (trainer_ssn) references trainers(employee_ssn)

alter table pay_sports_fees
add foreign key (member_id) references members(id),
	foreign key (sno) references sports(sno)

SET DATEFORMAT dmy;
insert into employees
       (ssn,fname,lname,salary,BoD,dno,work_since)
values
       ('002378919','Khaled','Saed',5000,'2/12/1990',1,'2018'), 
       ('013457803','Jihan','Mahmoud',4000,'30/4/1996',1,'2017'),
       ('368457901','Hussien','Allam',4500,'26/3/1998',5,'2020'),
       ('678345160','Abdelrahman','Gaber',3000,'13/5/1997',1,'2018'),
       ('125709865','Naser','Mohammed',3500,'3/8/1999',3,'2020'),
       ('376129808','Hisham','Salah',5000,'14/7/1990', 2 ,'2019'),
       ('679234660','Hassan','Emad',6000,'22/12/1992',5,'2018'),
       ('281546723','Soaad','Amjad',5500,'15/3/1995',5,'2020'),
       ('618209976','Aml','Maged',5000,'22/9/1998',2,'2020'),
      ('460079038','Hazem','Galal',6000,'27/1/2000',4,'2022'),
      ('908006543','Salem','Nassar',5500,'13/8/1999',4,'2021'),
      ('450987124','Zaki','Alaa',4000,'17/10/1993',3,'2018'),
      ('167094150','Marwa','Sleem',3000,'28/2/1997',4,'2020'),
      ('590044680','Samy','Taha',3500,'10/10/2000',1,'2022'),
      ('468911077','Kamel','Saad',5000,'18/6/1993',1,'2018'),
	('890026734', 'Sara', 'Mohamed', 6000, '3/12/1995',6, '2021'),
       ('298001631', 'Mona', 'Kareem', 5500, '4/1/1993',6, '2020'),
       ('870044569', 'Mohesen', 'Alaa', 5900,'12/2/1991',6, '2019'),
       ('140060890', 'Fatma', 'Zeyad', 6000, '22/3/1990',6, '2020'),
       ('090199089', 'Tagreed', 'Taha',6000, '13/11/1985',6, '2021'),
	   ('110238900', 'Yaseen', 'Ahmed', 3500, '13/2/1985',7, '2020'),
       ('389002689', 'Tamer', 'Fathy', 3000,'14/9/1995',7, '2021'),
       ('220300178', 'Mostafa', 'Salah', 3600, '15/11/1985',7, '2019'),
       ('100032346', 'Tarek', 'Ramy', 2900,'16/10/1989',7, '2020'),
       ('390743890', 'Nour', 'Mahmoud', 2400, '23/12/1993',7, '2021')


insert into trainers
        (employee_ssn,medals,experience)
values
       ('890026734', 3, 2),
       ('298001631', 2, 3),
       ('870044569', 1, 4),
       ('140060890', 2, 1),
       ('090199089', 3, 5)

insert into transports values ('VIP', 6000),
							  ('first', 5000),
							  ('second', 4000),
							  ('economy', 3000)


insert into buses (bno , seats , class)
values
(1 , 20 , 'first'),
(2 , 15 , 'VIP'),
(3 , 30 , 'second'),
(4 , 15 , 'VIP'),
(5 , 45 , 'economy'),
(6 , 45 , 'economy'),
(7 , 20 , 'first'),
(8 , 30 , 'second'),
(9 , 30 , 'second'),
(10 , 15 , 'VIP'),
(11 , 30 , 'second'),
(12 , 45 , 'economy'),
(13 , 20 , 'first'),
(14 , 20 , 'first'),
(15 , 15 , 'VIP');


insert into drivers(employee_ssn, bno, drive_since)
values ('110238900', 4, '2022-07-12'),
       ('389002689', 1, '2022-01-22'),
       ('220300178', 3, '2022-01-20'),
       ('100032346', 2, '2022-06-12'),
       ('390743890', 5, '2022-04-16')

insert into departments values  (1, '678345160', 'Accounting & finance', 250000, '12/5/2019'),
								(2, '376129808', 'Administration', 230000, '12/1/2020'),
								(3, '450987124', 'Membership', 199000, '22/8/2020'),
								(4, '167094150', 'Human resources', 171000, '03/04/2021'),
								(5, '368457901', 'Marketing & sales', 360000, '20/02/2021'),
								(6, '870044569', 'train', 360000, '20/02/2022'),
								(7, '220300178', 'drive', 260000, '22/03/2021')


/*alter here*/
alter table employees 
add foreign key (dno) references departments(dno)

insert into sports values(1, 'football', 2300),
						 (2, 'handball', 2500),
						 (3, 'swimming', 4000), 
						 (4, 'volleyball', 3000), 
						 (5, 'tennis', 3200)



insert into members
      (id,fname,lname,BoD,street,no_of_building,date_of_join)
values
      (01,'Ahmed','Ali','25/10/2000','Elhelw',25,'01/01/2019'),
      (02,'Hossam','Tarek','05/09/1999','Saed',14,'02/03/2019'),
      (03,'khaled','Tawfiqe','04/07/2001','Elgalaa',3,'03/06/2020'),
      (04,'Mostafa','Mahmoud','06/08/1998','Elnahas',12,'04/05/2021'),
      (05,'Hanan','Ibrahim','05/11/2002','Ali Mobarak',20,'08/10/2022'),
      (06,'Ghada','Serag','03/12/2000','Elnady',19,'09/09/2020'),
      (07,'Nader','Walid','12/01/2003','Hassan',6,'30/03/2022'),
      (08,'Hana','Hassan','15/10/2001','Ali Bek',18,'14/07/2020'),
      (09,'Gamal','Mahmoud','20/09/1998','Elestad',30,'20/03/2019'),
      (10,'Naira','Saed','11/11/2001','Moheb',3,'23/06/2021'),
      (11,'Rewan','Yasser','21/03/2000','Elashraf',9,'14/05/2020'),
      (12,'Mazen','Samir','18/08/2002','Elmotawakel',13,'28/04/2022'),
      (13,'Youssef','Saleh','30/10/1997','Elhelw',19,'06/12/2019'),
      (14,'Doaa','Soliman','16/03/2000','Elmoatasem',7,'23/04/2020'),
      (15,'Merna','Hamza','29/07/2001','Sedky',15,'19/04/2021');



	  insert into members_phones values(01,'01163245644'),
								 (01,'01034623454'),
								 (02,'01298741024'),
								 (03,'01003030104'),
								 (03,'01255533665'),
								 (04,'01569478525'),
								 (05,'01144120012'),
								 (06,'01511223342'),
								 (06,'01230102053'),
								 (07,'01215141713'),
								 (08,'01219181713'),
								 (09,'01100022333'),
								 (10,'01200302102'),
								 (11,'01001234567'),
								 (12,'01110121510'),
								 (13,'01512101115'),
								 (13,'01236985214'),
								 (14,'01036985214'),
								 (15,'01212121031'),
								 (15,'01500303311');



insert into employees_phones values('678345160','01123231213'),
								   ('376129808','01020010030'),
								   ('376129808','01120010300'),
								   ('450987124','01211121212'),
								   ('450987124','01555001010'),
								   ('167094150','01047896542'),
								   ('368457901','01096325123'),
								   ('002378919','01020963251'),
								   ('013457803','01564282013'),
								   ('013457803','01019988774'),
								   ('678345160','01219988774'),
								   ('125709865','01229988223'),
								   ('125709865','01019530255'),
								   ('281546723','01113278998'),
								   ('618209976','01177069524'),
								   ('460079038','01232564554'),
								   ('908006543','01518855221'),
								   ('908006543','01128852522'),
								   ('590044680','01011885252'),
								   ('468911077','01036147895'),
								   ('110238900', '01036237895'),
									('389002689','01037147895'),
									('220300178', '01036148895'),
									('100032346', '01128852522'),
									('390743890', '01224852522'),
									('890026734','01526852522'),
									('298001631', '01128852522'),
									('870044569', '01029988223'),
									('140060890', '01229088223'),
									('090199089', '01109988423')

insert into employees_addresses values('678345160','tanta','saied'),
									  ('678345160','cairo','omar-abn-elaas'),
									  ('376129808','cairo','omar'),
									  ('376129808','tanta','elhelo'),
									  ('450987124','tanta','ashraf'),
									  ('167094150','tanta','elbahr'),
									  ('368457901','tanta','elsadat'),
									  ('002378919','alex','elcornesh'),
									  ('013457803','matroh','hassan'),
									  ('125709865','tanta','Elnahas'),
									  ('281546723','tanta','Ali Mobarak'),
									  ('281546723','alex','elashraf'),
									  ('618209976','tanta','Elnady'),
									  ('460079038','tanta','Hassan'),
									  ('460079038','cairo','omar-an-elkhtab'),
									  ('908006543','zefta','elbahar'),
									  ('590044680','zefta','ahmed maher'),
									  ('468911077','tanta','Elestad'),
									  ('110238900', 'tanta','saied'),
									   ('389002689','zefta','elbahar'),
									   ('220300178', 'tanta','saied'),
									   ('100032346', 'zefta','elbahar'),
									   ('390743890', 'tanta','saied'),
									   ('890026734','tanta','Elnahas'),
									   ('298001631', 'tanta','Ali Mobarak'),
									   ('870044569', 'tanta','Elnahas'),
									   ('140060890', 'tanta','Ali Mobarak'),
									   ('090199089', 'tanta','Ali Mobarak')





insert into cash_fees
        (payment_date,member_id)
values
       ('2022-02-01', 01),
       ('2022-02-13', 02),
       ('2022-05-10', 03),
       ('2022-06-03', 04),
       ('2022-04-06', 05),
       ('2022-06-08', 06),
       ('2022-06-08', 07)


insert into fees_constants (name, fees)
				values('cash', 120000),
					  ('installment', 10000),
					  ('ticket', 40 )

--id:12->5
insert into installments_fees
        (payment_date, member_id)
values
       ('2022-01-01' ,08),
       ('2022-01-05' ,09),
       ('2022-01-28' ,10),
       ('2022-01-01' ,11),
       ('2022-01-06' ,13),
       ('2022-01-09' ,14),
       ('2022-01-03' ,15),
       ('2022-02-01' ,08),
       ('2022-02-05' ,09),
       ('2022-02-28' ,10),
       ('2022-02-01' ,11),
       ('2022-02-06' ,13),
       ('2022-02-09' ,14),
       ('2022-02-03' ,15),
	   ('2022-03-01' ,08),
       ('2022-03-05' ,09),
       ('2022-03-28' ,10),
       ('2022-03-01' ,11),
       ('2022-03-06' ,13),
       ('2022-03-09' ,14),
       ('2022-03-03' ,15),
	   ('2022-04-01' ,08),
       ('2022-04-05' ,09),
       ('2022-04-28' ,10),
       ('2022-04-01' ,11),
       ('2022-04-06' ,13),
       ('2022-04-09' ,14),
       ('2022-04-03' ,15),
	   ('2022-05-01' ,08),
       ('2022-05-05' ,09),
       ('2022-05-28' ,10),
       ('2022-05-01' ,11),
       ('2022-05-28' ,12),
       ('2022-05-06' ,13),
       ('2022-05-09' ,14),
       ('2022-05-03' ,15)


insert into pay_transports_fees
        (member_id,class,payment_date)
values
        (01,'VIP','2022-07-12'),
        (02,'VIP','2022-04-15'),
        (03,'first','2022-09-12'),
        (04,'first','2022-03-10'),
        (06,'second','2022-12-01'),
        (07,'second','2022-11-13'),
        (08,'economy','2022-06-01'),
        (09,'second','2022-04-20'),
        (11,'economy','2022-12-20'),
        (12,'economy','2022-05-05'),
        (13,'second','2022-01-13')

insert into pay_sports_fees
        (member_id,sno,payment_date)
values
        (01, 01,'2022-07-11'),
        (02, 01,'2022-03-18'),
        (03, 05,'2022-09-01'),
        (04, 03,'2022-03-10'),
        (07, 01,'2022-01-12'),
        (08, 02,'2022-06-01'),
        (09, 05,'2022-04-15'),
        (10, 04,'2022-04-20'),
        (11, 03,'2022-12-11'),
        (13, 04,'2022-01-13'),
        (14, 01,'2022-09-10'),
        (15, 03,'2022-07-08')

insert into  dependents (did , fname , lname , member_id)
values
      (01 , 'Mohamed', 'Ali' , 01),
      (02 , 'Adel' , 'Magdy' , 08),
      (03 , 'Yousef' , 'Khaled' , 12),
      (04 , 'Nadin' , 'Mahmoud' , 01),
      (05 , 'Afnan' , 'Osama' , 07),
      (06 , 'Ebrahim' , 'Soliman' , 02),
      (07 , 'Sandy' ,'Alaa' , 02),
      (08 , 'Ayman' , 'Mustafa' , 15),
      (09 , 'Mahmoud' , 'Amer' , 13),
      (10 , 'Salma' , 'Gamal' , 08),
      (11 , 'Aseel' , 'Ahmed' , 09),
      (12 , 'Gehan' , 'Nasr' , 15),
      (13 , 'Nour' , 'Shreif' , 01),
      (14 , 'Omar' , 'Abdelaziz' , 05),
      (15 , 'Soha' , 'Amir' , 07)

insert into tickets (did, member_id ,payment_date)
values  
     (01 , 01 , '20-11-2019'),
     (02 , 08 , '10-6-2021'),
     (03 , 12 , '6-8-2022'),
     (04 , 01 , '20-11-2019'),
     (05 , 07 , '10-9-2022'),
     (06 , 02 , '5-1-2022'),
     (07 , 02 , '11-2-2022'),
     (08 , 15 , '4-12-2021'),
     (09 , 13 , '8-8-2020'),
     (10 , 08 , '3-5-2021'),
     (11 , 09 , '7-10-2020'),
     (12 , 15 , '6-8-2022'),
     (13 , 01 , '1-12-2022'),
     (14 , 05 , '1-12-2022'),
     (15 , 07 , '10-9-2022')


insert into  train (member_id , sno , trainer_ssn)
values(10 , 4 , '090199089'),
      (13 , 4 , '090199089'),
      (15 , 3 , '140060890'),
      (11 , 3 , '140060890'),
      (04 , 3 , '140060890'),
      (08 , 2 , '298001631'),
      (03 , 5 , '870044569'),
      (09 , 5 , '870044569'),
	  (01 , 1 , '890026734'),
	  (02 , 1 , '890026734'),
	  (07 , 1 , '890026734'),
	  (14 , 1 , '890026734')