-- --------------------------------------------------------
--
-- Creación de bd_movies
--

DROP DATABASE IF EXISTS bd_movies;
CREATE DATABASE bd_movies;
USE bd_movies;


-- --------------------------------------------------------
--
-- Tabla `actor`
--

DROP TABLE IF EXISTS actor;
CREATE TABLE actor (
  act_id int NOT NULL,
  act_fname varchar(10) NOT NULL,
  act_lname varchar(10) NOT NULL,
  act_gender varchar(6) NOT NULL,
  PRIMARY KEY (act_id)
) ENGINE=InnoDB;

--
-- Carga datos tabla `actor`
--

INSERT INTO actor VALUES
    (101,'James','Stewart','M'),
    (102,'Deborah','Kerr','F'),
    (103,'Peter','OToole','M'),
    (104,'Robert','De Niro','M'),
    (105,'F. Murray','Abraham','M'),
    (106,'Harrison','Ford','M'),
    (107,'Nicole','Kidman','F'),
    (108,'Stephen','Baldwin','M'),
    (109,'Jack','Nicholson','M'),
    (110,'Mark','Wahlberg','M'),
    (111,'Woody','Allen','M'),
    (112,'Claire','Danes','F'),
    (113,'Tim','Robbins','M'),
    (114,'Kevin','Spacey','M'),
    (115,'Kate','Winslet','F'),
    (116,'Robin','Williams','M'),
    (117,'Jon','Voight','M'),
    (118,'Ewan','McGregor','M'),
    (119,'Christian','Bale','M'),
    (120,'Maggie','Gyllenhaal','F'),
    (121,'Dev','Patel','M'),
    (122,'Sigourney','Weaver','F'),
    (123,'David','Aston','M'),
    (124,'Ali','Astin','F');

-- --------------------------------------------------------

--
-- Tabla `director`
--

DROP TABLE IF EXISTS director;
CREATE TABLE director (
  dir_id int NOT NULL,
  dir_fname varchar(20) NOT NULL,
  dir_lname varchar(20) NOT NULL,
  PRIMARY KEY (dir_id)
) ENGINE=InnoDB;

--
-- Carga datos tabla `director`
--

INSERT INTO director (dir_id, dir_fname, dir_lname) VALUES
    (201,'Alfred','Hitchcock'),
    (202,'Jack','Clayton'),
    (203,'David','Lean'),
    (204,'Michael','Cimino'),
    (205,'Milos','Forman'),
    (206,'Ridley','Scott'),
    (207,'Stanley','Kubrick'),
    (208,'Bryan','Singer'),
    (209,'Roman','Polanski'),
    (210,'Paul','Thomas Anderson'),
    (211,'Woody','Allen'),
    (212,'Hayao','Miyazaki'),
    (213,'Frank','Darabont'),
    (214,'Sam','Mendes'),
    (215,'James','Cameron'),
    (216,'Gus','Van Sant'),
    (217,'John','Boorman'),
    (218,'Danny','Boyle'),
    (219,'Christopher','Nolan'),
    (220,'Richard','Kelly'),
    (221,'Kevin','Spacey'),
    (222,'Andrei','Tarkovsky'),
    (223,'Peter','Jackson');

-- --------------------------------------------------------

--
-- Tabla `genres`
--

DROP TABLE IF EXISTS genres;
CREATE TABLE genres (
  gen_id int NOT NULL,
  gen_title varchar(20) NOT NULL,
  PRIMARY KEY (gen_id)
) ENGINE=InnoDB;

--
-- Carga datos tabla `genres`
--

INSERT INTO genres (gen_id, gen_title) VALUES
(1001, 'Action'),
(1002, 'Adventure'),
(1003, 'Animation'),
(1004, 'Biography'),
(1005, 'Comedy'),
(1006, 'Crime'),
(1007, 'Drama'),
(1008, 'Horror'),
(1009, 'Music'),
(1010, 'Mystery'),
(1011, 'Romance'),
(1012, 'Thriller'),
(1013, 'War');

