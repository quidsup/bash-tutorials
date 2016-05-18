#!/bin/bash
#Name: Bash Tutorial 6 Arrays
#Description: Tutorial shows how to declare and use Numeric and Associative Arrays
#Video: 


#Global array
declare -A AssociativeArray #Array index is in named form
declare -a NumericArray #Array index is in numeric form


#Local array
function Foo() {
  local -a LocalArray #Numeric array which only exists in this function
  
  #Set a specific point in the array for each value
  LocalArray[0]="Hi"
  LocalArray[1]="There"
  LocalArray[9]=15  #No need to be consecutive or a string
  
  #Read specific values
  echo "${LocalArray[0]} ${LocalArray[1]}" #Hi There
  
  #Read entire array
  echo "${LocalArray[@]}" #Hi There 15
}

#Call function Foo
Foo
echo "Local Array ${LocalArray[@]}" #Nothing, as the array doesn't exist outside of Function Foo
echo

#Set values in Associative Array
AssociativeArray[Var1]="Var1"
AssociativeArray[Var2]="Var2"

#Check if values exist in Associative Array
if [ "${AssociativeArray[Var1]}" ]; then
  echo "Var1 exists"
else
  echo "Var1 does not exist"
fi

if [ "${AssociativeArray[Var3]}" ]; then
  echo "Var3 exists"
else
  echo "Var3 does not exist"
fi

#Add string into Numeric Array
NumericArray+=("All work")
NumericArray+=("and no play")
NumericArray+=("makes Jack a dull boy")

echo "Writing NumericArray to File /tmp/test.txt"
printf "%s\n" "${NumericArray[@]}" > /tmp/test.txt

echo
echo "Reading File /tmp/test.txt"
cat /tmp/test.txt
