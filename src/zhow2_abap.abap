report zhow2_abap.

include zhow2_top. "Aquí declaramos las variables globales (saltar al incio)

" Lo primero, a mi me gusta escribir todo en minúsculas, no hace falta chillarle a la máquina.
" Si quieres escribir un programa en MAYUSCULAS, sientete libre, pero el que empieza manda.
" Un programa está o todo en mayúsculas o todo en minúsculas.
" Ya mezclamos idiomas, no hace falta más :)

" Tipos primitivos:

data: l_string   type string, "Cedena de inf. caract.
    l_int      type i,      "Entero 16bits (creo)
    l_char(20) type c,      "Char de 20 caract
    l_char2(20)             "Esta declarcacion es igual a la anterior
    l_bool.                 "Los booleanos son chars de 1 caracter 
                              "'X' -> true 
                              "' ' -> false

  "Por supuesto, tenemos decimales, pero lo normal es utilizar tipos existentes.
  data: l_cantidad type mengv13. "Campo numérico de long 10 con 3 dec.
  "Las varibles las acompañamos de l_* por convención. 
  
  
  "Tabién tenemos tipos compuestos, llamados ESTRUCTURAS 
  "Podemos utilizar estructuras existentes.
  data: lt_mara type mara.
  
  " O definirlas.
  
  types: begin of t_persona,
    pernr  type pernr_d,
    nombre type ename,
    end of t_persona.
  
  data: l_persona type t_persona.
  
  "Podemos acceder a los campos dentro de una estructura.
  lt_mara-matnr = 'MAT_PRUEBA'.
  l_persona-pernr = '888010'.
  l_persona-nombre = 'Nuevo empleado'.
  
  "También podemos declarar tablas:
  data: i_persona  type table of t_persona, "Utilizamos type si hacemos ref. a un tipo
        i_persona2 like table of l_persona. "Utilizamos like si hacemos ref. a una var.
  
  "También va al revés:
  type: tt_persona type table of t_persona.
  
  data l_persona2 type line of tt_persona. "Si no escribo : después del data, solo puede declararar 1 variable.

"El índice es una cadena de 'métodos' en abap lo llamamos FORMS o subrutinas
" Puedes navegar haciendo doble clic en el nombre, y F3 para retroceder. (casi todo es navegable, puedes probar)


perform how_to_data. "Declaración de varibles.

perform hot_to_conditionals. "Condicionles.

form how_to_data.
  "Varibles dinámicas
  data(l_nombre) = l_persona-nombre. "Crea una var de tipo ename y le asigna el valor

  data: l_mara type mara.

  "Selects
  select * into l_mara
    from mara
   where matnr = 'Z*'.
    "el select -> endselect nos permite iterar sobre los resultados de una tabla.
    "no es recomendable, ya que mientras está dentro del bucle, la tabla queda bloqueada
  endselect.

  data: i_mara type table of mara.
  select * into table i_mara
    from mara
   where matnr = 'Z*'.
  loop at i_mara into l_mara.
    "Esta es la alternativa óptima si accedes a tablas ámpliamente utilizadas por otros programas
  endloop.

  "Si accedemos por clave, lo normal es hacer un SELECT SINGLE y así evitamos declarar el tipo tabla.
  select single * into l_mara
    from mara
   where matnr = 'ZPRUEBA'.
  
  "vamos a mover datos entre estructuras:
  data: begin of l_my_mara,
          matnr type matnr,
          matkl type matkl,
          meins type meins,
          menge type mengev13,
        end of l_my_mara.

  "Existe la sentencia move-corresponding, que asiganará a la variable destino, los campos que compartan nombre con el origen.
  clear: l_my_mara. "Es conveniente limpiar la variable antes del move-correponding,
                    "ya que puede mantener valores si la estructura destino tiene campos no existentes en la origen
  move-corresponding l_mara to l_my_mara.
  "el campo l_my_mara-menge, no se informará, ya que no existe en l_mara

  "Haz F3 para volver al indice ;)
endform.

form how_to_data2.
  l_persona2 = value #(
    pernr = '123456'
    nombre = 'Persona 2'
  ). "Infiere el tipo directamente

  data(l_persona3) = value t_persona(
    pernr = '654321'
    nombre = 'Persona 3'
  ). "Como estamos declarando la variable, tenemos que decirle el tipo

  i_persona = value #( l_persona l_persona2 l_persona3 ).

  i_persona2 = value #( ( pernr = '00001' nombre = 'Nueva persona' ) ).
  append value #( pernr = '00002' nombre = 'Nueva persona 2' ) to i_persona2.

  " Operador CONV - Trata de convertir los valores de tipo.

  data l_entero type i.

  l_entero = conv #( l_persona2-pernr ).
  data(l_entero2) = conv i( l_pernsona3-pernr ).
  "Las variables declaradas dentro de un form, no se pueden acceder desde fuera.

  data: begin of l_my_mara,
          matnr         type matnr,
          matkl         type matkl,
          unidad_medida type meins,
          menge         type mengev13,
        end of l_my_mara.

  select single * into @data(l_mara)
    from mara
   where matnr = 'ZPRUEBA'.

  "La sentencia CORRESPONDING es la versión moderna del move-corresponging,
  "podemos definir mappings entre nombre de variables.
  l_my_mara = corresponding #( l_mara mapping menge = unidad_medida ).

  
endform.

form how_to_conditionals.
  "Las condiciones las encadenamos con AND y OR
  if 1 = 1 and 1 = 2 or 'X' = 'X'.

  elseif 1 < 2.
  
  else.

  endif.

  "La keyword CHECK hace un if (condicion) return; 
  check 'X' = 'X'. "Si se satisface la condición, deja pasar, si no, aborta la ejecución del código
  "Evitar utilizar el check trozos de código largo.

  "Si lo utlizamos dentro de un loop, pasamos a la siguiente iteración.
  loop at i_material into data(l_material).
    check l_material-matnr is initial.
    write:/ 'El material está sin inicialiar'.
    exit. "Para abortar la ejecución de un bucle, utilizaremos EXIT
  endloop.

  data(l_property) = 3.
  case l_property.
    when 1:
      "No hace poner break; si entra en una condición pasa de las demás
    when 2 or 3:
      "Podemos encadenar opciones
    when others:
      "Caso por defecto
  endcase.

  "Otros bucles:
  do.

  enddo.
endform.