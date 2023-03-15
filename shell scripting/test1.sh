#!/bin/bash

#clear the screen
#clear

#prompt for a number
echo
read -p "Enter a number between 1 and 100: " a
echo
if [ $a -ge 75 ]; then
    echo $a "is greater than or equal to 75."
elif [ $a -ge 50 ]; then
    echo $a "is greater tahn or equal to 50."
else
    echo $a "is less than 50."
fi
echo

for TIMER in 0 1 2 3 4 5 
do
    echo "Count Up: " $TIMER
done
