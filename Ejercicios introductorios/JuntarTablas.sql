CREATE TABLE products (

id int not null auto_increment,
name varchar (50) not null,
created_by int not null, 
marca varchar (50) not null, 
primary key (id),
foreign key (created_by) references user(id) -- Creamos una clave foránea (es decir, una clave que está relacionada con otra tabla) con el nomre "created by" en basea la clave primaria user(id)

);

rename table products to product;  -- Cambiamos el nombre de la tabla. 

insert into product (name, created_by, marca) -- Para añadir muchos valores a la vez. 
values 
	('iPad',1,'Apple'),
    ('iPhone',1,'Apple'),
	('Apple Watch',2,'Apple'),
    ('iMac',3,'Apple'),
    ('iPad Mini',2,'Apple');
    
		
SELECT * from product;
    
    
SELECT u.id, u.email, p.name from user u left join product p on u.id = p.created_by; 

-- asociamos un alias para user escribiendo "from user u" para produc con "left join product p"
-- después del SELECT, mostramos cómo queremos ver la tabla (u.id, u.mail, p.name) 
-- finalmente, detallamos que queremos que la u.id = p.created_by para que los usuarios se corespondan con los creadores.
    
    
SELECT u.id, u.email, p.name from user u right join product p on u.id = p.created_by; -- Lo mismo, pero por la derecha. Es decir, en vez de traer datos de usuarios a productos, los trae de productos a usuarios. 
      
      
SELECT u.id, u.email, p.name from user u inner join product p on u.id = p.created_by; -- Solo muestra los productos registrados a un usuario
    
SELECT u.id, u.email, p.name from user u cross join product p; -- Producto cartessiano entre todos los registros