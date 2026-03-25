#!/bin/bash
##Verifica si el usuario ejecutó el script con -d.
if [ "$1" == "-d" ];then
    echo "Eliminando entorno"
    
##Si lo hizo,  mata los procesos en background.
    pkill -f "$HOME/EPNro1/consolidar.sh"
    
##Borra toda la carpeta.
    rm -rf "$HOME/EPNro1"
    echo "Entorno eliminado"
fi

## Define una variable global con el nombre del archivo de salida.
export FILENAME="archivo"
seguir=true

## Mientras la variable seguir sea true, se repite el menú.
while $seguir;
do

echo "-----MENÚ-----"
echo "1) Crear entorno"
echo "2) Correr proceso"
echo "3) Listado de alumnos"
echo "4) Las diez notas más altas"
echo "5) Mis datos"
echo "6) Salir"
echo "-d) Borrar entorno y terminar los procesos en el background"

##Guarda lo que escribió el usuario.
read -p "Ingrese una opción:" opcion

##Si no escribió nada, lanza un mensaje de error.
if [ -z "$opcion" ];then
   echo "No ingresaste ninguna opción"

##Si ingresa una opción, la ejecuta.
else
    case $opcion in
      1)
## Crea carpetas de entrada, salida y procesado.
         mkdir -p "$HOME/EPNro1/entrada" "$HOME/EPNro1/salida" "$HOME/EPNro1/procesado"

## Recorre los archivos.
         for f in "$HOME"/{archivo1.txt,archivo2.txt,archivo3.txt}; do
         
## Si existen, los copia a la entrada.
             if [ -f "$f" ];then
                 cp "$f" "$HOME/EPNro1/entrada/"
             fi
         done
         
## Copia el archivo consolidar desde mi carpeta a EPNro1.
         cp "$HOME/consolidar.sh" "$HOME/EPNro1/"

         echo "Entorno creado"

      ;;

      2)
## Si no existe el entorno, muestra mensaje de advertencia.
         if [ ! -d "$HOME/EPNro1" ];then
             echo "Cree primero el entorno en la opción 1"
             
## Si la variable se encuentra vacía, lanza error.
         elif [ -z "$FILENAME" ];then
               echo "ERROR: La variable no está definida"
               
## Ejecuta el script consolidar.sh en segundo plano (background).
         else

             bash "$HOME/consolidar.sh" &

             echo "Proceso corriendo en background"
         fi
      ;;

      3)
## Si la variable está vacía, pide definirla. 
         if [ -z "$FILENAME" ];then
             echo "ERROR:La variable no está definida"
             
## Si no existe el archivo imprime mensaje de error.
         elif [ ! -f "$HOME/EPNro1/salida/$FILENAME.txt" ];then
               echo "ERROR: No existe el archivo final, ingrese primero la opción 2"

## De otra manera, ordena por padrón.
         else
               sort -k1,1n "$HOME/EPNro1/salida/$FILENAME.txt"

         fi
      ;;

      4)
## Si la variable está vacía, error.
         if [ -z "$FILENAME" ];then
             echo "ERROR: No está definida la variable"

## Si no existe el archivo, error.
         elif [ ! -f "$HOME/EPNro1/salida/$FILENAME.txt" ];then
             echo "ERROR: No existe el archivo final, ingrese primero la opción 2"

## De otra manera, ordena por nota de mayor a menor, mostrando los primeros 10.
         else
             sort -k5,5nr "$HOME/EPNro1/salida/$FILENAME.txt" | head -n 10

         fi
      ;;

      5)
## Si no está definida la variable, error.
         if [ -z "$FILENAME" ];then
             echo "ERROR: No está definida la variable"
             
## Si no existe el archivo final, error.
         elif [  ! -f "$HOME/EPNro1/salida/$FILENAME.txt" ];then
               echo "ERROR: No existe el archivo final. ingrese primero la opción 2"

## Solicita el número de padrón al usuario.
         else
               read -p "Ingrese número de padrón:" padron

## Busca líneas que contengan el padrón ingresado.
               grep "$padron" "$HOME/EPNro1/salida/$FILENAME.txt"
         fi
      ;;

      6)
## Cambia la variable seguir a false para finalizar el programa.
         seguir=false
         echo "Saliendo..."
      ;;
 esac
fi

done
