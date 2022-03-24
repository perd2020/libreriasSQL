create database proyecto1 ;    #despues de crear nueva conexion, creo la base de datos
                  
use proyecto1;                 # seleccionola base de datos con la que voy a trabajar
                               #creo una tabla
create table productos(
		idproducto int not null auto_increment primary key,
			nombre varchar (50) not null,
				precio double(6,2),
					marca varchar(30) not null,
						categoria varchar(30),
							stock int not null,
								disponible bit default false
);


##

#eliminar tablas,con drop table dtabase view campos columnas etc
#drop table productos;
#drop view productos;drop databases 0001; etc etc
#refresh

insert into productos
					(idproducto,nombre,precio,marca,categoria,stock,disponible)
						values
							(1,'monitor',15659.36,'RCA','monitores',50,false),
							(2,'monitor',17659.36,'Samsung','monitores',50,false)
;

SELECT * FROM proyecto1.productos;
#saco id y el autoincrement lo devuelve automaticamente cin el numeri que corresponde

insert into productos
					(nombre,precio,marca,categoria,stock,disponible)
						values
							('teclado',1600.86,'Lg','teclados',50,false),
							('teclado',5000.52,'Samsung','teclados',50,false)
;

#########################################
# para ver con que bases de datos cuento uso esta sentencia para no estar ciego. 
#show databases; veo bases de datos y saber con cual estoy trabajaando 
#
# show tables; para ver las tablas
# 
#describe productos;para ver las caracteristicas de la tabla

#########################################

#como modifico alguna ESTRUCTURA
# SOBRE LA TABLA PRODUCTOS

alter table productos add column observaciones varchar (50);                #agregar una columna
select * from productos;

alter table productos add column primera1 varchar (50) first;              # agrega al principio de la tabla
alter table productos add column enelmedio varchar (50) after idproducto;   #colocar columna despes de "tal" columna

#cambiar nombre de la columna con CHANGE, MODIFY es para modificar valores

alter table productos change observaciones comentarios varchar(50);


alter table productos change  comentarios observaciones varchar(20);#cambiamos el tipo, 

#cambiae solo el tipo modify para cambiar un dato, change es para cambiar el nombre

alter table productos modify precio double;
select * from productos;
describe productos;                                      #para ver los tipos de datos y comprobar que me cambio lo que le pedi

#eliminaer columnas

alter table productos drop column primera1;              # una columna
alter table productos drop column enelmedio, drop column primera;#borro varias columnas

#renombrar una columna
alter table productos rename products;

#importamos tablatop_spotify.los pasos  los tengo en la carpeta clas2

select * from top_spotify;
describe top_spotify;

#primero descargo  script estructura libreria
# file/open sql script

use libreria1;

select * from autores;                                  #quiero ver todas (*) las columnas de autores

select nombre,apellido,ciudad from autores;             # quiero ver la columna nombre,apellido y ciudad de la tabla autores

 select * from ventas;

 select factura_nro, cantidad, cantidad*10 as cantidadtotal,
	'china' as origen                                   #tambien puedo crear una columna nueva
		from ventas
			order by factura_nro,cantidad desc         #ordeno en foma descendente primero por el nro de factura y lo limitamos
											           #y despues por la cantidd se puede ordenar por varios criterios
				limit 5;                               #limit el resultado a 5 lineas, los 5 mas escuchados,,,campo calculado columna temporal
 
 select * from puestos
 limit 3
 offset 4;                                            #quiero ver apartir de la linea 4,los primeros 3 filas 


###########################
#operadores logicos
select * from autores
where ciudad='buenos aires' and estado=1 or ciudad='lima';

####clase3####

select * from ventas
order by cantidad;

select * from ventas
where cantidad <50;

select*from ventas
where cantidad > 50;

select*from ventas
where cantidad >= 50;

select*from ventas
where cantidad <= 50;

select * from ventas
where local_id != 6318 and local_id=6745;       # no quiero ver los que tengan este/os numero/s

select * from ventas
where cantidad between 30 and 40
order by cantidad;                  #quiero que me mueste entre 30 y 40, y me los muestre ordenados por cantidad

#busqueda like
select*from libros
where titulo like '%mundo%';

select*from libros
where titulo like '%mundo';

select*from libros
where titulo like '%contemporaneo'<25;

select*from libros
where titulo not like '%mundo%'; #todos aquellos QUE NO TENGAN DETERMINADA PALABRA el mundo en su titulo

select*from libros
where comentarios is null;# me muestra todos los que tengan null en comentario

select*from libros
where comentarios is not null;# todos menos los null

select*from empleados;
select*from puestos;

# busco cuantos empleados son editores
#filtro pero que venga de otra tabla ,SUBCONSULTAS#
#######    IN

select puesto_id from puestos     #no puede haber (*)asteriscos en la subconsulta
where descripcion ='editor';

