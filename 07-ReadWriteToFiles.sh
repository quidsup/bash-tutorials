#!/bin/bash
#Name: Bash Tutorial 7 Reading / Writing to Files
#Description: Tutorial shows how to Read, Write and Modify data in Files
#Video: https://youtu.be/yo2i7UdNmiY

File="/tmp/test.txt"

#Simple writing to file:
echo "Clear File" > $File
echo "Append Line" >> $File
echo "Lets see the file:"
cat $File


#Alternate method of writing to file using tee
Log="/tmp/log.txt"
if [ ! -e "$Log" ]; then              #Check if file exists
  echo "Creating log file $Log"
  touch $Log                          #Create file if it doesn't exist
fi 

echo "Appending line to log" | tee -a $Log
echo "Appending another line to log" | tee -a $Log
echo "Lets see the file:"
cat $Log


#Writing lots of lines to a file using an array
declare -a TmpWrite
TmpWrite+=("All work and no play makes Jack a dull boy")
TmpWrite+=("All work and no play makes Jack a dull boy")
TmpWrite+=("All work and no play makes Jack a dull boy")
TmpWrite+=("All work and no play makes Jack a dull boy")
TmpWrite+=("All work and no play makes Jack a dull boy")

echo "How does it look with the Array written to file?"
cat $File


#Simple reading of a single value
cat /dev/null > $File   #Zero out file
#cp /dev/null $File     #Alternate method 1
#>$File                 #Alternate method 2

Var1="Hello World"
echo "Var1 = $Var1" > $File
Var1=""

Var1=$(grep Var1 "$File" | cut -d "=" -f2 | xargs) 
echo "Var1 = $Var1"     #Hello World
#Cut -delimeter "=" and take field 2
#xargs is used to Trim whitespace
#This method can be extremally dangerous, since we are trusting user input.
#Never trust user input!!!


#Reading all lines of a file
cat /dev/null > $File   #Zero out file
echo "BlockList_NoTrack = 1 #Main List" >> $File
echo "BlockList_TLD =   1" >> $File
echo "BlockList_AdBlockManager = Zero" >> $File
echo "BlockList_EasyList = 3" >> $File

while read -r Line; do
  echo "$Line"
done < $File


#Reading file using Internal Field Seperator (IFS)
while IFS='= ' read -r Key Value; do
  echo "Key $Key, Value $Value"
done < $File
#Well that still doesn't look good

#Some alternate uses of IFS:
 #while IFS=$' \n' read -r Line                 #Filtering of Unix new line
 #while IFS=$'# \n' read -r Line Comment _      #Data which may contain a comment
 #while IFS=$'\r' read -r Line _                #Windows carriage return
 

#Reading a Config file using IFS and Filtering Values
function FilterInt() {
  #$1 Value to Check
  #$2 Min permitted value
  #$3 Max permitted value
  #$4 Default value
  if [[ $1 == ?(-)+([0-9]) ]]; then
    if [[ $1 -ge $2 ]] && [[ $1 -le $3 ]]; then
      return "$1"
    fi
  fi
  return "$4"
}


BlockList_NoTrack=1          #Set Default values, in case any are missing from File
BlockList_TLD=1
BlockList_AdBlockManager=0
BlockList_EasyList=0

while IFS='= ' read -r Key Value; do
  Value="${Value%%\#*}"                           #Del in line right comments
  Value="${Value%%*( )}"                          #Del trailing spaces
  Value="${Value%\"*}"                            #Del opening string quotes 
  Value="${Value#\"*}"                            #Del closing string quotes 
        
  case "$Key" in
    BlockList_NoTrack)
      FilterInt "$Value" 0 1 1
      BlockList_NoTrack=$?
    ;;
    BlockList_TLD)
      FilterInt "$Value" 0 1 0
      BlockList_TLD=$?
    ;;
    BlockList_AdBlockManager)
      FilterInt "$Value" 0 4 0
      BlockList_AdBlockManager=$?
    ;;
    BlockList_EasyList)
      FilterInt "$Value" 0 2 0
      BlockList_EasyList=$?
    ;;
  esac
done < $File

echo "BlockList_NoTrack = $BlockList_NoTrack"                #1
echo "BlockList_TLD = $BlockList_TLD"                        #1
echo "BlockList_AdBlockManager = $BlockList_AdBlockManager"  #0
echo "BlockList_EasyList = $BlockList_EasyList"              #0  (3 is outside of range)


#Changing a value in a file
if [[ $(grep BlockList_NoTrack "$File") == "" ]]; then
  echo "BlockList_NoTrack = 0" | sudo tee -a $File
else
  sed -i "s/^\(BlockList_NoTrack *= *\).*/\10/" $File
fi
echo "Has value of BlockList_NoTrack changed to zero?"
cat $File
