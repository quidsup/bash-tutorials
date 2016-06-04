#!/bin/bash
#Name: Bash Tutorial 2 - Variables
#Description: Tutorial shows how to declare and use Variables
#Author: Quidsup
#Video: https://youtu.be/FLUYFP7ezqc

#Read an Input from Keyboard
echo -n "What is your name? "
read Name
echo
echo "Hello there $Name"
echo "Press any key to continue..."
read -rn1

#Results back from system commands
echo "You are running $(lsb_release -sd) with kernel $(uname -r)"

#Integers with some maths
a=2
b=5
a=$((a * b))
let "a+=1"
echo "a = $a"                                                  #a = 11

#Concatenating Strings
c="Hello "
c+="World"
echo "$c"

#Alternate Method of Concatenating Strings
d="Messing"
d=${d}"with alternate methods"
echo
echo "$d"

#Substrings
Str="abcdefghij
echo "Str is: $Str"                                             #abcdefghijk
echo "After the first three characters: ${Str:3}"               #defghijk
echo "Four characters long from the fourth character: {Str:3:4} #defg
echo "Last two characters: ${Str:-2}"                           #ij
echo "Str is:" `expr length $Str` "characters long"             #10