-- --------------------------------------------------------

--
-- Tabla `Movie`
--

DROP TABLE IF EXISTS Movie;
CREATE TABLE Movie (
  mov_id int NOT NULL,
  mov_title varchar(50) NOT NULL,
  mov_year int NOT NULL,
  mov_time int NOT NULL,
  mov_lang varchar(10) NOT NULL,
  mov_rel_country varchar(20) NOT NULL,
  PRIMARY KEY (mov_id)
) ENGINE=InnoDB;

--
-- Carga datos tabla `Movie`
--

INSERT INTO Movie (mov_id, mov_title, mov_year, mov_time, mov_lang, mov_rel_country) VALUES
    (901,'Vertigo',1958,128,'English','UK'),
    (902,'The Innocents',1961,100,'English','SW'),
    (903,'Lawrence of Arabia',1962,216,'English','UK'),
    (904,'The Deer Hunter',1978,183,'English','UK'),
    (905,'Amadeus',1984,160,'English','UK'),
    (906,'Blade Runner',1982,117,'English','UK'),
    (907,'Eyes Wide Shut',1999,159,'English','UK'),
    (908,'The Usual Suspects',1995,106,'English','UK'),
    (909,'Chinatown',1974,130,'English','UK'),
    (910,'Boogie Nights',1997,155,'English','UK'),
    (911,'Annie Hall',1977,93,'English','USA'),
    (912,'Princess Mononoke',1997,134,'Japanese','UK'),
    (913,'The Shawshank Redemption',1994,142,'English','UK'),
    (914,'American Beauty',1999,122,'English','UK'),
    (915,'Titanic',1997,194,'English','UK'),
    (916,'Good Will Hunting',1997,126,'English','UK'),
    (917,'Deliverance',1972,109,'English','UK'),
    (918,'Trainspotting',1996,94,'English','UK'),
    (919,'The Prestige',2006,130,'English','UK'),
    (920,'Donnie Darko',2001,113,'English','UK'),
    (921,'Slumdog Millionaire',2008,120,'English','UK'),
    (922,'Aliens',1986,137,'English','UK'),
    (923,'Beyond the Sea',2004,118,'English','UK'),
    (924,'Avatar',2009,162,'English','UK'),
    (925,'Braveheart',1995,178,'English','UK'),
    (926,'Seven Samurai',1954,207,'Japanese','JP'),
    (927,'Spirited Away',2001,125,'Japanese','UK'),
    (928,'Back to the Future',1985,116,'English','UK');

-- --------------------------------------------------------

--
-- Tabla `movie_cast`
--

DROP TABLE IF EXISTS movie_cast;
CREATE TABLE movie_cast (
  act_id int NOT NULL,
  mov_id int NOT NULL,
  role varchar(20) NOT NULL, 
  PRIMARY KEY (act_id, mov_id)
) ENGINE=InnoDB;

--
-- Carga datos tabla `movie_cast`
--

INSERT INTO movie_cast (act_id, mov_id, role) VALUES
(101, 901, 'John Scottie Fergus'),
(102, 902, 'Miss Giddens'),
(103, 903, 'T.E. Lawrence'),
(104, 904, 'Michael'),
(105, 905, 'Antonio Salieri'),
(106, 906, 'Rick Deckard'),
(107, 907, 'Alice Harford'),
(108, 908, 'McManus'),
(110, 910, 'Eddie Adams'),
(111, 911, 'Alvy Singer'),
(112, 912, 'San'),
(113, 913, 'Andy Dufresne'),
(114, 914, 'Lester Burnham'),
(115, 915, 'Rose DeWitt Bukater'),
(116, 916, 'Sean Maguire'),
(117, 917, 'Ed'),
(118, 918, 'Renton'),
(120, 920, 'Elizabeth Darko'),
(121, 921, 'Older Jamal'),
(122, 922, 'Ripley'),
(114, 923, 'Bobby Darin'),
(109, 909, 'J.J. Gittes'),
(119, 919, 'Alfred Borden');

