USE BD_MOVIES;

/*
5.1 
INSERTAR UN NUEVO VALOR con la película TOP GUN:

debe insertarse DE MENOS A MÁS, procurando cubrir todos los registros, para asegurar la coordinación de las foráneas

*/


INSERT INTO movie ( mov_id , mov_title, mov_year, mov_time, mov_lang, mov_rel_country) VALUES (99 ,'Top Gun: Maverick', 2022 , 133 , 'Inglés', 'Estados Unidos');

INSERT INTO director (dir_id, dir_fname, dir_lname) VALUES (99, "Joseph", "Kosinski");

INSERT INTO movie_direction (dir_id, mov_id) VALUES (99,99);

INSERT INTO actor (act_id, act_fname, act_lname, act_gender) 
VALUES 
(99,"Jose María","Esponsal", "M"),
(100,"Fernando","Rondales", "M"),
(999,"Antonia","Tuerto", "F"), 
(998,"Ana Rosa","Griso", "F");

INSERT INTO movie_cast (act_id, mov_id, role) VALUES 
(99, 99, "El justiciero"),
(100, 99, "El basado"),
(999, 99, "La madre"), 
(998, 99, "La periolista");

INSERT INTO genres (gen_id, gen_title) VALUES (99, "Action");

INSERT INTO movie_genres (mov_id, gen_id) VALUES (99, 99);

INSERT INTO reviewer (rev_id, rev_name) VALUES (99, "Carlos"); 

INSERT INTO rating (mov_id, rev_id, rev_stars, num_o_ratings) VALUES (99, 99, 4.0, 54);


/*
5.2
MODIFICAR CRÍTICOS 

RESTAR -1 A PUNTUACIONE
*/

UPDATE reviewer  SET rev_name = 'Juan' WHERE rev_id = 99;

-- Debe acompañarse la sentencia con una KEY (por seguridad) para circunscribir el efecto del UPDATE

UPDATE rating SET rev_stars = rev_stars -1 WHERE mov_id = 99;

/*
5.3
ELIMINAR INFORMACION -> valoraciones y criticos 
*/

DELETE FROM rating WHERE mov_id = 99;
DELETE FROM reviewer WHERE rev_id	 = 99;


