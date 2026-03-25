#!bin/bash

file="/var/log/apache2/access.log"

results=$(cat "$file") # | cut -d'  -f1,7 )

function pageCount(){
echo "$results" | sort | uniq -c
}

function countingCurlAccess(){
results=$(cat "$file" | cut -d' ' -f1,12 | grep "curl" | uniq -c)
echo "$results"
}

#pageCount
countingCurlAccess
