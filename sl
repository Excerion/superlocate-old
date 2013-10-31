#!/bin/bash

# Launch locate with the first argument as argument.
all="$(locate -i -r $1)"

# Filter results using grep so that each argument is included.
for i in "${@:2}"
	do
		all="$(echo "$all" | grep -i "$i")"
	done

# Notify the user of the results.
echo "$all"

numofresults=$(echo "$all" | wc -l)

# If there are no results, quit.
if
	[[ $numofresults -eq 0 ]]
	then echo "No results."
	exit
fi

if
	# If there is only one result, cd to the directory, or the directory containing the file.
	[ $numofresults -eq 1 ]
	then
		cd "$(idirname "$all")"

	# If there are more than one results, choose one of them with dmenu
 	else
		height=$(echo "$all" | wc -l)

		if
		 	[[ $height -gt 30 ]]
		 	then heightfit=30
		 	else heightfit=$height
		 fi
		 
		 choice="$(echo "$all" | dmenu -i -l $heightfit)"
		 cd "$(idirname "$choice")"
fi

# Finally, give the user a clue about what's in this directory for userfriendliness
ls