select*from empleados
where puesto_id IN(12);  #FORMA RUSTICA

select*from empleados
where puesto_id IN
	(select puesto_id from puestos     #COPIE Y PEGUE LINEAS 157 Y 158
		where descripcion ='editor');



select*from empleados
	where puesto_id IN
		(select puesto_id from puestos                  #ademas que me traiga los que son CEO
			where descripcion ='editor' or descripcion='CEO'); 
    
    ### hacer un BACKUP cotidianamente para resguardar estructura y datos ante cualquier eventualidad##
    
    ## realizar un RESTORE para recuperar estructura o datos o ambos ##
    
    ## FUNCIONES INTEGRADAS
    #funciones de textos integradas al motor
    #
    
    ## como concatenar diferentes columnas
    
select concat('datos de autores:',' ', nombre,' ' ,apellido)
	from autores;

select concat_ws('|', nombre,apellido,telefono,ciudad) as  'datos de autores' from autores;

#IMPORTANTE =guardar la tabla y guardarla como csv con EXPORT que esta en la barra de menu de la pantalla inferior

select *, upper(apellido)as 'APELLIDOS EN MAYUSCULA' , lower(nombre) as 'nombres en minuscula'from autores; # TODO EN MAYUSCULA, o en minuscula

select left(nombre,4) as A from autores;          #MUESTRA EL 4 primeros CARACTER

select right(nombre,4) as B from autores;#MUESTRA EL 4ultimosCARACTER

select right(apellido,1) nombre, apellido from autores
	order by right(apellido,1);

select*from empleados;

select substring(empleado_id,4,4) as 'los cuatro despues del 4',empleado_id  from empleados
order by empleado_id;# me trae los caracteres desde el caracter5, 6,7,8

select char_length(empleado_id),empleado_id from empleados;#cantidad de caracteres que tiene el string


select empleado_id,locate('A42',empleado_id) as 'ubicacion'from empleados;    #donde inicia "N" cadena de texto, si esta te dice la posicion , si no la tiene te devuelve 0

#IMPORTANTE-- puedo usar...
###Ltrim(nombre campo)--elimina espacios de la izq de un texto
##Rtrim(nombre campo) elimina espacios de la derecha de un texto
## trim(nombre campo)elimina espacios de derecha y de izquierda
 #  '  PMA42628M'  #
 
 ####
 
 ## reemplazar valores REPLAACE
 select*from libros;
 
select *, replace(categoria, 'sin asignar', 'asignado') as 'reemplazadas' from libros;

select*from autores;
select*, replace(provincia,'ER', 'entre rios') from autores;  # no estamos pisando el dato solo  me lo muestra en otra columna

##FUNCIONES DE FECHAS

select*from libros;
select year(fecha_publicacion) from libros;
select libro_id,titulo, fecha_publicacion
	,year(fecha_publicacion) as'año'
		,month(fecha_publicacion) as 'mes'
			,day(fecha_publicacion) as 'dia'
	    from libros  order by año ;            # estoy solicitando que me separe de la columna "fecha_publicacion" el año, mes y el dia en columnaas 
											  #diferentes y ademas necesito que me las ordene por año en forma ascendente
select year(fecha_publicacion) from libros;
select libro_id,titulo, fecha_publicacion
	,year(fecha_publicacion) as'año'
		,month(fecha_publicacion) as 'mes'
			,day(fecha_publicacion) as 'dia'
	    from libros  order by año desc;         # estoy solicitando que me separe de la columna "fecha_publicacion" el año, mes y el dia en columnaas 
											  #diferentes y ademas necesito que me las ordene por año en forma descendente


select current_date();                          #fewcha de hoy
select current_time();                          #hora actual

select libro_id,titulo, fecha_publicacion
	,hour(fecha_publicacion) as'hora'
    ,minute(fecha_publicacion) as'minutos'
    ,second(fecha_publicacion) as'segundos' from libros;  #extraer y mostrar por separado hora,minuto y segundos
    
 select libro_id,titulo,fecha_publicacion, datediff(current_date(),fecha_publicacion) as 'DiasTranscurridos'
	from libros;                                     # comparar dos fechas, la actual current y fecha publicacion de la tabla  y me devuelve los dias de diferencia entre uno y otro 
    
select dayname(current_date()) as 'nombre del dia de semana';

select libro_id,titulo,fecha_publicacion, datediff(current_date(),fecha_publicacion) as 'dias transcurridos'
	,datediff(current_date(),fecha_publicacion) /365 as 'cantaños'
	from libros;
# si quiero que me de la diferencia en años

    
select dayofweek(current_date()) as 'dia de semana en que estamos dom1';# tener en cuenta que el sistema arrana la semana los domingos, sino debo hacerlo -1
   
