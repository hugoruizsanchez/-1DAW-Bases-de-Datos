
-- Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.

SELECT apellido1, apellido2, nombre FROM persona 
WHERE id IN (SELECT id_alumno from alumno_se_matricula_asignatura);

-- Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.

SELECT apellido1, apellido2, nombre FROM persona 
WHERE id IN (SELECT id_alumno from alumno_se_matricula_asignatura)
AND telefono is null;

-- Devuelve el listado de los alumnos que nacieron en 1999.

SELECT apellido1, apellido2, nombre FROM persona 
WHERE id IN (SELECT id_alumno from alumno_se_matricula_asignatura)
AND YEAR(fecha_nacimiento)=1999;

-- Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.

SELECT apellido1, apellido2, nombre FROM persona 
WHERE id IN (SELECT id_profesor from profesor) 
AND telefono is null;

-- Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.

SELECT id, nombre from asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 1.5.5 Consultas multitabla (Composición interna)

-- Devuelve un listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).

SELECT persona.* from persona 
JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id 
JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id 
JOIN grado ON grado.id = asignatura.id_grado
WHERE grado.nombre like "%Ingeniería informática%" AND persona.sexo ="M"
GROUP BY persona.id;


SELECT * from persona WHERE id IN 
(SELECT id_alumno from alumno_se_matricula_asignatura WHERE id_asignatura IN
(SELECT id from asignatura WHERE id_grado IN
(SELECT id from grado where nombre like "%Ingeniería informática%"))) AND persona.sexo ="M";

-- Devuelve un listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).

SELECT asignatura.nombre 
FROM asignatura 
JOIN grado ON grado.id = asignatura.id_grado
WHERE grado.nombre like "%Ingeniería informática%";

-- Devuelve un listado de los profesores junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de menor a mayor por los apellidos y el nombre.

SELECT persona.nombre, persona.apellido1, persona.apellido2, departamento.nombre
FROM persona
JOIN profesor ON profesor.id_profesor = persona.id
JOIN departamento ON departamento.id = profesor.id_departamento 
ORDER BY persona.apellido1, persona.apellido2, persona.nombre; 

-- Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con nif 26902806M.

SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin 
FROM asignatura
JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id
WHERE persona.nif="26902806M";

-- Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).

SELECT DISTINCT departamento.nombre 
FROM departamento
JOIN profesor ON profesor.id_departamento = departamento.id
JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor 
JOIN grado ON asignatura.id_grado = grado.id 
WHERE grado.nombre like "%Ingeniería informática%";

-- Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.

SELECT DISTINCT persona.id, persona.nombre, persona.apellido1, persona.apellido2 
FROM persona 
JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
WHERE curso_escolar.anyo_inicio = 2018 OR curso_escolar.anyo_inicio = 2019;

-- 1.5.6 Consultas multitabla (Composición externa)
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.

SELECT persona.nombre, persona.apellido1, persona.apellido2, departamento.nombre 
FROM persona
LEFT JOIN profesor ON profesor.id_profesor = persona.id 
LEFT JOIN departamento ON departamento.id = profesor.id_departamento
ORDER BY departamento.nombre, persona.apellido2, persona.apellido1, persona.nombre;


-- Devuelve un listado con los profesores que no están asociados a un departamento.

SELECT nombre from persona WHERE id IN (SELECT id_profesor from profesor where id_profesor NOT IN (SELECT id from departamento));

SELECT persona.nombre
FROM persona
LEFT JOIN profesor ON profesor.id_profesor = persona.id 
LEFT JOIN departamento ON departamento.id = profesor.id_departamento
where departamento.nombre is null;

-- Devuelve un listado con los departamentos que no tienen profesores asociados.

SELECT departamento.nombre 
FROM departamento 
LEFT JOIN profesor ON departamento.id = profesor.id_departamento 
WHERE profesor.id_profesor is null;

-- Devuelve un listado con los profesores que no imparten ninguna asignatura.

