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
echo "Run Backup and Delete/Restore?"
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
	echo "When you are done here you can use 'git checkout project01' or 'git checkout master'"
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
	find .. -type f -exec du -h "{}" + | sort -nr
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
	find .. -type f -name "*.py" -exec cat "{}" + | grep "#.*$tag.*" > "$tag".log
	echo "All lines that begin with a comment and include \"$tag\" are now in the $tag.log file"

else
	echo "Input for the Find Tag function was not 0 or 1, please try again"
fi

#Feature 6.8 Backup and Delete/Restore
#https://www.cyberciti.biz/faq/bash-get-basename-of-filename-or-directory-name/
if [ "$feat6" == 0 ] ; then
	echo "Skipped Backup and Delete/Restore"
elif [ "$feat6" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "Do you want to Backup or Restore? (type b or r to continue)"
	read choice
	while [ "$choice" != "b" ] && [ "$choice" != "r" ] ; do
		echo "That input was not a 'b' or a 'r', please try again."
		read choice
	done
	if [ "$choice" == "b" ] ; then
		if [ -d "backup" ] ; then
			rm -r backup
		fi
		mkdir backup
		echo "Finding all .tmp files..."
		find .. -type f -name "*.tmp" > "./backup/restore.log"
		find .. -type f -not -path "*/backup/*" -name "*.tmp" -exec mv "{}" "./backup" \;
		echo "The files have been backed up"
	elif [ "$choice" == "r" ] ; then
		if [ -f "./backup/restore.log" ] ; then
			FILES=$(cat ./backup/restore.log)
			IFS=$'\n'
			for file in $FILES ; do
				NAME=$(basename "$file")
				cp "./backup/$NAME" "$file"
			done
			IFS=" "
			echo "All files have been restored to their original locations"
		else
			echo "There is no restore.log file in backup to restore your temporary files."
		fi
	fi
else
	echo "Input for the Backup and Delete/Restore function was not 0 or 1, please try again"
fi