-- --------------------------------------------------------

--
-- Tabla `movie_direction`
--

DROP TABLE IF EXISTS movie_direction;
CREATE TABLE movie_direction (
  dir_id int NOT NULL,
  mov_id int NOT NULL, 
  PRIMARY KEY (dir_id, mov_id)
) ENGINE=InnoDB;

--
-- Carga datos tabla `movie_direction`
--

INSERT INTO movie_direction (dir_id, mov_id) VALUES
(201, 901),
(202, 902),
(203, 903),
(204, 904),
(205, 905),
(206, 906),
(207, 907),
(208, 908),
(209, 909),
(210, 910),
(211, 911),
(212, 912),
(213, 913),
(214, 914),
(215, 915),
(216, 916),
(217, 917),
(218, 918),
(219, 919),
(220, 920),
(218, 921),
(215, 922),
(221, 923);

-- --------------------------------------------------------

--
-- Tabla `movie_genres`
--

DROP TABLE IF EXISTS movie_genres;
CREATE TABLE movie_genres (
  mov_id int NOT NULL,
  gen_id int NOT NULL, 
  PRIMARY KEY (mov_id, gen_id)
) ENGINE=InnoDB;

--
-- Carga datos tabla `movie_genres`
--

INSERT INTO movie_genres (mov_id, gen_id) VALUES
(922, 1001),
(917, 1002),
(903, 1002),
(912, 1003),
(911, 1005),
(908, 1006),
(913, 1006),
(926, 1007),
(928, 1007),
(918, 1007),
(921, 1007),
(902, 1008),
(923, 1009),
(907, 1010),
(927, 1010),
(901, 1010),
(914, 1010),
(906, 1012),
(904, 1013);

-- --------------------------------------------------------

--
-- Tabla `rating`
--

DROP TABLE IF EXISTS rating;
CREATE TABLE rating (
  mov_id int NOT NULL,
  rev_id int NOT NULL,
  rev_stars decimal(4,0) NOT NULL,
  num_o_ratings int NOT NULL,
  PRIMARY KEY (mov_id,rev_id)
) ENGINE=InnoDB;

--
-- Carga datos tabla `rating`
--

INSERT INTO rating (mov_id, rev_id, rev_stars, num_o_ratings) VALUES
(901, 9001, '8', 263575),
(902, 9002, '8', 20207),
(903, 9003, '8', 202778),
(906, 9005, '8', 484746),
(924, 9006, '7', 0),
(908, 9007, '9', 779489),
(909, 9008, '0', 227235),
(910, 9009, '3', 195961),
(911, 9010, '8', 203875),
(912, 9011, '8', 0),
(914, 9013, '8', 862618),
(916, 9014, '4', 642132),
(925, 9015, '8', 81328),
(918, 9016, '0', 580301),
(920, 9017, '8', 609451),
(921, 9018, '8', 667758),
(922, 9019, '8', 511613),
(923, 9020, '7', 13091);

-- --------------------------------------------------------

--
-- Tabla `reviewer`
--

DROP TABLE IF EXISTS reviewer;
CREATE TABLE reviewer (
  rev_id int NOT NULL,
  rev_name varchar(30),
  PRIMARY KEY (rev_id)
) ENGINE=InnoDB;

--
-- Carga datos tabla `reviewer`
--