select dayofweek(current_date()-1) as 'dia de semana en que estamos lun1';# porque estoy en lunes y quiero q lo tome desde lunes

   
select dayofyear(current_date()) as 'dia del año en que estamos';

   
select monthname(current_date()) as 'nombre del mes en que estamos';

   # SI QUIERO SABEER QUE FECHA CAE EXACTAMENTE EN DOWS MESES
select curdate()  as'fecha actual'
	,adddate(curdate(),interval 2 month) as 'dentro de dos meses';
    
## current_date y curdate es lo mismo
    
    select curdate()  as'fecha actual'
	,adddate(curdate(),interval 120 day) as 'dentro de 120 dias'
	,adddate(curdate(),interval 2 month) as 'dentro de dos meses'
	,adddate(curdate(),interval 1 year) as 'dentro de  un año';

 #### funciones de numeros integrados ###
 
select * from libros;
select precio, round(precio,1)  from libros;#CAMPO CALCULADO, redondeo que tenga 1 decimal para arriba
select precio, precio /3 as 'precio dividido 3'
, round(precio/3, 3) as'precio dividido  3 con solo 3 decimales' from libros;

select precio, precio*1.21 as 'precio con iva' 
, round(precio/3, 3) from libros;    ## CALCULANDO EL IVA

select precio, precio*1.21 as 'precio con iva' 
, ceil() from libros;

select precio, precio*1.21 as 'precio con iva' 
, floor(precio*1.21) as 'entero superior'from libros;

select precio, precio*1.21 as 'precio con iva' 
, ceil(precio*1.21) as 'entero superior', floor(precio*1.21)as'entero inferior' from libros;  ## REDONDEO SUPERIOR Y REDONDEO INFERIOR

#select mod(8,3);      # me devuelve 2 #para saber si un valor es par o impar  si da cero es par no hay resto, es el resto el modulo de una division


select pow(2,3);      # potencia

select fecha_publicacion,dayofweek(fecha_publicacion)
from libros
 where dayofweek(fecha_publicacion) between 2 and 6;

###### agregado y agrupamiento#######

select * from ventas order by libro_id;
select count(libro_id) from ventas;

select sum(cantidad) as 'suma de ventas' from ventas
where factura_nro like '%40%';

select max(cantidad) as 'maximo de ventas' from  ventas;

select factura_nro,fecha,forma_pago, max(cantidad) as'maximo de cantidad de ventas' from ventas;
select factura_nro,fecha,forma_pago , min(cantidad) as'maximo de cantidad de ventas' from ventas;

# el maximo y maximo de algo###

# sacar el promedio
select factura_nro,fecha,forma_pago , avg(cantidad) as'promedio de cantidad  ventas' from ventas;

select *from ventas order by forma_pago ;

#####AGRUPAR A TRAVES DE UN CAMPO Y QUIERO SABER CUANTOS SUBGRUPOS HAY

select forma_pago,count(*) from ventas
group by forma_pago;

######
## AGRUPAR POR CATEGORIAS###
select*from libros;
select categoria, count(*) from libros
group by categoria
order by count(*);

###
select categoria, count(*) from libros
group by categoria
having count(*)<4;-- having es el where de los agrupados

#################################################################################################
--                 CREANDO COPIAS DE TABLAS, O PARTE DE UNA TABLA EN UNA NUEVA TABLA------
-- quiero copiar una tabla dentro de mi misma base de datos--
-- crear una tabla y rellenarla con datos de otra tabla--
-- 2:00 ---
use libreria1;

create table copia_1    ## CREO UNA COPIA DE MI TABLA LIBROS
select* from libros;

select*from copia_1;   -- COMPRUEBO SI SE CREO

create table copia_2
select* from libros where categoria='novelas';    ## creo una tabla solo de NOVELAS

select*from copia_2;  -- COMPRUEBO SI SE CREO

-- drop table copia_2
-- updates - actualizaciones
###################################################################################################################
-- IMPORTANTE!!! SABER SIEMPRE QUE ES LO QUE VOY A ACTUALIZAR O BORRAR, YA QUE NO HAY VUELTA ATRAS O DESHACER!!!!
####################################################################################################################

select*from libros;
update libros set comentarios='algun comentario'
where comentarios is null;



## ERROR ## 1175
## estan bloqueadas update y delete.... entonces ejecutar
-- SET SQL_SAFE_UPDATES = 0;

## BORRAR

/*DELETE  borras y el siguiente dat arranca del proximo numero de orden, si borre 10 
el proximo dato ingresado va a ser el 11

DROP  borra y arranca de 0

*/

SELECT*FROM VENTAS;
delete from ventas 
where local_id=8042 and factura_nro=423 and cantidad=10;  -- borrar exactamente este.se borra linea completa --controlo y deaparecio--it's ok!!

##  datos anexados 

#anexar datos a una tabla ya existente, insert in to es unas pocas a mano, pero si son muchos y tengo coincidencias en los campos de las tablas
#o un backaup de datos antiguos
#hacer una tabla datos virjos y otra vom daris modernis##

