#!/bin/bash

if [ "$1" == "-d" ];then
    echo "Eliminando entorno"
    pkill -f "$HOME/EPNro1/consolidar.sh"
    rm -rf "$HOME/EPNro1"
    echo "Entorno eliminado"
fi

export FILENAME="archivo"
seguir=true

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

read -p "Ingrese una opción:" opcion

if [ -z "$opcion" ];then
   echo "No ingresaste ninguna opción"

else
    case $opcion in
      1)

         mkdir -p "$HOME/EPNro1/entrada" "$HOME/EPNro1/salida" "$HOME/EPNro1/procesado"

         for f in "$HOME"/{archivo1.txt,archivo2.txt,archivo3.txt}; do
             if [ -f "$f" ];then
                 cp "$f" "$HOME/EPNro1/entrada/"
             fi
         done

         cp "$HOME/consolidar.sh" "$HOME/EPNro1/"

         echo "Entorno creado"

      ;;

      2)
         if [ ! -d "$HOME/EPNro1" ];then
             echo "Cree primero el entorno en la opción 1"

         elif [ -z "$FILENAME" ];then
               echo "ERROR: La variable no está definida"

         else

             bash "$HOME/consolidar.sh" &

             echo "Proceso corriendo en background"
         fi
      ;;

      3)
         if [ -z "$FILENAME" ];then
             echo "ERROR: No se está definida la variable"

         elif [ ! -f "$HOME/EPNro1/salida/$FILENAME.txt" ];then
               echo "ERROR: No existe el archivo final, ingrese primero la opción 2"
         else
               sort -k1,1n "$HOME/EPNro1/salida/$FILENAME.txt"

         fi
      ;;

      4)
         if [ -z "$FILENAME" ];then
             echo "ERROR: No está definida la variable"

         elif [ ! -f "$HOME/EPNro1/salida/$FILENAME.txt" ];then
             echo "ERROR: No existe el archivo final, ingrese primero la opción 2"
         else
             sort -k5,5nr "$HOME/EPNro1/salida/$FILENAME.txt" | head -n 10

         fi
      ;;

      5)
         if [ -z "$FILENAME" ];then
             echo "ERROR: No está definida la variable"

         elif [  ! -f "$HOME/EPNro1/salida/$FILENAME.txt" ];then
               echo "ERROR: No existe el archivo final. ingrese primero la opción 2"

         else
               read -p "Ingrese número de padrón:" padron
               grep "$padron" "$HOME/EPNro1/salida/$FILENAME.txt"
         fi
      ;;

      6)
         seguir=false
         echo "Saliendo..."
      ;;
 esac
fi

done
