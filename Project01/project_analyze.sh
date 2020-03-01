#!/bin/bash

if [ -f ".enc" ] ; then
	echo "You are in an encrypted state currently, please decrypt before proceeding"
	LOCKDOWN=1
	FIXME=0
        CHECKOUT=0
        SIZECHECK=0
        TYPECOUNT=0
        FINDTAG=0
        BDR=0
	EXCHANGE=0
else
	echo "Which features would you like to use? Enter 1 for yes or 0 for no."
	echo "Run Folder Lock Down?"
	read LOCKDOWN
	if [ "$LOCKDOWN" != 1 ] ; then
		echo "Run #FIXME Search?"
		read FIXME
		echo "Run Checkout Latest Merge?"
		read CHECKOUT
		echo "Run File Size Check?"
		read SIZECHECK
		echo "Run File Type Count?"
		read TYPECOUNT
		echo "Run Find Tag?"
		read FINDTAG
		echo "Run Backup and Delete/Restore?"
		read BDR
		echo "Run Currency Exchange?"
		read EXCHANGE
	else
		FIXME=0
		CHECKOUT=0
		SIZECHECK=0
		TYPECOUNT=0
		FINDTAG=0
		BDR=0
		EXCHANGE=0
	fi
fi


#Folder Lock Down Special Feature
#https://stackoverflow.com/questions/1116992/capturing-output-of-find-print0-into-a-bash-array
if [ "$LOCKDOWN" == 0 ] ; then
        echo "Skipping Folder Lock Down"