select*from copia_1;   
update copia_1 set comentarios='anexado'; -- hecho

insert into libros 
select*from copia_1;

select*from libros;   -- hecho

insert into libros(titulo, categoria)
select titulo,categoria from copia_1;

select * from libros;

#####55:58 reforzar subconsultas.primary y foreing/diseño  

/*tratar de lograr la menor cantidad de repeticiones posibles por eso usamos la PRIMry key PARA TENER UN DATO UNIVOCO
	A PARTIR DE LA CLAVE PRIMARIA YO PUEDO AGREGAR un libro a partir de la editorial, siempre y cuando la editorial exista, sino el padre no existiria sino existe la editorial
    --mucchos alter, 
    crear todas la CLAVES PRIMARIAS Y LAS FORANEAS EXTERNAS U SECUNDARIAS QUE NECESITEMOS
    VEREmos solo el diseño 
    */


use librerias;
select*from autores;

-- vamos a definir la PRIMARY KEY que se debe realizar de principio

alter table autores ADD primary key (autor_id); -- no me da xq tengo datos duplicados..ERROR 1062 y me dice cual. como no tengo para borrar los 
                                                 -- duplicados los tengo que ver
                                                 
select*from autores                              -- tengo tres veces los datos xq importe tres veces los datos
order by autor_id;

create table autores_1
select* from autores limit 1;

select*from autores_1;

-- SET SQL_SAFE_UPDATES = 0;   --- activar el borrado
delete from autores_1;          -- ahora si borro

alter table autores_1 ADD primary key(autor_id);   #CREE CLAVE PRIMARIUA

insert into autores_1
select*from autores;  # no me deja MySQL PERO EN OTROS DEBE FUNCIONAR
                       -- TRUNCATE  ???? consulta de clase -- 
##### ahora inserto datos a la tabla creada
insert into autores_1(autor_id,apellido, nombre, telefono, direccion , ciudad, provincia, c_postal, estado)
	select distinct(autor_id),apellido, nombre, telefono, direccion , ciudad, provincia, c_postal, estado from autores;
select*from autores_1;

alter table autores rename autores_duplicados;  -- renombrar autore que tenia los triplicados
select* from autores;                           -- constato que la tabla no esta con el mismo nombre, que se cambio
alter table autores_1 rename autores;           -- ahora renombro la tabla que cree nueva  autores_1 con un solo autores_id para que me permita crear la PRI,ARY KEY

select*from autores;


-- verificar, pantalla izquierda en el arbol, debe figurar en schema autores y autores_id "PK"
-- AHORA CONSTATO SI ME DEJA INGRESAR UN DATO REPETIDO :

insert into autores(autor_id,apellido, nombre, telefono, direccion , ciudad, provincia, c_postal, estado)
	VALUES ('172-32-1176', 'Quiroga', 'Horacio', '44967223', '', 'Salto', 'ER', '4025', '1'
) ;
-- me da error entrada duplicadaERROR 1062 'DUPLICATE ENTRY 'TAL TAL TAL''ME DICE DONDE ESTA EL ERROR

--                	primary key a todas las tablas  xq ninguna twenia  --
##                  editoriales
-- CREAR TABLA NUEVA
-- COPIAR DISTINTOS
-- ELIMINAR TABLA ANTERIROR
-- ETC ETC

alter table editoriales ADD primary key (editorial_id);
-- no me dejo!! me dice que tengo datos duplicados
select*from editoriales
order by editorial_id;  -- veo que tengo TRIPLICADOS LOS DATOS!! TENDRE QUE REPETIR LOS PASOS DEL CASO ANTERIOR


 -- CREAR TABLA NUEVA PARA EDITORIALES

create table editoriales_1
select* from editoriales limit 1;

select*from editoriales_1;

-- SET SQL_SAFE_UPDATES = 0;   --- activar el borrado si hace falta
delete from editoriales_1;          -- ahora si borro

alter table editoriales_1 ADD primary key(editorial_id);   #CREE CLAVE PRIMARIA
                        
##### ahora inserto datos a la tabla creada
select*from editoriales;
insert into editoriales_1(editorial_id,nombre ,ciudad, provincia, pais)
	select distinct(editorial_id),nombre, ciudad, provincia, pais from editoriales;
select*from editoriales_1;

alter table editoriales rename editoriales_duplicados;  -- renombrar autore que tenia los triplicados
select* from editoriales;                           -- constato que la tabla no esta con el mismo nombre, que se cambio
alter table editoriales_1 rename editoriales;           -- ahora renombro la tabla que cree nueva  autores_1 con un solo autores_id para que me permita crear la PRI,ARY KEY

select*from editoriales;

