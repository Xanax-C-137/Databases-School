-- Copyright 2022 Moritz Füssel
-- Select-Satements
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

-- Alle DS einer Tabelle
select	*
from 	person;
/* Anmerkung:	* ist ein Joker-Zeichen, nach Select dient
				er zur Auswahl aller Attribute/Spalten
*/
-- a) Nur die Nachnamen einer Person ausgeben
select	per_nname
from person;

-- b) Vor- und Nachname einer Person
select	per_nname, per_vname
from	person;

-- c) Alias für Spaltenbezeichnung
select	per_nname as "Nachname einer Person",
		per_vname as "Vorname"
from person;

-- d) Tabellenbezeichnung explizit dem Attribut voranstellen
select	person.per_nname as "Nachname",
		person.per_vname as "Vorname"
from	person;

-- e) Alias für Tabelle
select	p.per_nname as "Nachname"
from	person p;

-- f) Alle funktionen ausgeben, Alias für Attribut und Entity verwenden
select	f.fun_name as "Funktion"
from	funktion f;

-- WHERE-Klause
-- LIKE
-- g) Alle Personen deren Vorname mit C beginnt
select	per_vname,
		per_nname
from	person
where	per_vname LIKE 'C%';
-- % in Like: Joker für eine belibige Anzahl belibiger Zeichen

-- h) Alle Personen deren Vorname an zweiter Stelle ein h enthällt
select	per_vname,
		per_nname
from	person
where	per_vname LIKE '_h%';

-- i) Aufgabe: alle Personen deren Vorname an vorletzter Stelle ein e enthält
select	per_vname,
		per_nname
from	person
where	per_nname LIKE '%e_';

-- WHERE AND OR
-- j) Personen mit Nachname erster Buchstabe H oder S
select	per_vname,
		per_nname
from	person
where	per_nname LIKE 'h%'
or		per_nname LIKE 's%';

-- k) Aufgabe: Personen mit Nachname zweiter Buchstabe u und Vorname letzter Buchstabe a
select	per_vname,
		per_nname
from	person
where	per_nname LIKE '_u%'
and		per_vname LIKE '%a';


-- db firma
-- joins usw.
use firma;

-- a) Alle Personen mit Funktion(nur ID)
-- Inner Joins
-- Equi Join - der Join mit der Where-Klausel
-- Grundlage dieses Joins ist ein Cross-Join
select	p.* , pf.fun_id
from	person p, person_funktion pf;

-- b) mit Where-Klausel (Equi)
select	p.* , pf.fun_id
from	person p, person_funktion pf
where	p.per_id = pf.per_id;

-- INNER JOIN
-- a) mit INNER JOIN
select	p.* , pf.fun_id
from	person p inner join person_funktion pf using(per_id);

-- using: kann nur verwendet werden wenn, PK und FK die gleiche
--        Bezeichnung haben
-- a) mit inner join und ON
select	p.* , pf.fun_id
from	person p inner join person_funktion pf
on		p.per_id = pf.per_id;

-- NATURAL JOIN
-- Achtung: verglichen werden ALL Attribute mit gleicher
--          Bezeichnung ALLER in from angegebenen Tabellen
select	p.* , pf.fun_id
from	person p natural join person_funktion pf;

-- b) Alle Personen mit Funktionsbezeichnung
-- mit Where-Klausel
select	p.*, f.*
from	person p, person_funktion pf, funktion f
where	p.per_id = pf.per_id
and		f.fun_id = pf.fun_id;
-- mit INNER JOIN
select	p.*, f.*
from	person p inner join person_funktion using(per_id)
		inner join funktion f using(fun_id);
-- inner join N:M kürzere Schreibweise
select	p.*, f.*
from	person_funktion inner join (person p, funktion f)
		using(per_id,fun_id);
-- mit natural join
select	p.*, f.*
from	person_funktion natural join (person p, funktion f);

-- **************************
-- Funktionen
-- **************************
-- count
select	count(*)
from	person;

/* Einschub: Tabellen um Datensätze erweitern */
insert into person (per_nname, per_vname) values
('Urban', 'Klaus'),('Zauner', 'Ulla'),('Weber', 'Karin');
insert into person_funktion (per_id, fun_id) values
(4,3),(5,3);
select * from person;
select * from person_funktion;
/* ****************************************** */
-- concat oder concat_ws
-- c) Alle Personen und Funktionsbezeichnung, Vor- und Nachname in einer
--    Spalte ausgeben
--    Spaltenalias: Person | Funktion
select	concat(per_vname, ' ', per_nname, ' - ', per_id) as "Person",
		fun_name as "Funktion"
from	person_funktion natural join (person, funktion);
-- c) mit concat_ws
select	concat_ws(' ', per_vname, per_nname) as "Person",
		fun_name as "Funktion"
from	person_funktion natural join (person, funktion);

-- Aufgabe: Person und Funktionsbezeichnung in einer Spalte
--          ausgeben, setzen Sie verschiedene Trennzeichen
--          verwenden Sie Equi-Join
select	concat(p.per_vname, ' ', p.per_nname, ' - ', f.fun_name) as "Person"
from	person p, person_funktion pf, funktion f
where	p.per_id = pf.per_id
and		pf.fun_id = f.fun_id;

-- HAVING-Klausel
-- und Group By
-- wird im Zusammenhang mit Funktionen verwendet
-- Anzahl der Personen je Funktion
select	fun_name as "Funktion",
		count(per_id) as "Anzahl der Personen"
from	person_funktion natural join funktion
group by fun_name;
-- Alias bei group by funktioniert nur, wenn er keine Sonderzeichen
-- enthält. Es ist nicht möglich einen "String" anzugeben.
-- Attributbezeichnung kann immer verwendet werden

-- Nur bei Funktionen ausgeben, die mehr als einer Person zugeordnet sind
select	fun_name as "Funktion",
		count(per_id) as "Anzahl der Personen"
from	person_funktion natural join funktion
group by fun_name
having count(per_id) > 1;

-- ORDER BY
-- Alle Personen sortiert nach Nachname
select	*
from	person
order by per_nname;

-- Alle Personen sortiert nach Nachname und (innerhalb) Vorname.
select	*
from	person
order by per_nname, per_vname;

-- Default: aufsteigende Sortierung
-- Auf- oder absteigend sortieren: explizit angeben
select	*
from	person
order by per_nname asc, per_vname asc;
-- ASC: aufsteigend
-- DESC: absteigend
select	*
from	person
order by per_nname desc, per_vname asc;

-- LIMIT
-- einen oder mehrere Ergebnisdatensätze ausgeben
-- z.B. limit 0, 4: ab (einschließlich) 1.Datensatz(DS) vier DS ausgeben
select	*
from	person
limit	0,4;

-- Aufgabe: Alle Personen inkl. Funktion(sbezeichnung), sortiert
--			nach Funktion und dann Nachname. Geben Sie den 3. Datensatz
--			aus. Verwenden Sie Attributalias.
select	concat(p.per_vname, " ", p.per_nname) as "Person", f.fun_name as "Funktion"
from	person p, person_funktion pf, funktion f
where	p.per_id = pf.per_id
order by f.fun_name desc, p.per_nname asc
limit	2,1;