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
padding="                         "  # 25 spaces

first_file_name="FIRST FILE"
first_file_name_half_characters=$(( ${#first_file_name} / 2))

second_file_name="SECOND FILE"
second_file_name_half_characters=$(( ${#second_file_name} / 2))

header="|${padding:${#first_file_name_half_characters}}${first_file_name}${padding:${#first_file_name_half_characters}}|${padding:${#second_file_name_half_characters}}${second_file_name}${padding:${#second_file_name_half_characters}}|"

echo "$header"

for ((i=0; i<${iterationLimit}; i++))
do
	if [[ ( ${#first_file_lines[i]} -gt 0 || ${#second_file_lines[i]} -gt 0 ) && first_file_lines[i] != second_file_lines[i] ]]; then
		line_default_chars=" $i: "
		line="|${line_default_chars}${first_file_lines[i]}${padding:${#line_default_chars}+${#first_file_lines[i]}}${padding}|${line_default_chars}${second_file_lines[i]}${padding:${#line_default_chars}+${#second_file_lines[i]}}${padding}|"
		echo "$line"
	fi
done