###         AHORA CREO PRIMARY KEY PARA EMPLEADOS
select*from editoriales
order by editorial_id;  -- veo que tengo TRIPLICADOS LOS DATOS!! TENDRE QUE REPETIR LOS PASOS DEL CASO ANTERIOR


 -- CREAR TABLA NUEVA PARA EDITORIALES
select * from empleados
	order by empleado_id;
create table empleados_1
select* from empleados limit 1;

select*from empleados_1;

-- SET SQL_SAFE_UPDATES = 0;   --- activar el borrado si hace falta
delete from empleados_1;          -- ahora si borro

alter table empleados_1 ADD primary key(empleado_id);   #CREE CLAVE PRIMARIA
                        
##### ahora inserto datos a la tabla creada
select*from empleados;
insert into empleados_1(empleado_id, nombre, apellido, puesto_id, editorial_id, fecha_ingreso)
	select distinct(empleado_id),nombre, apellido, puesto_id, editorial_id, fecha_ingreso from empleados;
select*from empleados_1
order by empleado_id;

alter table empleados rename empleados_duplicados;  -- renombrar autore que tenia los triplicados
select* from empleados;                           -- constato que la tabla no esta con el mismo nombre, que se cambio
alter table empleados_1 rename empleados;           -- ahora renombro la tabla que cree nueva  autores_1 con un solo autores_id para que me permita crear la PRI,ARY KEY

select*from empleados;

##               libros

select*from libros
order by libro_id;  -- veo que tengo TRIPLICADOS LOS DATOS!! TENDRE QUE REPETIR LOS PASOS DEL CASO ANTERIOR

create table libros_1
select* from libros limit 1;

select*from libros_1;

-- SET SQL_SAFE_UPDATES = 0;   --- activar el borrado si hace falta
delete from libros_1;          -- ahora si borro

alter table libros_1 ADD primary key(libro_id);   #CREE CLAVE PRIMARIA
                        
##### ahora inserto datos a la tabla creada
select*from libros_1;

insert into libros_1(libro_id, titulo, categoria, editorial_id, precio, comentarios, fecha_publicacion)
	select distinct(libro_id),titulo, categoria, editorial_id, precio, comentarios, fecha_publicacion from libros;
    
    
select*from libros_1
	order by libro_id;-- veo que no tengo duplicADOS
    
alter table libros rename libros_duplicados;  -- renombrar autore que tenia los triplicados
select* from libros;                           -- constato que la tabla no esta con el mismo nombre, que se cambio
alter table libros_1 rename libros;           -- ahora renombro la tabla que cree nueva  autores_1 con un solo autores_id para que me permita crear la PRI,ARY KEY

select*from libros
	order by libro_id;

##      libro autor##tabla relacional o intermedia


/*tiene dos columnas dos id, porque , porque la relacione
- autores con libros, porque en una tabla me olvide un campo, y tuve que diseñar una tabla intermedia,
 o tabla de paso
 
 -si busco en tabla autor encuentro libro_id
 
 -para agregar un dato nueVo que solicita el cliente , creare una tabla de paso
 
- un mismo autor_id puede tener mas de un libro
- la combinacion autor/libro seria la clave unica
-----por ejemplo:                         PK
		-- autor1 libro1                   1 
		-- autor1 libro2                   2
		-- autor 1 libro3                  3 
		--autor2    libro1                 4
		--autor3    libro1                 5 

CLAVE COMBINADA-lo que no se van a repetir las combinaciones
-- no lo pude hacer hasta ahora xq las dos columnas tienen datos repetidos, y no me deja crear la primary key , asi lo que voy a ahacer es crear de nuevo la tabla copíando los datod, la n
borro y renombro



*/
create table libroautor_1
select* from libroautor limit 1;    -- creo tabla copia de la original pero que me extraiga un solo dato


select*from libroautor_1 
order by libro_id;

delete from libroautor_1;     -- borre los datos de la tablla para poder cargar los nuevos

alter table libroautor_1 add primary key (libro_id, autor_id);

select*from libroautor order by libro_id;


insert into libroautor_1(autor_id,libro_id)
	values
('213-46-8915',	'BU1032')
,('409-56-7008','BU1033')
,('267-41-2394','BU111')
,( '724-80-9391','BU1112')
,('213-46-8915','BU2075')
,('274-80-9391','BU7832')
,('712-45-1867','MC2222')
,('722-51-5454','MC3021')
,('899-46-2035','MC3022')
,('238-95-7766','PC1035')
,('427-17-2319','PC8888')
,('846-92-7186','PC8889')
,('486-29-1786','PC9999')
,('724-80-9391','PS1372')
,('756-30-7391','PS1373')
,('899-46-2035','PS2091')
,('998-72-3567','PS2092')
,('998-72-3567','PS2106')
,('172-32-1176','PS3333')
,('486-29-1786','PS7777')
,('807-91-6654','TC3218')
,('648-92-1872','TC4203')
,('267-41-2394','TC7777')
,('472-27-2349','TC7778')
,('672-71-3249','TC7779')
;  

