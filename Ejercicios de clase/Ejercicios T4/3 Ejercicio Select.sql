-- EJERCICIO DE SUBCONSULTAS 

-- > Para una representación gráfica de la base de datos, consultar ~/T4/t4subconsultas.pdf

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
--
-- Tabla `rating`
--

ALTER TABLE rating
   ADD FOREIGN KEY (rev_id) REFERENCES reviewer(rev_id),
   ADD FOREIGN KEY (mov_id) REFERENCES movie(mov_id);


-- -----------------  REALIZACIÓN DEL EJERCICIO --------------- --
--
--
--
-- 1 Consulta SQL para listar el nombre y el año de las película

SELECT mov_title, mov_year from movie;

-- 2 Consulta SQL para conocer cuando se estrenó la película 'American Beaut

SELECT mov_title, mov_year from movie where mov_title like "%American Beauty%";
SELECT mov_title, mov_year from movie where mov_title = "American Beauty";

-- 3 Consulta que permita listar el título de las películas estrenadas en 1999

SELECT mov_title, mov_year from movie where mov_year=1999;

-- 4 Consulta que permita listar el título de las películas estrenadas antes de 1998 ordenadas por el título

SELECT mov_title, mov_year from movie where mov_year<1998 ORDER BY mov_title;

-- 5  Consulta que permita obtener el listado de las películas (su títulos) con ID 903 o 907 o 917

SELECT mov_title, mov_id from movie where mov_id = 903 or mov_id = 907 or mov_id = 917;
SELECT mov_title, mov_id FROM movie where mov_id in (903,907,917);

-- 6 Consulta que permita listar el título y el año de estreno de las películas estrenadas entre el año 1990 y 2000 ambos incluido

SELECT mov_title, mov_year from movie where mov_year between 1990 AND 2000;

-- 7 Consulta que permita listar el título, la duración y el año de estreno de las películas con duración mayor de 180 minutos o bien hayan sido estrenadas entre el año 1995 y 2005 ambos incluidos

SELECT mov_title, mov_time, mov_year from movie where mov_time>=180 or mov_year between 1995 and 2005;

-- 8 Consulta que permita obtener el título de las películas que comiencen por la palabra “the”

SELECT mov_title from movie where mov_title LIKE "the%";

-- 9 Consulta que permita obtener el título de las películas que contengan la palabra “the” y “hunter”

SELECT mov_title from movie where mov_title like "%the%" and mov_title like "%hunter%";

-- 10 Consulta que permita obtener la duración de la película de mayor duración

SELECT mov_title,MAX(mov_time) from movie;

-- 11 Consulta que permita obtener para cada año de lanzamiento la duración de la película de mayor duración.

SELECT mov_year,mov_title,MAX(mov_time) from movie GROUP BY mov_year ORDER BY mov_year;

-- 12 Consulta que permita obtener para cada año de lanzamiento la duración de la película de mayor duración y la duración de la película de menor duración

SELECT mov_year, mov_title, MAX(mov_time), MIN(mov_time) from movie GROUP BY mov_year ORDER BY mov_year






