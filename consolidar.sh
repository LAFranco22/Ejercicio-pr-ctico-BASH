#!/bin/bash

## Si la variable no está vacía... recorre archivos txt
if  [ -n "$FILENAME" ];then

     for archivo in "$HOME/EPNro1/entrada/"*.txt;
     do

## Si el archivo existe, lo agrega al archivo final y luego lo mueve a procesado.
         if [ -e "$archivo" ];then

             cat "$archivo" >> "$HOME/EPNro1/salida/$FILENAME.txt"

             mv "$archivo"  "$HOME/EPNro1/procesado"
         fi
     done

fi

