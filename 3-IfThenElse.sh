#!/bin/bash
#Name: Bash Tutorial 3 - If Then Else
#Description: Tutorial shows how to use If, Then, Elif, and Else
#Author: Quidsup
#Video: https://youtu.be/uYDxQ5L8zqE

#Basic Menu
echo "What would you like to do today? "
echo "1. Have a beer"
echo "2. Go to work"
read Idea
echo

if [[ $Idea == 1 ]]; then
  echo "Excellent choice"
elif [[ $Idea == 2 ]]; then
  echo "Boring"
else
  "Eh what now?"
fi

#Not Equal
if [[ 0 != 1 ]]; then
  echo "Zero is not equal to One"
fi

#Arithmetic Comparison - Use Within double parantheses (( ... ))
Num1=10
Num2=5

if (( $Num1 > $Num2 )); then
  echo "$Num1 is greater than $Num2"
else
  echo "$Num2 is less than or equal to $Num2"
fi


#Logical AND
Var1=1
Var2=1
Var3=0
if (( $Var1 && $Var2 )); then
  echo "Both Var1 and Var2 are True"
else
  echo "Either Var1 or Var2 is False"
fi

#Logical OR (Alternate if statement)
if [[ $Var 2 == 1 ]] || [[ $Var3 = 1 ]]; then
  echo "Either Statement is True"
else
  echo "Both Statemetns are False"
fi


#Check if a File exists
#-d Directory
#-f File
#-e Either File or Directory

FileName="$1"
if [ -f FileName ]; then
  echo "File exists"
else
  echo "File does not exist"
fi



