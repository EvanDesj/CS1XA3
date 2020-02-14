#!/bin/bash
echo "Which features would you like to use? Enter 1 for yes or 0 for no."
echo "Run #FIXME Search?"
read feat1
echo "Run File Size Check?"
read feat2
echo "Run File Type Count?"
read feat3

#Feature 6.2 FIXME Log
#https://askubuntu.com/questions/926626/how-do-i-fix-warning-command-substitution-ignored-null-byte-in-input
#https://stackoverflow.com/questions/31381373/get-last-line-of-shell-output-as-a-variable
if [ "$feat1" == 0 ] ; then
	echo "Skipped #FIXME Search"
elif [ "$feat1" == 1 ] ; then
	> "fixme.log"
	FILES=$(find .. -type f)
	IFS=$'\n'
	echo ""
	echo ________________________________________________________________________
	echo "Looking for #FIXME files..."
	for file in $FILES ; do
		LAST=$(tail -n 1 "$file" | tr -d '\0')
		if [[ "$LAST" == *"#FIXME"* ]] ; then
			echo "$file" >> "fixme.log"
		fi
	done
	IFS=" "
	echo "Complete! All files with #FIXME are in fixme.log"
	echo ________________________________________________________________________
else
	echo  "Input for #FIXME Search was not 0 or 1, please try again"
fi

#Feature 6.4 File Size List
#https://unix.stackexchange.com/questions/22432/getting-size-with-du-of-files-only
if [ "$feat2" == 0 ] ; then
        echo "Skipped File Size Check"
elif [ "$feat2" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "Listing all files in the desjarde CS1XA3 repo from largest to smallest"
	echo
	find .. -type f -exec du -h {} + | sort -nr
	echo
	echo "Files have been listed successfully"
	echo ________________________________________________________________________
else
	echo "Input for File Size Check was not 0 or 1, please try again"
fi

#Feature 6.5 File Type Count
if [ "$feat3" == 0 ] ; then
        echo "Skipped File Type Count"
elif [ "$feat3" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "Which file type would you like to count? (ex. pdf, txt, md)"
	read end
	NUM=$(find .. -type f -name *."$end" | wc -l)
	echo There are "$NUM" files in this repo with the extension ."$end"
	echo ________________________________________________________________________
else
	echo "Input for File Type Count was not 0 or 1, please try again"
fi