SELECT persona.id,persona.nombre, persona.apellido1 
FROM persona
LEFT JOIN profesor ON persona.id=profesor.id_departamento 
LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor 
WHERE asignatura.id_profesor is null;

-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.

SELECT asignatura.nombre, asignatura.id_profesor
FROM asignatura
WHERE asignatura.id_profesor is null;



--  Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.

SELECT departamento.nombre, asignatura.nombre as "Asignatura no impartida"
FROM departamento
LEFT JOIN profesor ON profesor.id_departamento = departamento.id
LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor 
WHERE asignatura.id NOT IN (SELECT id_asignatura from alumno_se_matricula_asignatura)
GROUP BY asignatura.nombre;

-- 1.5.7 Consultas resumen

-- -Devuelve el número total de alumnas que hay.

SELECT COUNT(*) as "Número de alumnas" from persona WHERE tipo="alumno" AND sexo="M";

-- Calcula cuántos alumnos nacieron en 1999.

SELECT COUNT(*) as "Numero de alumnos en 1999" from persona WHERE tipo ="alumno" AND YEAR(fecha_nacimiento)=1999;

-- Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.

SELECT departamento.nombre, COUNT(profesor.id_profesor) as n_profesores
FROM departamento
JOIN profesor ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre  ORDER BY n_profesores DESC  ;

-- Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.

SELECT departamento.nombre, COUNT(profesor.id_profesor) as n_profesores
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre  ORDER BY n_profesores DESC  ;

-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.

SELECT grado.nombre, COUNT(asignatura.id) as n_asignaturas
FROM grado
LEFT JOIN asignatura ON asignatura.id_grado = grado.id 
GROUP BY grado.nombre ORDER BY n_asignaturas DESC;

-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.

SELECT grado.nombre, COUNT(asignatura.id) as n_asignaturas
FROM grado
LEFT JOIN asignatura ON asignatura.id_grado = grado.id 
GROUP BY grado.nombre   HAVING COUNT(asignatura.id)>40 ORDER BY n_asignaturas DESC ;

-- Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo. Ordene el resultado de mayor a menor por el número total de crédidos.

SELECT grado.nombre, asignatura.tipo, SUM(asignatura.creditos)
FROM grado
JOIN asignatura ON asignatura.id_grado = grado.id 
GROUP BY grado.nombre ORDER BY SUM(asignatura.creditos) DESC ;

-- Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.

SELECT curso_escolar.anyo_inicio, COUNT(alumno_se_matricula_asignatura.id_alumno) 
FROM curso_escolar 
JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
GROUP BY curso_escolar.anyo_inicio;


-- Devuelve un listado con el número de asignaturas que imparte cada profesor. El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.

SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id)
FROM persona
LEFT JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor  
GROUP BY persona.nombre ORDER BY COUNT(asignatura.id) DESC;


-- Devuelve todos los datos del alumno más joven.

SELECT * from persona where YEAR(fecha_nacimiento) = (SELECT MAX(YEAR(fecha_nacimiento)) from persona where tipo="alumno") AND tipo="alumno"; 

-- Devuelve un listado con los profesores que no están asociados a un departamento.

SELECT id, nombre, apellido1, apellido2, tipo  FROM persona where id  IN 
(SELECT id_profesor from profesor where id_departamento NOT IN
(SELECT id from departamento));

SELECT id, nombre, apellido1, apellido2, tipo  FROM persona where id  IN 
(SELECT id_profesor from profesor where id_departamento is null);
(SELECT id from departamento));

-- Devuelve un listado con los departamentos que no tienen profesores asociados.

SELECT id, nombre from departamento WHERE id NOT IN (SELECT id_departamento from profesor);

-- Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.

SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, tipo
FROM persona where id IN 
(SELECT id_profesor from profesor where id_departamento IN
(SELECT id from departamento)) 
AND id NOT IN 
(SELECT id_profesor from asignatura ) ;

-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.

Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.

SELECT nombre from departamento where id NOT IN
(SELECT id_departamento from profesor WHERE id_profesor IN
(SELECT id_profesor from asignatura ));