INSERT INTO reviewer VALUES
    (9001,'Righty Sock'),
    (9002,'Jack Malvern'),
    (9003,'Flagrant Baronessa'),
    (9004,'Alec Shaw'),
    (9005,NULL),
    (9006,'Victor Woeltjen'),
    (9007,'Simon Wright'),
    (9008,'Neal Wruck'),
    (9009,'Paul Monks'),
    (9010,'Mike Salvati'),
    (9011,NULL),
    (9012,'Wesley S. Walker'),
    (9013,'Sasha Goldshtein'),
    (9014,'Josh Cates'),
    (9015,'Krug Stillo'),
    (9016,'Scott LeBrun'),
    (9017,'Hannah Steele'),
    (9018,'Vincent Cadena'),
    (9019,'Brandt Sponseller'),
    (9020,'Richard Adams');

-- --------------------------------------------------------
--
-- Modificación Tablas para añadir claves foráneas
--
-- --------------------------------------------------------

-- --------------------------------------------------------
--
-- Tabla `movie_cast`
--

ALTER TABLE movie_cast 
   ADD FOREIGN KEY (act_id) REFERENCES actor(act_id),
   ADD FOREIGN KEY (mov_id) REFERENCES movie(mov_id);

-- --------------------------------------------------------
--
-- Tabla `movie_direction`
--

ALTER TABLE movie_direction
   ADD FOREIGN KEY (dir_id) REFERENCES director(dir_id),
   ADD FOREIGN KEY (mov_id) REFERENCES movie(mov_id);

-- --------------------------------------------------------
--
-- Tabla `movie_genres`
--

ALTER TABLE movie_genres
   ADD FOREIGN KEY (gen_id) REFERENCES genres(gen_id),
   ADD FOREIGN KEY (mov_id) REFERENCES movie(mov_id);


-- --------------------------------------------------------
--                                                        --                     
-- Tabla `rating` 
--
-- ---------------------------------------------------------

ALTER TABLE rating
   ADD FOREIGN KEY (rev_id) REFERENCES reviewer(rev_id),
   ADD FOREIGN KEY (mov_id) REFERENCES movie(mov_id);

------------------

-- 1. Consulta SQL que permita encontrar todos los críticos (nombre) que han hecho una crítica con valoración 0 (campo rev_stars)
 
     -- * Primera forma de hacerlo: 
SELECT rev_name 
FROM reviewer JOIN rating WHERE reviewer.rev_id = rating.rev_id 
AND rev_stars =0;
	 -- * Segunda forma de hacerlo: 
SELECT rev_name 
FROM reviewer JOIN rating ON reviewer.rev_id = rating.rev_id 
WHERE rev_stars=0;
	 -- * Tercera forma de hacerlo: 
SELECT rev_name 
FROM reviewer NATURAL JOIN rating 
WHERE rev_stars =0;
	 -- * Cuarta forma de hacerlo: 
SELECT rev_name 
FROM reviewer JOIN rating USING (rev_id) 
WHERE rev_stars =0; 

-- 2. Consulta SQL para encontrar a los actores que interpretaron un papel en la película 'Annie Hall' y que devuelva para cada actor el 
-- nombre y apellido y el papel que interpretó

	 -- * Primera forma de hacerlo:  
SELECT act_fname, act_lname, role
FROM actor 
JOIN movie_cast ON actor.act_id = movie_cast.act_id 
JOIN movie ON movie.mov_id = movie_cast.mov_id
WHERE mov_title = "Annie Hall";

-- 3. Consulta SQL para identificar al director de la película 'Eyes Wide Shut', debe devolver el nombre, apellido y título y 
-- año de la película

SELECT dir_fname, dir_lname, mov_title, mov_year 
FROM director 
JOIN movie_direction ON movie_direction.dir_id = director.dir_id 
JOIN movie ON movie.mov_id = movie_direction.mov_id 
WHERE mov_title = "Eyes Wide Shut";

-- 4. Consulta SQL para identificar todas las películas con su año de estreno y genero (para todas las que tengan año de estreno)

SELECT mov_year, gen_title 
FROM movie 
JOIN movie_genres ON movie_genres.mov_id = movie.mov_id
JOIN genres ON genres.gen_id = movie_genres.gen_id
where mov_year IS NOT NULL;

