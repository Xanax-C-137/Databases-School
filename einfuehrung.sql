-- Moritz Füssel, 15.09.22
/* Erste Übung zu MariaDB
   bzw. MySQL */
   # auch ein Kommentar
show databases;

/*	DB und Tabellen erstellen
	DB firma */

-- DB löschen falls vorhanden
drop database if exists firma;

-- DB erstellen
create database firma;

-- DB Benutzen
use firma;

-- Tabelle löschen falls vorhanden
drop table if exists person;

-- Tabellen erstellen
create table person(per_id int primary key auto_increment,
	per_nname varchar(255) not null,
	per_vname varchar(255) not null);
    
-- alle Tabellen anzeigen
show tables;

-- Datensätze einfügen
insert into person values(null, 'Huber', 'Christa');
insert into person (per_nname,per_vname) values
	('Schmidt', 'Christian'), ('Maier','Florian');
    
-- SQL-Statement zur Ausgabe aller DS in einer Tabelle
select * from person;

-- Tabelle funktion (die Funktion einer Person in der Firma)
-- Attribute: fun_id int PK auto befüllen, fun_name varchar(100) Pflicht
drop table if exists funktion;

create table funktion(fun_id int primary key auto_increment,
	fun_name varchar(100) not null);

insert into funktion values(null, 'VerkaufsleiterIn'),
	(null, 'DirektorIn'), (null, 'Bürofachpersonal');

select * from funktion;

-- person zu funktion N:M
-- Zwischentabelle erstellen: person_funktion
drop table if exists person_funktion;

create table person_funktion(
	pefu_id int primary key auto_increment,
	per_id int not null,
    fun_id int not null,
    foreign key (per_id) references person(per_id)
		on delete cascade on update cascade,
	foreign key (fun_id) references funktion(fun_id)
		on delete cascade on update cascade);
        
show create table person_funktion;
-- DS person_funktion
insert into person_funktion (per_id, fun_id) values
	(1,3),(2,1),(3,2);
    
select * from person_funktion;