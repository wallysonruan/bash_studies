#!/bin/bash

set -e

for arg in $@; do
	if [ -d $arg ]; then
		arg_string_size=${#arg}
		is_slash=0
		second_slash_index=$arg_string_size	
	
		# Get the name of the folder
		for (( $arg_string_size; $arg_string_size > 0 ; arg_string_sized-= 1 )); do
			
			if [ "$is_slash" == "0" ] && [ "${arg:0:1}" == "/" ]; then
				is_slash=1
			
			elif [ "$is_slash" == "1" ] && [ "${arg:0:1}" == "/" ]; then
				second_slash_index= $(( $second_slash_index - 1 ))
				arg_string_size=0
			fi
			echo "$second_slash_index"
		done

#		echo "-> $arg"
#		for content in ${arg}*; do
#			echo "--> ${content:(( ${#arg} - 1))}"
#		done	

#	else
#		echo "It's not a folder path: $arg"
	fi
done