select*from libroautor_1
order by autor_id;

drop table libroautor;  -- borre la tabla que estaba mal que tenia datos duplicados y triplicados

alter table libroautor_1
rename libroautor;         -- renombre mi copia 

##          LOCALES

select*from locales order by local_id;

create table locales_1
select *from locales limit 1;

select*from locales_1 order by local_id;

delete from locales_1;

insert into locales_1 ( local_id, nombre, direccion, ciudad, provincia, c_postal)
select distinct (local_id),nombre, direccion, ciudad, provincia, c_postal from locales;



/*
insert into libros_1(libro_id, titulo, categoria, editorial_id, precio, comentarios, fecha_publicacion)
	select distinct(libro_id),titulo, categoria, editorial_id, precio, comentarios, fecha_publicacion from libros;

*/

alter table locales_1 add primary key (local_id);

drop table locales;

alter table locales_1 rename locales;

###       puestos

select*from puestos order by puesto_id;   --  otra con datos repetidos
 create table puestos_1 select*from puestos limit 1;
 select*from puestos_1 order by puesto_id;
 delete from puestos_1;
 alter table puestos_1 add primary key (puesto_id);
 insert into puestos_1 (puesto_id, descripcion) 
	select distinct (puesto_id),descripcion from puestos;
  
drop table puestos;
  
alter table puestos_1 rename puestos;

#######ventas################


select*from ventas order by local_id;   --  otra con datos repetidos
 create table ventas_1 select*from ventas limit 1;
 select*from ventas_1 order by local_id;
 delete from ventas_1;
 alter table ventas_1 add primary key (local_id);
 insert into ventas_1(local_id, factura_nro, fecha, cantidad, forma_pago,libro_id) 
	select distinct (local_id),factura_nro, fecha, cantidad, forma_pago,libro_id from ventas;
  
  /*
insert into libros_1(libro_id, titulo, categoria, editorial_id, precio, comentarios, fecha_publicacion)
	select distinct(libro_id),titulo, categoria, editorial_id, precio, comentarios, fecha_publicacion from libros;

*/
  
  #15/12/21-- REVISAR QUE NO PUDE CARGAR LOS DATOS
  #ERROR 1062
  
#drop table ventas;
  
#alter table puestos_1 rename puestos;

#######################CLASE 5#####################################
-- conexiones

-- DIAGRAMA ENTIDAD RELACION EER DIAGRAM
-- INGENIERIA HACIA ADELANTE
-- desde el modelo en el menu /database/forweaerd engeneer
-- REVERSE ENGENIE
-- menu databaase/ingenieria inversa
-- primary key virtual.
-- doble click sobre tabla desde diagrama
-- tildar "PK"
-- clave foranea
-- clave primaria puede ser clave foranea
-- UML LENguaje de modelado---
-- alteramos tabla empleados agregando una restriccion, una clave foranea
-- 
 -- doble clik sobre la tabla (desde el diagrama),en el menu de abajo entro ala pestaña
 -- foregein key y asi creo relaciones entre tablas
 
 -- GRAFICO15112--
 
 /*CLAVE FORANEA/relacion clave primaria y clave foranea
 
 1°darle doble click a la tabla,
 2°darle nombre _fk a l relacion
 3°luego donde va a estar la referencia principal
 4° muestra lista de filas de la tabla ventas
 5°con cual fila de locales va a estar relacionaDA
 
 --patita gallo clave foranea
 -- lineas punteadas clave foranea con primary key
 -  lineas enteras xq son primary key y clave foranea
 - relacionan primario a secundario, o primario a primario (LEER UML-lenguaje universal de modelado)
 
 - cualquier cambio en la clave principal va a alterar las foraneas
 - no hay clave foranea sin clave principal
 
 */
 
 ###  FORWARD INGENIEREE 
 
 /*  al contrario de 
 crea el SCRIPT ORIGINAL PARA CREAR NUESTRA BASE DE DATOS
 creo el modelo , creo las relaciones y me hago aca un script
 
 -- NOSOTROS HICIMOS DATABASE FIRST
 
 CREAR BASE DE DATOS DESDE MODELO
 
 
 ##       CREAr clave foranea con codigo
 
 -- ALTERAR TABLA EMPLEADOS AGRGANDO RESTRICCION nombre que va a tener la relacion
 -- CLAVE FORAREAN(campo que va a tener la clave foranea) QUE CAMPO 
 --VA A TENER LAfk  referencia 
 -- cual tabla tiene la clave principal y el campo que tiene la clave princiupal
 -- ante cualquier cambio en la clave principal se tiennen que reflejar en las foraneas
 -- SINO SE PIEREDE INTEGRIDAD REFERENCIAL!!!pierdo las referencias
 -- 
 
 ## 
alter table empleados add constraint puesto_id_FK
foreign key (puesto_id) references puestos(puesto_id)
on update cascade     
on delete cascade;

##
sabiendo que no puede existir un hijo sin el pdre, desapareceen todos los regisstros de claves foraneas si la clave principal
desparece
se van a actualizar en cascada los datos foraneos



*/


