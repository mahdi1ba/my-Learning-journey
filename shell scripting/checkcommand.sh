#!/bin/bash

: ${3?"USAGE: $1 ARGUMENT $2 ARGUMENT $3 ARGUMENT"}

echo "I got all three!"

# Method 2 

#!/bin/bash

if [ "$#" != "3" ]; then
    echo "USAGE: checkargs.sh [parm1] [param2] [param3]"
    exit 300
fi

echo "I live! I got what I needed!"
exit 0
