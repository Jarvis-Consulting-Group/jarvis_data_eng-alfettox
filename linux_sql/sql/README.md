# Giovanni De Franceschi

![This is an image](https://pgexercises.com/img/schema-horizontal.svg)

# run docker container

# run psql instance

# create a DATABASE named exercises

# switch to the database exercixes
\c exercises

# create a schema called cd
CREATE SCHEMA cd;

#switch to the schema cd
SET search_path = cd;



# CREATE A TABLE MEMBERS
    CREATE TABLE cd.members
    (
       memid integer NOT NULL, 
       surname character varying(200) NOT NULL, 
       firstname character varying(200) NOT NULL, 
       address character varying(300) NOT NULL, 
       zipcode integer NOT NULL, 
       telephone character varying(20) NOT NULL, 
       recommendedby integer,
       joindate timestamp NOT NULL,
       CONSTRAINT members_pk PRIMARY KEY (memid),
       CONSTRAINT fk_members_recommendedby FOREIGN KEY (recommendedby)
            REFERENCES cd.members(memid) ON DELETE SET NULL
    );

#CREATE TABLE FACILITIES
 CREATE TABLE cd.facilities
    (
       facid integer NOT NULL, 
       name character varying(100) NOT NULL, 
       membercost numeric NOT NULL, 
       guestcost numeric NOT NULL, 
       initialoutlay numeric NOT NULL, 
       monthlymaintenance numeric NOT NULL, 
       CONSTRAINT facilities_pk PRIMARY KEY (facid)
    );

#CREATE TABLE BOOKINGS
  CREATE TABLE cd.bookings
    (
       bookid integer NOT NULL, 
       facid integer NOT NULL, 
       memid integer NOT NULL, 
       starttime timestamp NOT NULL,
       slots integer NOT NULL,
       CONSTRAINT bookings_pk PRIMARY KEY (bookid),
       CONSTRAINT fk_bookings_facid FOREIGN KEY (facid) REFERENCES cd.facilities(facid),
       CONSTRAINT fk_bookings_memid FOREIGN KEY (memid) REFERENCES cd.members(memid)
    );

#ADD A LINE IN FACILITIES TABLES
INSERT INTO facilities(facid,Name,membercost,guestcost,initialoutlay,monthlymaintenance) VALUES (9,'Spa',20,30,100000,800);

#CREATE A SEQUENCE
CREATE SEQUENCE facilities_facid_seq START 10;

#ADD A LINE WITHOUT SPECIFYING AUTOINCREMENT ID VALUE
ALTER TABLE facilities ALTER COLUMN facid SET DEFAULT nextval('facilities_facid_seq');

#UPDATE TABLE
UPDATE facilities SET initialoutlay = 10000 WHERE facid='1' ;

#SUBQUERY UPDATE
update facilities set membercost =(
select membercost *1.1 FROM facilities where facid='0') WHERE facid='1';

update facilities set guestcost =(
select guestcost *1.1 FROM facilities where facid='0') WHERE facid='1';


#DELETE ALL BOOKINGS
DELETE FROM bookings;

#DELETE MEMBER 37
DELETE FROM members WHERE memid='37';


#How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the facilities in question.
exercises=# select facid, name, membercost, monthlymaintenance from facilities where membercost >0 AND membercost < monthlymaintenance /50;


#How can you produce a list of all facilities with the word 'Tennis' in their name?
exercises=# select * from facilities where name like '%Tennis%'
exercises-# ;

#How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.
select * from facilities where in (1,5);

#How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, firstname, and joindate of the members in question.
exercises=# select * from members where joindate > '2012-09-01'

#You, for some reason, want a combined list of all surnames and all facility names. Yes, this is a contrived example :-). Produce that list!

#union of surnames from members table and facilities names
SELECT surname
FROM members
UNION
SELECT name
FROM facilities;



# List of the start times for bookings by members named 'David Farrell'? 
SELECT b.starttime
FROM bookings AS b
INNER JOIN members AS m ON b.memid = m.memid AND m.firstname = 'David' AND m.surname = 'Farrell';


#JOIN EXAMPLE
SELECT b.starttime as start, f.name
FROM bookings as b
INNER JOIN facilities as f ON b.facid = f.facid
WHERE date = '2012-09-21';

#How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time. 
select b.starttime as start, f.name as name
from facilities f
inner join bookings b
on f.facid = b.facid
where 
f.name in ('Tennis Court 2','Tennis Court 1')
AND
b.starttime >= '2012-09-21' AND b.starttime < '2012-09-22'
ORDER BY b.starttime;   



# SELF join example
#How can you output a list of all members, including the individual who recommended them (if any)? Ensure that results are ordered by (surname, firstname).


SELECT 
  mems.firstname as memfname, 
  mems.surname as memsname, 
  recs.firstname as recfname, 
  recs.surname as recsname 
from 
  cd.members mems 
  left outer join cd.members recs on recs.memid = mems.recommendedby 
order by 
  memsname, 
  memfname;


#How can you output a list of all members who have recommended another member? Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).

select 
  distinct recs.firstname as firstname, 
  recs.surname as surname 
from 
  cd.members mems 
  inner join cd.members recs on recs.memid = mems.recommendedby 
order by 
  surname, 
  firstname;


#How can you output a list of all members, including the individual who recommended them (if any), without using any joins? Ensure that there are no duplicates in the list, and that each firstname + surname pairing is formatted as a column and ordered.

SELECT DISTINCT mems.firstname || ' ' || mems.surname AS member,
       (SELECT recs.firstname || ' ' || recs.surname
        FROM cd.members recs
        WHERE recs.memid = mems.recommendedby) AS recommender
FROM cd.members mems
ORDER BY member;

# TO BE COMPLETED WITH AGGREGATION PART
#
#How can you produce a list of the start times for bookings by members named 'David Farrell'?

#How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time.

#How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? Return a list of start time and facility name pairings, ordered by the time.

#How can you output a list of all members, including the individual who recommended them (if any)? Ensure that results are ordered by (surname, firstname).

#How can you output a list of all members who have recommended another member? Ensure that there are no duplicates in the list, and that results are ordered by (surname, firstname).

#How can you output a list of all members, including the individual who recommended them (if any), without using any joins? Ensure that there are no duplicates in the list, and that each firstname + surname pairing is formatted as a column and ordered.






#
#

#Output the names of all members, formatted as 'Surname, Firstname'
select CONCAT(firstname, ' ', surname) AS NAME
from members;

#You've noticed that the club's member table has telephone numbers with very inconsistent formatting. You'd like to find all the telephone numbers that contain parentheses, returning the member ID and telephone number sorted by member ID.
select memid, telephone
from members
where telephone like '%(%' OR telephone like '%)%';

#You'd like to produce a count of how many members you have whose surname starts with each letter of the alphabet. Sort by the letter, and don't worry about printing out a letter if the count is 0.
select 
  substr(m.surname, 1, 1) as letter, 
  count(*) as count 
from 
  members as m 
group by 
  letter 
order by 
  letter;





