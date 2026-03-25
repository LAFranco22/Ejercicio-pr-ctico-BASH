#!/bin/bash


if  [ -n "$FILENAME" ];then

     for archivo in "$HOME/EPNro1/entrada/"*.txt
     do

         if [ -e "$archivo" ];then

             cat "$archivo" >> "$HOME/EPNro1/salida/$FILENAME.txt"

             mv "$archivo"  "$HOME/EPNro1/procesado"
         fi
     done

fi

