#proyek
drop database smarthome;
create database smarthome;
use smarthome;
set sql_safe_updates = 0;
create table user_type
(
	ID int not null auto_increment,
    type_name varchar(100),
    guest_mode enum('YES', 'NO'),
    change_mode enum('YES', 'NO'),
    AC enum('YES', 'NO'),
    lights enum('YES', 'NO'),
    music enum('YES', 'NO'),
    send_username_password enum('YES', 'NO'),
    guest_mode_dependent enum('YES', 'NO'),
    automatic_dependent enum('YES', 'NO'),
    primary key(ID)
);
create table User
(
	ID int not null auto_increment,
    email varchar(100),
    username varchar(100),
    password varchar(100),
    user_type int,
    primary key(ID),
    foreign key(user_type) references user_type(ID)
);
create table Home
(
	ID int not null auto_increment,
    Address varchar(100),
    Time timestamp default current_timestamp,
    Automatic enum('ON', 'OFF'),
    GuestMode enum('ON', 'OFF'),
    primary key(ID)
);
create table user_home
(
	id_user int,
    id_home int,
    foreign key(id_user) references User(ID),
    foreign key(id_home) references Home(ID)
);
create table Room
(
	ID int not null auto_increment,
    Id_home int,
    room_type varchar(100),
    time_start time,
    time_end time,
    primary key(ID),
    foreign key(Id_home) references Home(ID)
);
create table Electronics_types
(
	ID int not null auto_increment,
    type varchar(100),
    primary key(ID)
);

create table Electronics
(
	ID int not null auto_increment,
    room_id int,
    type_id int,
    on_off enum('ON', 'OFF'),
    changed_by enum('AI', 'USER'),
    Time timestamp not null default current_timestamp,
    primary key(ID),
    foreign key(room_id) references Room(ID),
    foreign key(type_id) references Electronics_types(ID)
);

create table Electronics_history
(
	ID int not null auto_increment,
    electronic_id int,
    on_off enum('ON', 'OFF'),
    changed_by enum('AI', 'USER'),
    Time timestamp,
    primary key(ID),
    foreign key(electronic_id) references Electronics(ID)
);

create table Sensor_types
(
	ID int not null auto_increment,
    type varchar(100),
    primary key(ID)
);

create table Sensor
(
	ID int not null auto_increment,
    id_room int,
    type_id int,
    data int,
    primary key(ID),
    foreign key(id_room) references Room(ID),
    foreign key(type_id) references Sensor_types(ID)
);

#contoh data

insert into user_type(type_name, guest_mode, change_mode, AC, lights, music, send_username_password, guest_mode_dependent, automatic_dependent)
 values('Parent', 'YES', 'YES', 'YES', 'YES', 'YES', 'NO', 'NO', 'NO'),
('Admin','NO', 'NO', 'NO', 'NO', 'NO', 'YES', 'NO', 'NO'),
('Children','NO', 'NO', 'YES', 'YES', 'YES', 'NO', 'NO', 'NO'),
('Guest', 'NO', 'NO', 'YES', 'YES', 'YES', 'NO', 'YES', 'NO'),
('Apps', 'NO', 'NO', 'YES', 'YES', 'YES', 'NO', 'NO', 'YES');

insert into User(email, username, password, user_type) 
values('LekaPetra@gmail.com', 'Petra', 'Petrakeren69', '3'),
('MiYauw@gmail.com', 'Mikha', 'Myauw77', '1'),
('IamWesley@gmail.com', 'Wesley', 'HakimWesley', '2'),
('HeyYou!IamVio@gmail.com', 'Delivio', 'SayaSukaWaria', '4'),
('apps@gmail.com', 'Apps', '123456', '5');

insert into Home(Address, Automatic, GuestMode) values('Jalan burung pipit nomor 3 Jogja', 'ON', 'OFF'),
('Jln Burung Perkasa Jakarta', 'OFF', 'ON');
insert into Room(Id_home, room_type, time_start, time_end) values(1, 'Bedroom', '22:00:00', '06:00:00');
insert into Room(Id_home, room_type) values(1, 'Bathroom'),
(1, 'Living Room'),
(1, 'Kitchen');

