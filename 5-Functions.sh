#!/bin/bash
#Bash Tutorial 4: Loops
#Written by QuidsUp
#Use with Youtube Video: https://youtu.be/kiEbj_DHB4k

function foo1 {
  echo "Foo1 - A Basic Function"
}

#Input variables into a function
function foo2() {
  echo "Foo2 Function $1 $2"
  echo "All variables parsed to Foo2 $*"
  echo
}

foo1
foo2 "Hi" "There" "Everyone" 2


#Return Variables
function Return_Variable() {
  return $1
  #Bash can only return integer values 0..255
}

Return_Variable 25
Var1=$?
Var2=$? #Won't work because we've just used the return variable

echo "Var1 =$Var1"     #25
echo "Var2 =$Var2"     #0


function Return_Variable2() {
  local Ret=$1  #Local variable which only exists in this function
  let "Ret = Ret - 5"
  return $Ret
}

Return_Variable2 20
Var3=$?
echo "Can we see the Local Variable? $Ret"
echo "Var3 =$Var3"     #15


#Return a value using a Global variable
function Global_Return {
  GlobalRet=0
  let "GlobalRet = $1 + 1"
}

Global_Return 260
echo "GlobalReturn Variable =$GlobalRet"   #261
Global_Return 270
echo "GlobalReturn Variable =$GlobalRet"   #271