##################CLASE 6 -UNIONES Y JOINES##################




alter table empleados add constraint puesto_id_FK
foreign key (puesto_id) references puestos(puesto_id)
on update cascade
on delete cascade;
/*
 CAMBIAR UN NUMERO DE PUESTO EL 99 POR EL 19
 
 -- update puestos set puesto_id=19
	where puesto_id=99;
 
(PARA ESO ES EL "ON UPDATE" PARA QUE NO ME ROMPA LAS RELACIONES Y SI CAMBIA LA PRINCIPAL LAS DEMAS LAS FORANEAS
TMBIEN CAMBIAN)

SE RECOMIENDA SIEMPRE DEJARLO EN CASCADA PARA TRENER UNA BASE LIMPIA

MUY IMPORTANTE LA CLAVE FORANEA PARA MANTENER LA BASE LIMPIA
*/

##  SELECT/ CONDICIONAL CASE 
/* esto lo usariamos como ayuda cuando nos faltan definir datos, en realidad lo ideal seria tener otra tabla
con los datos de codigo para cada provincia como un id_prov y que corresponda a cada provincia un numero
 -y asi nos evitamos hacer el case
no es normal usar , pero es una herramienta 
*/

select*, replace(provincia, 'ER', 'entre rios') from autores;

select *,
case
	when provincia='ER' then 'entre rios'
    when provincia='CH' then 'chaco'
    when provincia='R' then 'rio negro'
    else 'sin identificar' end
    as 'info sobre provincias' from autores;

#cuando tenemos consultas y tenemos informacion en varias tablas y necesito consultar en varias tablas
## UNION / 

/*
cuando tenemos consultas y tenemos informacion en varias tablas y necesito consultar en varias tablas
la consulta de union sirve para unir dos consultas,consultar la tabla 1 y la tabla historica de la tabla 1
por ejemplo . porque al ser tan grasndes las consultas y se deben pasar a historico y las consultas no sean tan largas en tiempo
enestructura son exactamente iguales, copio la estuctura de la original
-MUY IMPORTANTE debem tener la misma cantidad de campos
con dos select deberia mostrarlas juntas, para poder agregarle empleados activos y empleados de baja
-primero vamos a preparar que vamos a unir
-copia tabla empleados con otro nombre, creando y seleccionnado a la vez
*/


create table empleados_hist
select*from empleados;
select *from empleados_hist;

#vamos a poner una b _adelante de dcada id para tenerlos diferenciados
#usamos un UPDATE, concatenendo 

select empleado_id, concat('B_',empleado_id) as concatenado from empleados;  -- 'A-C71970F', 'B_A-C71970F'


#es lo mismo que me deberia devolver usando el UPDATE
SET SQL_SAFE_UPDATES = 0;  -- para que me permita porque me tiro un "safe update"

