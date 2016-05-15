#!/bin/bash
#Bash Tutorial 4: Loops
#Written by QuidsUp
#Use with Youtube Video: http://youtu.be/sCmqBkz1yYY

echo "List all files of a specific type in a folder"
for i in $(ls ~/Videos/ | grep .mp4); do
  echo $i
done

echo
echo "Numerical count version of a For loop"
for i in {1..5}; do
  echo "Pass:" $i
done

echo
echo "While Loop"
Count=0
while [ $Count -lt 5 ]; do
  echo "Count is" $Count
  let Count=Count+1
done

echo
echo "Until Loop"
Count=0
until [ $Count -gt 5 ]; do
  echo "Count is" $Count
  let Count=Count+1
done

echo
echo "Infinite loop until 'break' statement"
while [ 1 ]; do
  echo -n "Do you want to leave the loop yet?"
  read Choice
  if [[ $Choice == "y" ]]; then
    break
  fi
done

Loop=1
while [ $Loop -eq 1 ]; do
  echo -n "Do you want to leave the loop yet?"
  read Choice
  if [[ $Choice == "y" ]]; then
    Loop=0
  fi
done
