#!/bin/bash

echo "Which features would you like to use? Enter 1 for yes or 0 for no."
echo "Run #FIXME Search?"
read feat1
echo "Run Checkout Latest Merge?"
read feat2
echo "Run File Size Check?"
read feat3
echo "Run File Type Count?"
read feat4
echo "Run Find Tag?"
read feat5
echo "Switch to Executable?"
read feat6

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
	echo  "Input for #FIXME Search function was not 0 or 1, please try again"
fi

#Feature 6.3 Checkout Latest Merge
if [ "$feat2" == 0 ] ; then
	echo "Skipped Checkout Latest Merge"
elif [ "$feat2" == 1 ] ; then
	COMMIT=$(git log --oneline | grep "merge" -m1 | awk '{print substr($0,0,7)}')
	git checkout "$COMMIT"
else
	echo "Input for the Checkout Latest Merge function was not 0 or 1, please try again"
fi

#Feature 6.4 File Size List
#https://unix.stackexchange.com/questions/22432/getting-size-with-du-of-files-only
if [ "$feat3" == 0 ] ; then
        echo "Skipped File Size Check"
elif [ "$feat3" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "Listing all files in the desjarde CS1XA3 repo from largest to smallest"
	echo
	find .. -type f -exec du -h {} + | sort -nr
	echo
	echo "Files have been listed successfully"
	echo ________________________________________________________________________
else
	echo "Input for File Size Check function was not 0 or 1, please try again"
fi

#Feature 6.5 File Type Count
if [ "$feat4" == 0 ] ; then
        echo "Skipped File Type Count"
elif [ "$feat4" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "Which file type would you like to count? (ex. pdf, txt, md)"
	read end
	NUM=$(find .. -type f -name *."$end" | wc -l)
	echo There are "$NUM" files in this repo with the extension ."$end"
	echo ________________________________________________________________________
else
	echo "Input for File Type Count function was not 0 or 1, please try again"
fi

#Feature 6.6 Find Tag
if [ "$feat5" == 0 ] ; then
	echo "Skipped Find Tag"
elif [ "$feat5" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "What tag would you like to look for?"
	read tag
	find .. -type f -name "*.py" -exec cat {} + | grep "#.*$tag.*" > "$tag".log
else
	echo "Input for the Find Tag function was not 0 or 1, please try again"
fi

#Feature 6.7 Switch to Executable
if [ "$feat6" == 0 ] ; then
	echo "Skipped Switch to Executable"
elif [ "$feat6" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "Do you want to Change or Restore? (type c or r to continue)"
	read xchoose
	while [ "$xchoose" != "c" ] && [ "$xchoose" != "r" ] ; do
		echo "That input was not a \"r\" or a  \"c\", please try again."
		read xchoose
	done
	if [ "$xchoose" == "c" ] ; then
		echo "CCCCCCCCC"
	elif [ "$xchoose" == "r" ] ; then
		echo "rrrrrR"
	fi
fi