elif [ "$LOCKDOWN" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "The encrypt/decrypt feature is exclusive, and will be the only feature run in this script execution."
	if [ -f ".enc" ] ; then
		MODE="decrypt"
		echo "Currently your files are encrypted, please enter the key to decrypt your files."
		read KEY
	else
		MODE="encrypt"
		echo "What key would you like to use to encrypt your files? Remember this when you want to decrypt!"
		read KEY
        fi
	find . -maxdepth 1 -print0 | while IFS= read -d '' file ; do
                NAME=$(basename "$file")
                if [ "$NAME" != "project_analyze.sh" ] && [[ "$NAME" =~ ^[^.] ]] ; then
                        echo "$NAME"
			NEWNAME=$(printf "$NAME","$KEY","$MODE" | python3 ".encdec.py" | tr -d "\0")
                        mv "$NAME" "$NEWNAME"
                        if [ "$MODE" = "decrypt" ] ; then
                                if [ -d "$NEWNAME" ] ; then
                                        chmod 775 "$NEWNAME"
                                else
                                        chmod 664 "$NEWNAME"
                                fi
                        else
                                chmod 000 "$NEWNAME"
                        fi
                fi
        done
        IFS=" "
	if [ "$MODE" == "encrypt" ] ; then
		touch .enc
	else
		rm .enc
	fi
	echo -n "The "
	echo -n "$MODE"
	echo "ion has been completed!"
	echo ________________________________________________________________________
else
        echo "Input for the Folder Lock Down feature was not 0 or 1, please try again"
fi


#Feature 6.2 FIXME Log
#https://askubuntu.com/questions/926626/how-do-i-fix-warning-command-substitution-ignored-null-byte-in-input
#https://stackoverflow.com/questions/31381373/get-last-line-of-shell-output-as-a-variable
if [ "$FIXME" == 0 ] ; then
	echo "Skipping #FIXME Search"
elif [ "$FIXME" == 1 ] ; then
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
if [ "$CHECKOUT" == 0 ] ; then
	echo "Skipping Checkout Latest Merge"
elif [ "$CHECKOUT" == 1 ] ; then
	COMMIT=$(git log --oneline | grep "merge" -m1 | awk '{print substr($0,0,7)}')
	git checkout "$COMMIT"
	echo "When you are done here you can use 'git checkout project01' or 'git checkout master'"
else
	echo "Input for the Checkout Latest Merge feature was not 0 or 1, please try again"
fi

#Feature 6.4 File Size List
#https://unix.stackexchange.com/questions/22432/getting-size-with-du-of-files-only
if [ "$SIZECHECK" == 0 ] ; then
        echo "Skipping File Size Check"
elif [ "$SIZECHECK" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "Listing all files in the desjarde CS1XA3 repo from largest to smallest"
	echo
	find .. -type f -exec du -h "{}" + | sort -nr
	echo
	echo "Files have been listed successfully"
	echo ________________________________________________________________________
else
	echo "Input for the File Size Check feature was not 0 or 1, please try again"
fi

#Feature 6.5 File Type Count
if [ "$TYPECOUNT" == 0 ] ; then
        echo "Skipping File Type Count"
elif [ "$TYPECOUNT" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "Which file type would you like to count? (ex. pdf, txt, md)"
	read end
	NUM=$(find .. -type f -name *."$end" | wc -l)
	if [ "$NUM" == 1 ] ; then
		echo "There is 1 file in this repo with the extension '.$end'"
	else
		echo "There are $NUM files in this repo with the extension '.$end'"
	fi
	echo ________________________________________________________________________
else
	echo "Input for the File Type Count feature was not 0 or 1, please try again"
fi

#Feature 6.6 Find Tag
if [ "$FINDTAG" == 0 ] ; then
	echo "Skipping Find Tag"
elif [ "$FINDTAG" == 1 ] ; then
	echo
	echo ________________________________________________________________________
	echo "What tag would you like to look for?"
	read tag
	find .. -type f -name "*.py" -exec cat "{}" + | grep "#.*$tag.*" > "$tag".log
	echo "All lines that begin with a comment and include \"$tag\" are now in the $tag.log file"

else
	echo "Input for the Find Tag feature was not 0 or 1, please try again"
fi

#Feature 6.8 Backup and Delete/Restore
#https://www.cyberciti.biz/faq/bash-get-basename-of-filename-or-directory-name/
if [ "$BDR" == 0 ] ; then
	echo "Skipping Backup and Delete/Restore"
elif [ "$BDR" == 1 ] ; then
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
	echo ________________________________________________________________________
else
	echo "Input for the Backup and Delete/Restore feature was not 0 or 1, please try again"
fi

#Currency Exchange Special Feature
#https://www.w3schools.com/python/python_json.asp
#https://www.twilio.com/blog/2016/12/http-requests-in-python-3.html
#https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html
#https://www.geeksforgeeks.org/bc-command-linux-examples/
if [ "$EXCHANGE" == 0 ] ; then
	echo "Skipping Currency Exchange"
elif [ "$EXCHANGE" == 1 ] ; then
	python3 ".getCurrency.py"
	echo
	echo ________________________________________________________________________
	echo "Are you exchanging CAD or a foreign curency? (type CAD or F to continue)"
	read XCHOICE
        while [ "$XCHOICE" != "CAD" ] && [ "$XCHOICE" != "F" ] ; do
                echo "That input was not 'CAD' or 'F', please try again."
                read XCHOICE
        done
	FILE=$(cat rates.tmp)
	CTYPES=$(echo "$FILE" | cut -c 1-3)
	FEXIST=F
	if [ "$XCHOICE" == "CAD" ] ; then
		echo "How much CAD do you want to trade?"
		read CADAMOUNT
		echo "Which currency would you like to exchange to?"
		read FCURRENCY
		while [ "$FEXIST" == "F" ] ; do
			IFS=$'\n'
			for cur1 in $CTYPES; do
				if [ "$cur1" == "$FCURRENCY" ] ; then
					FEXIST=T
				fi
			done
			if [ "$FEXIST" != "T" ] ; then
				echo "Unfortunately we do not convert to that type of currency currently, please try again."
				read FCURRENCY
			fi
		done
		if [ "$FEXIST" == "T" ] ; then
			for line in $FILE; do
				CTYPE=$(echo "$line" | cut -c 1-3)
				if [ "$CTYPE" == "$FCURRENCY" ] ; then
					RATE=$(echo "$line" | cut -c 5-15)
					ANS=$(echo "result=$CADAMOUNT*$RATE;scale=2;result/1" | bc -l)
					echo "You will receive $ANS $FCURRENCY for $CADAMOUNT CAD"
				fi
			done
			IFS=" "
		else
			echo "Unfortunately, we do not convert to that type of currency currently."
		fi
	elif [ "$XCHOICE" == "F" ] ; then
		echo "Which foreign currency are you exchanging to CAD?"
		read FEXCHANGE
		while [ "$FEXIST" == "F" ] ; do
			IFS=$'\n'
			for cur2 in $CTYPES; do
				if [ "$cur2" == "$FEXCHANGE" ] ; then
					FEXIST=T
				fi
			done
			if [ "$FEXIST" != "T" ] ; then
				echo "Unfortunately we do not convert to that type of currency currently, please try again."
				read FEXCHANGE
			fi
		done
		echo "How much $FEXCHANGE do you have?"
		read FAMOUNT
		for line in $FILE; do
			FCTYPE=$(echo "$line" | cut -c 1-3)
			if [ "$FCTYPE" == "$FEXCHANGE" ] ; then
				RATE=$(echo "$line" | cut -c 5-15)
				ANS=$(echo "result=$FAMOUNT/$RATE;scale=2;result/1" | bc -l)
				echo "You will recieve $ANS in CAD from $FAMOUNT in $FEXCHANGE"
			fi
		done
		IFS=" "
	fi
	echo ________________________________________________________________________
	rm rates.tmp
else
	echo "Input for the Currency Exchange feature was not 0 or 1, please try again"
fi

echo Script Complete