update empleados_hist
	set empleado_id=concat('B_',empleado_id); -- 1:14 me tira una ADVERTENCIA !!!, ya que se produjo un DATA TRUNCATED, o sea se corto
                                                -- la palabra por el limite que tenia -- :( UU LO HICE DOS VECES Y ME LO REPEITIO DOS VECES
                                                -- 'B_B_A-R89', 'Annette', 'Roulet', '6', '9999', '1990-02-21 00:00:00'
#IMPORTANTE!! HACER UN select , PARA SABER  ANTES DE HACER ESTO, CONTAR CUANTOS CARACTERES TIENE Y CUANTOS ME PERMITE EL CAMPO!!!!

/*
        IMPORTANTE!! UNA EXCELENTE PRACTICA  
toda accion en una base de datos EMPIEZA UNA TRANSACCION , deberia 
comenzar y terminar sino produciria un cuelgue en la
base de datos, laburo de la memoria , no se termina mas, Y DEBERIA SABER CUANDO TERMINA 
PARA ESO EXISTE (1:17)
 begin "trand" ?(comenzar una transaccion)
 UNA VEZ QUE LA HAGO( HACEMOS EL UPDATE)
 HAGO UN SELECT SI TODO QUEDO COMO YO QUERIA(mirando al futuro)
 determino con 
 commit(CONFIRMAR lo que estoy haciendo esta bien y esta como quiero
 commit trand commit teo) y ahi queda finalizado
 Y SI NO ESTA COMO PRETENDO HAGO
 rollback(volver atras lo que estoy haciendo)
 
 ESTA ES UNA BUENA PRACTICA SOBRE TODO ACTUALIZACIONES Y ELIMINACION!!!
*/

#AGREGANDO FECHA  DE BAJA
update empleados_hist
set fecha_ingreso = current_date();  -- me tira un safe update copio o corro el codigo para q me permita hacer el update

select*from empleados_hist;

#cambio de nombre a la columna ------ USSAMOS CHANGE PARA CAMBIAR NOMBRE 
#DE COLUMNA/CAMPOS , RENAME ES PARA CAMBIAR NOMBRE DE TABLAS O VISTAS

alter table empleados_hist change fecha_ingreso fecha_baja datetime;

#uso union para que me una dos CONSULTAS, dentro de fecha_ingreso puso las de baja xq toma la primera
select*from empleados
union
select*from empleados_hist;   

#union no muestra valores repetidos o duplicados

insert into empleados_hist 
values
('A-C71970F', 'Aria', 'Cruz', '10', '1389', '1991-10-26 00:00:00');

# para que me muestre los duplicados uso UNION ALL y ordenados

select*from empleados
union all
select*from empleados_hist
order by empleado_id;  

#si quiero que me muestre  ese empleado y cambiarle un dato, como la fecha de ingreso

update empleados_hist
set fecha_baja = current_date()
where empleado_id = 'A-C71970F';


#aplico un filtro

select*from empleados
where empleado_id ='A-C71970F'
union all
select*from empleados_hist
where empleado_id ='A-C71970F';  


##  INNER JOIN

/*hasta ahora solo fueron consultas individuales
como el motor no ve las relaciones entre tablas , 
yo se las tengo que indicar
 las tablas suelen bloquearse, si yo hiciera
   select*from puestos , empleados;
esto provocaria un bucle que mme convinaria por cada un dato de una tabla todos los
de la otra
 1millon de datos por una tabla de un millon seria algo extremadamente peligroso 
 para el desmpeño de el motor de la tabla
 - ejemplo de grafico union SQL server
 y yo quiero que me devuelva la interseccion de esos dos conjuntos, cada conjunto representaria un 
 una tabla. 
 
 
*/

# voy a traer solo las coincidencias, joinneamos ambas tablas
select*from puestos, empleados
where puestos.puesto_id = empleados.puesto_id;  -- tabla.campo=tabla.campo


#restringimos algunas columnos

select descripcion,empleado_id, nombre, apellido, editorial_id, fecha_ingreso from puestos, empleados
where puestos.puesto_id = empleados.puesto_id;

#

select descripcion,empleado_id, nombre, apellido, editorial_id, fecha_ingreso 
from puestos
inner join empleados
on puestos.puesto_id = empleados.puesto_id;

select titulo,categoria,precio,fecha_publicacion, nombre, ciudad, provincia,pais
from libros
inner join editoriales 
on libros.editorial_id=editoriales.editorial_id;

#AMBIGUOS es porque se repiten nombres de campos

# AS alias se lo damos a cada nombre una abreviatura
select titulo,categoria,precio,fecha_publicacion, nombre, ciudad, provincia,pais
from libros li
inner join editoriales ed
on li.editorial_id=ed.editorial_id;

#cuando nos tendremos que valer de la tabla intermedia para unir estas dos tablas por autores
#joineamos varias tablas y quiero que me muestre todas las que pertenecen al autor "adolfo"
select titulo,categoria,precio,fecha_publicacion, ed.nombre, 
ed.ciudad, ed.provincia,ed.pais, li.libro_id, au.autor_id, titulo, 
au.nombre, ve.local_id, ve.factura_nro, ve.local_id, lo.direccion, lo.c_postal
	from libros li
	inner join editoriales ed on li.editorial_id=ed.editorial_id
	inner join libroautor la on la.libro_id= li.libro_id
	inner join autores au on au.autor_id = la.autor_id
    inner join ventas ve on ve.libro_id = ve.libro_id
    inner join locales lo on lo.local_id = ve.local_id
    where au.nombre = 'adolfo';









-- IMPORTANT!!
-- RUN-- CTRL+ENTER
/*gfjhoijfoghghkgjhkljgfhlkjfhjlkgfjhlkh
COMENTARIO DE DOS LINEAS O MAS, sino puedo usar "-- ewspacio" o "#" gkhfhghufgkdf  
-- limpiar pantalla inferior boton derecho /clear--
-- CLAVE PRIMARIA-- NOacepta duplicados, y tamploco se puede creae primary key con datos duplicados o anexados
* borrar datos pantalla abajo (x) del nombre de la tablita
* COPIO Y PEGO , click derecho copy row y pego ctrl+v 

ERRORES
-- ERROR 1136 COLUMN COUNT DOESN'T MATCH VALUE COUNT AT ROW 1---error 1054 unknown column ---SOLUCION:
-- TENGO 3L PROBLEMA DE QUERER CREAR TABLA INTERMEDIA , tengo dod columnas id y una primary key no me deja descargarle los datpos, sera autoincrement¡

-- error 1054
*/
#####################################################





