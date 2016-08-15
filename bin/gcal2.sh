#!/bin/bash
arrowrt='C'
arrowleft='D'
arrowup='A'
arrowdown='B'

month=0
year=0

quit=0
while [ $quit -eq 0 ] 
do
  clear
  cal -d $(date --date="now $month month $year year" +"%Y-%m")
  read -r -sn1 t
  case $t in
    $arrowup)    year=$(expr $year  + 1) ;;
    $arrowdown)  year=$(expr $year  - 1) ;;
    $arrowrt)   month=$(expr $month + 1) ;;
    $arrowleft) month=$(expr $month - 1) ;;
    $'\e'|[)    ;; 
    *) quit=1   ;;
  esac
done

