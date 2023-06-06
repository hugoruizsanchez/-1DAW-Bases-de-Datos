
/*


/*
La sentencia DECLARE ... HANDLER en MySQL se utiliza para definir cómo se manejarán ciertos eventos o errores en una declaración SQL. Básicamente, permite al programador definir un controlador (handler) para manejar eventos específicos que puedan ocurrir durante la ejecución de una declaración SQL.

La sintaxis básica de la sentencia DECLARE ... HANDLER es la siguiente:
*/

DECLARE handler_action HANDLER FOR condition_value statement

/*
Donde:

    handler_action: es el tipo de controlador que se está definiendo. Puede ser uno de los siguientes valores: CONTINUE, EXIT, o UNDO. Cada uno de estos valores indica cómo se debe manejar el evento si ocurre.
    
	condition_value: es el código de error o evento que se está manejando. Por ejemplo, si se desea manejar el error 1062 (clave duplicada), este valor sería 1062.
    
	statement: es la instrucción SQL que se ejecutará si se produce el evento o error especificado en condition_value.

A continuación, un ejemplo de cómo se puede utilizar la sentencia DECLARE ... HANDLER en una consulta SQL:
*/

DECLARE mi_primer_handler CONTINUE HANDLER FOR 1062 SELECT 'Error: clave duplicada';

/*
En este ejemplo, se está definiendo un controlador llamado mi_primer_handler que se encargará de manejar el error 1062 (clave duplicada) si ocurre durante la ejecución de una consulta SQL. El controlador se define para continuar con la ejecución de la consulta (CONTINUE) y ejecutar la sentencia SELECT 'Error: clave duplicada'; en caso de que se produzca el error.

Es importante tener en cuenta que la sentencia DECLARE ... HANDLER solo se puede utilizar dentro de un bloque de código almacenado (stored code block) en MySQL, como un procedimiento almacenado o una función. Esta sentencia no se puede utilizar en consultas SQL regulares o en sentencias preparadas.

Además, es importante señalar que la sentencia DECLARE ... HANDLER solo manejará errores y eventos que se produzcan dentro del bloque de código en el que se define. Si se necesita manejar errores fuera de este bloque de código, se debe definir otro controlador en el contexto adecuado.

En resumen, la sentencia DECLARE ... HANDLER es una herramienta útil para manejar errores y eventos específicos en un bloque de código almacenado en MySQL. Al definir un controlador para un evento o error en particular, se puede personalizar el comportamiento de la aplicación en caso de que se produzca ese evento o error durante la ejecución del bloque de código.
*/ 

DECLARE CONTINUE HANDLER FOR SQLSTATE '42S02' BEGIN
   -- Introducir código que se ejecutará para el error aquí. 
END;
DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN
   -- Introducir código que se ejecutará para el error aquí. 
END;
DECLARE UNDO HANDLER FOR SQLEXCEPTION BEGIN
   -- Introducir código que se ejecutará para el error aquí. 
END;

/*
El SQLSTATE es el error general que SQL alberga para varios sistemas de bases de datos, un "idioma común" entre los administradores de bases de datos. Esta es la diferencia con respecto a un error típicamente numérico, 
*/

/*
Este código es una estructura de manejo de errores en MySQL. Permite manejar diferentes tipos de errores que pueden ocurrir durante la ejecución de una sentencia SQL, y proporciona una forma de controlar lo que sucede cuando se produce un error específico.
*/

/*
Este código es una estructura de manejo de errores en MySQL. Permite manejar diferentes tipos de errores que pueden ocurrir durante la ejecución de una sentencia SQL, y proporciona una forma de controlar lo que sucede cuando se produce un error específico.
*/

DECLARE handler_action HANDLER 
FOR condition_value [, condition_value] ACCION -- DECLARACIÓN para un código de error concreto (condition_value)
handler_action: CONTINUE -- ACCIÓN que se llevará a cabo si se detecta el error (CONTINUE: continua) (EXIT: finaliza) (UNDO: deshace la sentencia y regresa)
condition_value: { mysql_error_code | SQLSTATE [VALUE] sqlstate_value| condition_name | SQLWARNING | NOT FOUND| SQLEXCEPTION}  

/*
    La declaración del controlador (DECLARE handler_action HANDLER FOR condition_value [, condition_value] ...): Esta es la parte donde se declara el controlador, que es una sección de código que se ejecutará cuando se produzca un error específico. La sintaxis para declarar un controlador es DECLARE handler_action HANDLER FOR condition_value, donde handler_action es una etiqueta que identifica la sección de código que se ejecutará, condition_value es el error o conjunto de errores específicos para los que se manejará la sección de código.

    La acción del controlador (handler_action: { CONTINUE | EXIT | UNDO }): Esta parte define la acción que se llevará a cabo cuando se produzca el error específico. La acción del controlador se declara utilizando la etiqueta handler_action y se puede establecer en una de las tres opciones siguientes:

    CONTINUE: Continúa la ejecución normal de la sentencia SQL.
    EXIT: Termina la ejecución de la sentencia SQL y devuelve un error.
    UNDO: Deshace la sentencia SQL y regresa al estado anterior.

    Los valores de condición (condition_value: { mysql_error_code | SQLSTATE [VALUE] sqlstate_value | condition_name | SQLWARNING | NOT FOUND | SQLEXCEPTION }): Esta parte enumera los diferentes errores que se pueden manejar utilizando la declaración del controlador. Los valores de condición pueden ser:

    mysql_error_code: Un número de error MySQL.
    SQLSTATE [VALUE] sqlstate_value: Una cadena de estado SQL que representa el error.
    condition_name: Un nombre de error definido por el usuario.
    SQLWARNING: Cualquier advertencia SQL.
    NOT FOUND: Se produce cuando una consulta no devuelve ningún resultado.
    SQLEXCEPTION: Cualquier excepción SQL.

En resumen, la estructura de manejo de errores en MySQL proporciona una forma de controlar errores específicos que pueden ocurrir durante la ejecución
*/













