# CS1XA3 Project01 - desjarde

## Usage

To access the script, you must begin by cloning the repository to your machine in the desired location, using:

```
git clone "https://github.com/EvanDesj/CS1XA3.git"
```

Once you have access to the repository, use the "cd CS1XA3/Project01" command to access the Project01 folder, which stores the current bash file to run the project, "project_analyze.sh".

To run the file, which should be run from inside of the Project01 folder, simply type:

```
./project_analyze.sh
```
>>>>>>> project01

and click enter.

Once the program has started running, the user will be asked to respond 0 (don't run) or 1 (run) to the eight features of the program:

1. Folder Lock Down 
2. #FIXME Search
3. Checkout Latest Merge
4. File Size Check
5. File Type Count
6. Find Tag
7. Backup and Delete/Restore
8. Currency Exchange

Choosing any other input besides 0 or 1 for each of the features outputs a message saying the input was not valid.

## Folder Lock Down

**Description:** This feature scrambles the names of all the files and directories, besides files needed by the script, that are in the current directory of the project_analyze.sh file. The Folder Lock Down feature can only be run by itself, meaning that if you choose to encrypt, no other features can be run until the files have been decrypted again. This function will not encrypt files with names that have a period in them besides from the extension separator. The feature still executes on the remaining files that do work, but an error is shown if that type of file exists. Once files are encrypted, then the next time the script is run the user is forced to decrypt the files before the other features become available again.

**Execution:** If your files are already encrypted then the user is forced to decrypt before any other options in the script are available. This results in a prompt for the key that was used to encrypt originally, and will decrypt the names back to their original state. If the files aren't encrypted, to begin using this feature the user enters 1 when prompted to "Run Folder Lock Down?". They are then prompted for a key, which must be remembered to decrypt the files.  After the encryption process, all permissions are removed from files and directories. The decryption process restores the permissions back to the basic permissions of 664 for files and 775 for directories.

**Reference:**  
[Using print0 from find](https://stackoverflow.com/questions/1116992/capturing-output-of-find-print0-into-a-bash-array)

## FIXME Check

**Description:** This feature finds all files in the CS1XA3 repository and checks to see if "#FIXME" is in the final line of that file. If this is true, the path to that file name is added to a file called _fixme.log_

**Execution:** To perform this feature, simply enter 1 when prompted by the "Run #FIXME Check?" after executing the initial script.

**Reference:**  
[Ignoring null byte input](https://askubuntu.com/questions/926626/how-do-i-fix-warning-command-substitution-ignored-null-byte-in-input)  
[Last line out of shell output](https://stackoverflow.com/questions/31381373/get-last-line-of-shell-output-as-a-variable)

## File Size Check

**Description:** This feature finds all files in the CS1XA3 repository and presents them in order of size from largest to smallest, displaying size in units like KB, MB, etc. If there is no displayed size unit, that indicates the file's size is only in bytes.

**Execution:** To perform this feature, simply enter 1 when prompted by the "Run File Size Check?" after executing the initial script.

**Reference:**  
[Getting file size](https://unix.stackexchange.com/questions/22432/getting-size-with-du-of-files-only)
<<<<<<< HEAD
=======

## Checkout Latest Merge

**Description:** This feature finds the most recent git commit message with the word "merge" in it and checks out that commit, putting the user into a detached head state.

**Execution:** To perform this feature, enter 1 when prompted by the "Run Checkout Latest Merge?" after executing the initial script. This will fail if all current work has not been committed or stashed to git already.
>>>>>>> project01

## File Type Count

**Description:** This feature finds all files in the CS1XA3 repository that end in a user prompted file extension. Once found, it outputs the number of files found. There is no restricition on the extension, however, assuming you are looking for normal file extensions, do not include the period in your input. (Ex. Write "pdf" **NOT**  ".pdf")

**Execution:** To perform this feature, first enter 1 when prompted by the "Run File Type Count?" after executing the initial script. The user is then prompted to give the desired file extension to be searched for, and the number of files of that type are found.

## Find Tag

**Description:** This feature searches through all .py files in the CS1XA3 repository for a user given tag, and puts any commented line from those files that includes the tag into a "tag".log file.

**Execution:** To perform this feature, first enter 1 when prompted by the "Run Find Tag?" after executing the initial script. The user is then asked what tag they are searching for, and the appropriate output is returned in the "tag".log file.

## Backup and Delete/Restore

**Description:** This feature gives the user the ability to backup ".tmp" files. If the user chooses to backup, a backup directory is created and all the ".tmp" files are moved inside, plus a restore.log file is created, containing the path to each file's original location. One flaw is that if the user chooses to backup again, the original backup is gone and these files are lost. Otherwise, choosing to restore returns the ".tmp" files back to their original locations before backup, and the backup folder remains as a safeguard.

**Execution:** To perform this feature, first enter 1 when prompted by the "Run Backup and Delete/Restore?" after executing the initial script. The user then chooses whether they want to backup or restore. If there is no backup to restore, then the user is told, otherwise either option is valid, and performs as described above.

**Reference:**  
[Getting the basename of a file](https://www.cyberciti.biz/faq/bash-get-basename-of-filename-or-directory-name/)

## Currency Exchange

**Description:** This feature uses an API to get current exchange rates with a base of Canadian Dollars. The user then has the ability to exchange between Canadian Dollars and a foreign currency, which must be within the data set that is being used to exchange, or between foreign currency and Canadian Dollars, where once again, the foreign currency must be in the known exchanges. Each exchange rate is inputted using the three letter code associated with that currency. To see a full list of possible currency exchanges, check the list here: [Currencies](https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/index.en.html) If any expected number amount, whether foreign or Canadian Dollar, is not a number, then the exchange simply returns 0. If both inputs are valid, then the exchange is calculated and outputted to the user, rounded to 2 decimal places.

**Execution:** To execute this feature, first enter 1 when prompted "Run Currency Exchange?". The user will be prompted to enter CAD or F, depending on whether they are exchanging Canadian Dollars into foreign currency or foreign currency into Canadian Dollars. If CAD is chosen, the amount and currency to exchange to is asked for, under the restrictions described above.  If they are exchanging foreign currency to Canadian Dollars, prompts will ask which currency is being exchanged and how much of it. Finally, the appropriate amount will be outputted.

**Reference:**  
[Using json in python](https://www.w3schools.com/python/python_json.asp)  
[Http requests in python](https://www.twilio.com/blog/2016/12/http-requests-in-python-3.html)  
[Using the bc command](https://www.geeksforgeeks.org/bc-command-linux-examples/)  
[Rounding with bc](https://askubuntu.com/questions/217570/bc-set-number-of-digits-after-decimal-point)
