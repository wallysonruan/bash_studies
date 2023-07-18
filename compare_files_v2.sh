#!/bin/bash

set -e

# Check if the both input file exist
if test -f "$1"
then
	file_src=$1
else
	echo "Missing original file path"
	exit 1
fi

if test -f "$2"
then
	file_changed=$2
else
	echo "Missing changed file path"
	exit 1
fi

# Load the files contents as lines
file_src_lines=()
file_changed_lines=()

while IFS= read -r line;
do
	file_src_lines+=("$line")
done < "$file_src"

while IFS= read -r line;
do
	file_changed_lines+=("$line")
done < "$file_changed"

# Check the size of both sizes, assign the greater one to the iteration_max variable
declare -i iteration_max=0

if (( ${#file_src_lines} -gt ${#file_changed_lines} ));
then
	iteration_max=${#file_src_lines}
else
	iteration_max=${#file_changed_lines}
fi

# Check if the lines are equal, assign 1 to the array if TRUE, if FALSE assign 0.
declare isDiff

for((i=0; i < $iteration_max; i++))
do
	if test "${file_src_lines[i]}" = "${file_changed_lines[i]}";
	then
		isDiff[i]=0
	else
		isDiff[i]=1
	fi
done

# Print the file showing the difference
header=">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> CHANGES >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
footer=">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

for((i=0; i < $iteration_max; i++))
do
	# If is equal, echo the line
	if [ ${isDiff[i]} = "0" ]; then
		echo "${file_src_lines[i]}"

	# If is different ...
        elif [ "${isDiff[i]}" == "1" ]; then

		# ... if it's the first line, echo the header and the line 
		if [ ${i} == "0" ]; then
			echo "$header"
			echo "${file_changed_lines[i]}"

		# ... If it's the first line, and the previous one is equal. Echo the header, and the line
		elif [ ${i} != "0" ] && [ "${isDiff[i-1]}" == "0" ]; then
                        echo "$header"
                        echo "${file_changed_lines[i]}"

		# ... If it's not the first line, and the previous one is different, only echo the line
		elif [ ${i} != "0" ] && [ "${isDiff[i-1]}" == "1" ]; then
	                echo "${file_changed_lines[i]}"
		fi		

                # ... If it's not the last line and the next one is equal, echo the footer. 
                if [ "$i" != "$iteration_max" ] && [ "${isDiff[i+1]}" == "0" ]; then
                        echo "$footer"
                fi
	fi
done