-- 5. Consulta que permita obtener el director de la película en la que se interpreta el papel de Sean Maguire. Debe devolver el nombre y apellido del director y el título de la película

SELECT dir_fname, dir_lname, mov_title
FROM director 
JOIN movie_direction ON director.dir_id = movie_direction.dir_id
JOIN movie ON movie_direction.mov_id = movie.mov_id
JOIN movie_cast ON movie_cast.mov_id = movie.mov_id
WHERE role = "Sean Maguire";

-- 6. Consulta que permita listar los actores que tienen un 
-- papel registrado en películas con año de estreno fuera del periodo 1990 a 2000
-- (ambos incluidos). Se debe obtener nombre y apellido del actor y título y año de estreno de la película en la que han intervenido.

SELECT act_fname, act_lname, mov_title, mov_year 
FROM actor
JOIN movie_cast ON actor.act_id = movie_cast.act_id
JOIN movie ON movie.mov_id = movie_cast.mov_id 
WHERE mov_year not between 1990 and 2000;

-- 7. Consulta que permita obtener los directores para los que consta información del
-- género de sus películas. Mostrar la información agrupada por director y género y ordenada por
-- nombre y apellido de director. Se debe incluir el nombre, apellido del director, el género y el
-- número de películas (para cada director y género).

SELECT dir_fname, dir_lname, gen_title, count(*)
FROM director
JOIN movie_direction ON movie_direction.dir_id = director.dir_id 
JOIN movie_genres ON movie_direction.mov_id  = movie_genres.mov_id 
JOIN genres ON movie_genres.gen_id = genres.gen_id
GROUP BY dir_fname, dir_lname, gen_title
ORDER BY dir_fname, dir_lname ASC;

-- 8.  Consulta que permita obtener los directores para los que consta información de
-- género para varias películas. Mostrar la información agrupada por director y ordenada por
-- nombre y apellido de director. Se debe incluir el nombre, apellido del director y el número de
-- películas con información de género.

SELECT dir_fname, dir_lname, count(movie_genres.mov_id)
FROM director 
JOIN movie_direction ON movie_direction.dir_id = director.dir_id 
JOIN movie ON movie_direction.mov_id = movie.mov_id
JOIN movie_genres ON movie_genres.mov_id = movie.mov_id
GROUP BY dir_fname, dir_lname -- añadir esto para que se separen
HAVING count(movie_genres.mov_id) > 1
ORDER BY dir_fname, dir_lname ASC;

-- 9. Consulta que permita obtener todas las películas con información del año, genero,
-- nombre y apellido del director. Indicar título e información indicada anteriormente

SELECT mov_title, mov_year, gen_title, dir_fname, dir_lname 
FROM movie 
JOIN movie_genres ON movie.mov_id = movie_genres.mov_id 
JOIN genres ON movie_genres.gen_id = genres.gen_id
JOIN movie_direction ON movie.mov_id = movie_direction.mov_id;
-- ---------------
-- SIN TERMINAR --
-- ---------------

-- 11. 	Consulta que permita obtener para cada género el promedio de duración de las películas y el número de películas del mismo

SELECT gen_title, AVG(mov_time), count(*)
FROM movie
JOIN movie_genres ON movie.mov_id = movie_genres.mov_id 
JOIN genres ON genres.gen_id = movie_genres.gen_id 
GROUP BY genres.gen_title;

-- 12. Consulta que permita obtener de la película más corta el título, el año, duración de
-- la película, nombre y apellido del director, nombre y apellido del actor y el papel interpretado

SELECT mov_title, mov_year, mov_time, dir_fname, dir_lname, role 
FROM director
JOIN movie_direction ON movie_direction.dir_id = director.dir_id
JOIN movie ON movie.mov_id = movie_direction.mov_id 
JOIN movie_cast ON movie.mov_id = movie_cast.mov_id
JOIN actor ON movie_cast.act_id = actor.act_id 
WHERE mov_time IN (SELECT MIN(mov_time) FROM movie); -- IMPORTANTE : EL SELECT DENTRO DEL WHERE

