-- Yao Shi
-- Databases practical 1


-- Q1
select student.sname, t.grade from student,
(select enroll.* from enroll, course where cname = 'Thermodynamics' and enroll.cno = course.cno) as t where student.sid = t.sid;

--         sname        | grade 
-- ---------------------+-------
--  Jacobs, T.          |     3
--  Borchart, Sandra L. |     3
--  June, Granson       |     3
--  Villa-lobos, M.     |   3.5
--  Starry, J.          |   2.5
--  Bates, M.           |     2
--  Andermanthenol, K.  |     4
-- (7 rows)


-- Q2
select c.cname, t.pname from
(select e.sid, e.cno, e.dname, s.pname from enroll e left join section s on
e.dname = s.dname and e.cno = s.cno and e.sectno = s.sectno
where e.sid = 16) as t
left join course c on  c.cno = t.cno and c.dname = t.dname;

--           cname           |   pname   
-- --------------------------+-----------
--  Intro to Programming     | Smith, S.
--  Intro to Programming     | Jones, J.
--  Intro to Data Structures | Jones, J.
--  Compiler Construction    | Clark, E.
-- (4 rows)


-- Q3
select distinct m.dname from student s, major m where s.age < 19 and m.sid = s.sid;
--          dname          
-- ------------------------
--  Mathematics
--  Civil Engineering
--  Industrial Engineering
--  Computer Sciences
--  Chemical Engineering
-- (5 rows)


-- Q4
select course.cname, x.sectno from
(select * from 
(select cno, sectno, count(*) from enroll group by cno, sectno) t where t.count < 12) x
left join course on course.cno = x.cno;
--           cname           | sectno 
-- --------------------------+--------
--  Intro to Programming     |      1
--  Intro to Programming     |      2
--  Thermodynamics           |      1
--  Intro to Garbage         |      1
--  City Planning            |      1
--  Highway Engineering      |      1
--  College Geometry 1       |      1
--  College Geometry 2       |      1
--  Intro to Data Structures |      1
--  Manpower Utilization     |      1
-- (10 rows)


-- Q 2.1
/*Before the insertion*/
-- select * from prof;
--     pname     |         dname          
-- --------------+------------------------
--  Brian, C.    | Computer Sciences
--  Brown, S.    | Civil Engineering
--  Bucket, T.   | Sanitary Engineering
--  Clark, E.    | Civil Engineering
--  Edison, L.   | Chemical Engineering
--  Jones, J.    | Computer Sciences
--  Randolph, B. | Civil Engineering
--  Robinson, T. | Mathematics
--  Smith, S.    | Industrial Engineering
--  Walter, A.   | Industrial Engineering
-- (10 rows)

/*Query used to insert*/
INSERT INTO prof(pname, dname) values('Benedikt, M.','Computer Sciences');

/*Test the insertion*/
-- select * from prof;
--     pname     |         dname          
-- --------------+------------------------
--  Brian, C.    | Computer Sciences
--  Brown, S.    | Civil Engineering
--  Bucket, T.   | Sanitary Engineering
--  Clark, E.    | Civil Engineering
--  Edison, L.   | Chemical Engineering
--  Jones, J.    | Computer Sciences
--  Randolph, B. | Civil Engineering
--  Robinson, T. | Mathematics
--  Smith, S.    | Industrial Engineering
--  Walter, A.   | Industrial Engineering
--  Benedikt, M. | Computer Sciences
-- (11 rows)


-- Optional
-- (People only take classes with the size of 10+) = 
-- (people with class size of 10+) - (peole with class size of 10 or less)
select e1.sid from enroll e1, 
(select * from
(select cno, sectno, count(*) from enroll group by cno, sectno) t where t.count > 10) as c
where e1.cno = c.cno and e1.sectno = c.sectno
except
select e2.sid from enroll e2, 
(select * from
(select cno, sectno, count(*) from enroll group by cno, sectno) t1 where t1.count <= 10) as c1
where e2.cno = c1.cno and e2.sectno = c1.sectno;

--  sid 
-- -----
--   64
--    2
--   62
--   75
--   23
--  103
--   44
--    8
--   99
--   87
--   42
--   71
--   68
--   82
--   34
--   51
--   41
--   46
--   80
--   70
--   83
--   32
--   63
--   10
--    7
--  100
--   84
--   48
--   72
--   39
--   92
--   81
--   61
--   89
--   77
--   25
--   31
--   60
--   20
-- (39 rows)
