#!/bin/bash

## Si la variable no está vacía... recorre archivos txt
if  [ -n "$FILENAME" ];then

     for archivo in "$HOME/EPNro1/entrada/"*.txt
     do

## Si existe archivo o carpeta, los junta y los mueve a los archivos ya procesados.
         if [ -e "$archivo" ];then

             cat "$archivo" >> "$HOME/EPNro1/salida/$FILENAME.txt"

             mv "$archivo"  "$HOME/EPNro1/procesado"
         fi
     done

fi

