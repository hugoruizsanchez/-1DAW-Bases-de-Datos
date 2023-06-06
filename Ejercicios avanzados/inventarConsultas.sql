-- PRÁCTICA: SEGUNDO TRIMESTRE. 

USE sakila;



/* 

Sentencia que dispone los elementos esenciales que comportan la película, diseñada para el uso de los clientes:

- Título. 
- Idioma 
- Categoría 
- Descripción
- Duración

Asimismo, la consulta considera los siguientes condicionantes: 

- Mostrará los datos bajo el supuesto de que el cliente vive en España, por lo que el nombre de la columna acompañará una traducción - hecha 
mediante un alias -  y únicamente remitirá las películas accesibles, en las tiendas ubicadas en el territorio español.

- Utiliza una subconsulta para omitir las películas con una duración superior a los 90 minutos.

- Las películas se encuentran agrupadas y organizadas alfabéticamente en base al nombre de la película. 

Puede tratarse de una consulta  práctica para aquellos que, viviendo en España, disponen de poco tiempo para disfrutar del cine. 

*/

-- * ------------------------------ * --
-- 	    PRIMER EJERCICIO	          --
--   	- Consulta.                   --
-- 	 	- Vista.				      --
-- * ------------------------------ * --

SELECT film.title as "Título / Title" , language.name as "Idioma / Language", category.name as "Categoría / Category" , film_text.description as "Descripción / Description", film.length as "Duración / Length"
from film 
JOIN film_category ON film.film_id = film_category.film_id 
JOIN category ON film_category.category_id = category.category_id
JOIN language ON film.language_id = language.language_id 
JOIN film_text ON film.film_id = film_text.film_id
JOIN inventory ON inventory.film_id = film.film_id
JOIN store ON store.store_id = inventory.store_id
JOIN customer ON customer.store_id = store.store_id 
JOIN address ON customer.address_id = address.address_id 
JOIN city ON city.city_id = address.city_id 
JOIN country ON city.country_id = country.country_id
WHERE length IN (SELECT length from film having length < 90) AND country = "Spain"
GROUP BY film.title
ORDER BY film.title;

CREATE VIEW client_esp 
AS SELECT  film.title as "Título / Title" , language.name as "Idioma / Language", category.name as "Categoría / Category" , film_text.description as "Descripción / Description", film.length as "Duración / Length"
from film 
JOIN film_category ON film.film_id = film_category.film_id 
JOIN category ON film_category.category_id = category.category_id
JOIN language ON film.language_id = language.language_id 
JOIN film_text ON film.film_id = film_text.film_id
JOIN inventory ON inventory.film_id = film.film_id
JOIN store ON store.store_id = inventory.store_id
JOIN customer ON customer.store_id = store.store_id 
JOIN address ON customer.address_id = address.address_id 
JOIN city ON city.city_id = address.city_id 
JOIN country ON city.country_id = country.country_id
WHERE length IN (SELECT length from film having length < 90) AND country = "Spain"
GROUP BY film.title
ORDER BY film.title;

-- * ------------------------------ * --
-- 	    SEGUNDO EJERCICIO	          --
--   	- Consulta.                   --
-- 	 	- Vista.				      --
-- * ------------------------------ * --


SELECT film.title as "Title", AVG(amount) as "Average Amount", AVG (replacement_cost) as "Replacement cost"
FROM film
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON payment.customer_id = rental.customer_id 
GROUP BY film.title
HAVING AVG(amount) < (SELECT AVG(amount) FROM payment)  AND 
AVG (replacement_cost) < (SELECT AVG (replacement_cost) from film);

CREATE VIEW client_sin_dinero 
AS SELECT film.title as "Title", AVG(amount) as "Average Amount", AVG (replacement_cost) as "Replacement cost"
FROM film
JOIN inventory ON inventory.film_id = film.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON payment.customer_id = rental.customer_id 
GROUP BY film.title
HAVING AVG(amount) < (SELECT AVG(amount) FROM payment)  AND 
AVG (replacement_cost) < (SELECT AVG (replacement_cost) from film);

SELECT * from client_sin_dinero

;


