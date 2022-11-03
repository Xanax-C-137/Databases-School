drop database if exists business;

create database if not exists business;

use business;

drop table if exists articlegroup;

create table if not exists articlegroup(
argr_id int auto_increment primary key,
argr_name varchar(45));

insert into articlegroup values
	(null,"Kamera"),
    (null,"Monitor"),
    (null,"Leinwand");

drop table if exists producer;

create table if not exists producer(
pro_id  int auto_increment primary key,
pro_name varchar(45) not null);

insert into producer values
	(null,"Canon"),
    (null,"Dell"),
    (null,"Elite Screens");


drop table if exists article;

create table if not exists article(
art_id  int auto_increment primary key,
art_name1 varchar(45) not null,
art_name2 varchar(45),
argr_id int not null,
pro_id int not null,
foreign key (argr_id) references articlegroup(argr_id)
		on delete cascade on update cascade,
foreign key (pro_id) references producer(pro_id)
		on delete cascade on update cascade);

insert into article values
	(null,"EOS 2000D", null, 1,1),
	(null,"P2419H", null, 2,2),
    (null,"Saker", null, 3,3),
    (null,"EOS R6", null, 1,1),
    (null,"PowerShot G7", "MarkII", 1,1),
    (null,"Ixus 190", null, 1,1);
show databases;

show tables;

select * from producer;

select argr_name from articlegroup;

select pro_name, pro_id from producer;

select art_name1 as "Artikelbezeichnung1", art_name2 as "Artikelbezeichnung2" from article;