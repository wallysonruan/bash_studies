#!/bin/bash

set -e


################ CHECKS IF THE PATHS ARE VALID FILE PATHS ################
if [ -f $1 ]; then
	first_file_path=$1
else
	echo "Missing first file path"
	exit 0
fi

if [ -f $2 ]; then
	second_file_path=$2
else
	echo "Missing second file path"
	exit 0
fi

################ ASSIGNS THE CONTENT AS SPLIT IN LINES TO ARRAYS ################ 
first_file_lines=()
while IFS= read -r line; do
	first_file_lines+=("$line")
done < "$first_file_path"

second_file_lines=()
while IFS= read -r line; do
        second_file_lines+=("$line")
done < "$second_file_path"	

################ VERIFY WHAT FILE HAS MORE LINES AND USES THE BIGGER AS A LIMIT TO THE ITERATION OPERATION ################
if [ ${#first_file_lines[@]} -gt ${#second_file_lines[@]} ]; then
	iterationLimit=${#first_file_lines}
else
	iterationLimit=${#second_file_lines}
fi

################ CHECKS AND PRINTS THE DIFFERENCES ################
header_padding="                         "  # 25 spaces
first_file_name="FIRST FILE"
first_file_name_half_characters=$(( ${#first_file_name} / 2))
second_file_name="SECOND FILE"
second_file_name_half_characters=$(( ${#second_file_name} / 2))


echo "|${header_padding:${#first_file_name_half_characters}}${first_file_name}${header_padding:${#first_file_name_half_characters}}|${header_padding:${#second_file_name_half_characters}}${second_file_name}${header_padding:${#second_file_name_half_characters}}|"
for ((i=0; i<${iterationLimit}; i++))
do
	if [[ ( ${#first_file_lines[i]} -gt 0 || ${#second_file_lines[i]} -gt 0 ) && first_file_lines[i] != second_file_lines[i] ]]; then
		echo "line $i:${first_file_lines[i]} | line $i: ${second_file_lines[i]}"
	fi
done