-- REALIZACIÓN DE UNA SUBCONSULTA. alter

-- 14. Consulta que permita obtener la máxima valoración de cada película (rev_stars),
-- para cada película que tenga valoraciones mayores que 0, indicar el título y la máxima valoración
-- ordenando el listado por el título de la película.

SELECT mov_title, MAX(rev_stars)
FROM movie 
JOIN rating ON movie.mov_id = rating.mov_id
WHERE rev_stars >0
GROUP BY mov_title
ORDER BY mov_title;   

-- 15. Consulta que permita obtener para todas las película los roles que hay informados
-- en el sistema (si una película no tiene datos informados en alguna de las tablas debe aparecer
-- sin los datos que no están informados). Para cada película informar el título, el role, el nombre
-- y apellido del director de la película y el nombre y apellido del actor que lo interpreta ordenado
-- por título de película

SELECT mov_title, role, dir_fname, dir_lname, act_fname, act_lname
FROM movie 
JOIN movie_direction ON movie.mov_id = movie_direction.mov_id
JOIN director ON movie_direction.dir_id = director.dir_id
JOIN movie_cast ON movie_cast.mov_id = movie.mov_id 
JOIN actor ON movie_cast.act_id = actor.act_id
WHERE mov_title is null 
or role is null
or dir_fname is null
or dir_lname is null 
or act_fname is null 
or act_lname  is null
ORDER BY mov_title;

-- Para este cometido se usa el LEFT JOIN: 

SELECT mov_title, role, dir_fname, dir_lname, act_fname, act_lname
FROM movie
LEFT join movie_direction USING (mov_id) 
LEFT join director USING (dir_id) 
LEFT join movie_cast USING (mov_id) 
LEFT join actor USING (act_id)
ORDER BY mov_title; 

-- 16. Consulta que permita obtener para todas las película en las que alguno de sus
-- actores han actuado en más de una película. La consulta debe indicar el nombre de la película,
-- nombre y apellido del actor y papel desempeñado

SELECT mov_title, act_fname, act_lname 
FROM actor
JOIN movie_cast ON actor.act_id = movie_cast.act_id
JOIN movie ON movie.mov_id = movie_cast.mov_id 
WHERE actor.act_id IN (
SELECT act_id
FROM movie_cast 
GROUP BY act_id HAVING COUNT(*)>1 )   ; -- IMPORTANTE : EL SELECT DENTRO DEL WHERE

/*
17. Considerando los minutos de películas que cada uno de los directores tiene registrados (como la suma 
de la duración de todas sus películas, generar la consulta que permita obtener los directores que tienen 
suma de minutos mayor que la media de duración por director el nombre y apellido
de director así como la duración total de sus películas
*/

SELECT dir_fname, dir_lname, mov_time
FROM movie
JOIN movie_direction ON movie_direction.mov_id = movie.mov_id
JOIN director ON director.dir_id = movie_direction.dir_id 
WHERE dir_id IN (
SELECT dir_id
FROM director
WHERE movie_time IN (
SELECT movie_time 
from movie
HAVING COUNT(mov_time) > AVG (mov_time)
))
GROUP BY dir_fname;

SELECT dir_fname, dir_lname, SUM(mov_time) duracion_total FROM director
JOIN movie_direction ON director.dir_id = movie_direction.dir_id
JOIN movie ON movie_direction.mov_id = movie.mov_id
GROUP BY director.dir_id;

SELECT dir_fname, dir_lname, SUM(mov_time) duracion_total FROM director
JOIN movie_direction ON director.dir_id = movie_direction.dir_id
JOIN movie ON movie_direction.mov_id = movie.mov_id
GROUP BY director.dir_id;
HAVING duracion_total >
(SELECT AVG (duracion_total) FROM 
(S