insert into Room(Id_home, room_type, time_start, time_end) values(2, 'Bedroom', '22:00:00', '06:00:00');
insert into Room(Id_home, room_type) values(2, 'Bathroom'),
(2, 'Living Room'),
(2, 'Kitchen');
insert into Electronics_types(type)
values('AC'),('Lamps'),('Speaker');
insert into Electronics(room_id, type_id, on_off, changed_by) 
values(1, 2, 'OFF', 'AI'),
(2, 2, 'OFF', 'AI'),(3,2, 'OFF', 'AI'),(4,2, 'OFF', 'AI'),(5, 2, 'OFF', 'AI'),(6, 2, 'OFF', 'AI'),(7, 2, 'OFF', 'AI'),
(8, 2, 'OFF', 'AI'),(1, 3, 'OFF', 'AI'),(2, 3, 'OFF', 'AI'),(3, 3, 'OFF', 'AI'),(4, 3, 'OFF', 'AI'),(5, 3, 'OFF', 'AI'),
(6, 3, 'OFF', 'AI'),(7, 3, 'OFF', 'AI'),(8, 3, 'OFF', 'AI'),(1, 1, 'OFF', 'AI'),(3, 1, 'OFF', 'AI'),(4, 1, 'OFF', 'AI'),(5, 1, 'OFF', 'AI'),
(7, 1, 'OFF', 'AI'),(8, 1, 'OFF', 'AI');
insert into Electronics_history(electronic_id, on_off, changed_by, Time)
values(3, 'ON', 'USER', '2022-08-12 02:00:08'),
(2, 'ON', 'USER', '2022-06-12 02:03:04'),(4, 'ON', 'USER', '2022-08-12 12:00:08'),
(1, 'OFF', 'AI', '2022-08-12 10:00:08'),(5, 'OFF', 'AI', '2022-08-12 10:00:08'),
(17, 'ON', 'AI', '2022-08-11 11:00:08'), (18, 'ON', 'AI', '2022-08-12 11:05:08'),
(14, 'ON', 'USER', '2022-08-12 02:00:08'), (15, 'ON', 'AI', '2022-08-12 02:00:08'),
(14, 'OFF', 'USER', '2022-08-12 08:00:08');
insert into Sensor_types(type)
values('Light Sensor'),('People Sensor'),('Temperature Sensor');
insert into Sensor(id_room, type_id, data) values(1, 1, 1500),(2, 1, 0), (3, 1, 1200), (4, 1, 1500),
(5, 1, 1500),(6, 1, 0), (7, 1, 1200), (8, 1, 1500),(1, 2, 1),(2, 2, 0), (3, 2, 1), (4, 2, 0),
(5, 2, 1),(6, 2, 0), (7, 2, 1), (8, 2, 0), (1, 3, 24), (2, 3, 23), (3, 3, 24), (4, 3, 24),
(5, 3, 24), (6, 3, 24), (7, 3, 24), (8, 3, 24);
 insert into user_home(id_user, id_home) values(1, 1),(2, 1), (3, 1), (4, 1), (5, 1), (1, 2), (2, 2), (3, 2), (4, 2), (5, 2);


select * from Sensor_types;
select * from user_type;
select * from Sensor;
select * from Electronics_types;
select * from Electronics;
select * from Electronics_history;
select * from Room;
select * from user_home;
select * from User;
select * from Home;

start transaction;
update Home set Automatic = 'OFF',
				GuestMode = 'ON'
where ID = 1;
commit;

select * from Home;

start transaction;
update Electronics set on_off = 'ON', changed_by = 'USER'
where ID = 1;
update Electronics set on_off = 'ON', changed_by = 'USER'
where ID = 8;
update Electronics set on_off = 'ON', changed_by = 'USER'
where ID = 6;
commit;

select * from Electronics;

start transaction;
update Home set Automatic = 'ON',
				GuestMode = 'OFF'
where ID = 2;
commit;

select * from Home;

start transaction;
update Electronics set on_off = 'ON', changed_by = 'USER'
where ID = 2;
update Electronics set on_off = 'ON', changed_by = 'USER'
where ID = 10;
update Electronics set on_off = 'ON', changed_by = 'USER'
where ID = 12;
commit;

select * from Electronics;