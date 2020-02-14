# CS1XA3 Project01 -  desjarde

## Usage
To get started on executing the script, you must clone the repository to your machine, using:

    git clone "https://github.com/EvanDesj/CS1XA3.git"
Once you have access to the repository, use the "cd Project01" command to access the Project01
folder, which stores the current file, project_analyze.sh

To run the file, simply type:

    ./project_analyze.sh
and click enter.

Once the program has started running, the user will be asked to respond 0 (don't run) or 1 (run)
to the three features of the program:

 1. #FIXME Check
 2. File Size Check
 3. File Type Count

Choosing any other input besides 0 and 1 for each of the features is not valid.

## FIXME Check
**Description:** This feature finds all files in the CS1XA3 repository and checks to see if
"#FIXME" is in the final line of that file. If this is true, the path to that file name is added
to a file called *fixme.log*

**Execution:** To perform this feature, simply enter 1 when prompted by the "Run #FIXME Check?"
after executing the initial script.

    Run #FIXME Check?
    1

**Reference:**  
[Ignoring null byte input](https://askubuntu.com/questions/926626/how-do-i-fix-warning-command-substitution-ignored-null-byte-in-input)  
[Last line out of shell output](https://stackoverflow.com/questions/31381373/get-last-line-of-shell-output-as-a-variable)

## File Size Check
**Description:** This feature finds all files in the CS1XA3 repository and presents them in
order of size from largest to smallest, displaying size in units like KB, MB, etc. If there is
no displayed size unit, that indicates the file's size is only in bytes. 

**Execution:** To perform this feature, simply enter 1 when prompted by the "Run File Size Check?"
after executing the initial script.

    Run File Size Check?
    1

**Reference:**  
[Getting file size](#https://unix.stackexchange.com/questions/22432/getting-size-with-du-of-files-only)

## File Type Count
**Description:** This feature finds all files in the CS1XA3 repository that end in a user prompted file
extension. Once found, it outputs the number of files found. There is no restricition on the extension,
however, assuming you are looking for normal file extensions, do not include the period in your input.
(Ex. Write "pdf" **NOT** ".pdf")

**Execution:** To perform this feature, first enter 1 when prompted by the "Run File Type Count?"
after executing the initial script.

    Run File Type Count?
    1
The user is then prompted to give the desired file extension to be searched for, and the number of
files of that type are found.

# Custom Features

## Folder Lock Down
**Description:** This feature will encrypt or decrypt all the names of the files in the Project01
directory and remove read and write access for everyone but the owner . The user will be asked if
they want to encrypt or decrypt the files, then be prompted for a key word to scramble the file names
with. Only files with alphanumeric names will be scrambled, but all files will be limited to owner
read and writing only. The file extensions will not be changed. The names will be encoded using the
numerical values of each character in the name, not case sensitive, and added to the value of the
corresponding key value.
Example:
 - File: Hello.sh = 8 5 12 12 15
 - Key: Yes = 24 5 19
 - Encryption: (8+24) (5+5) (12 + 19) (12 + 24) (15 + 24)
 - Encryption: 32 10 31 36 39 (only 36 characters, 26 letters, 10 numbers, so 39 becomes 3)
 - Encryption: 5j49c.sh

The file name for the script that caused the encryption will not be encrypted, so to decrypt the
names back to their original form, navigate to the same project_analyze.sh and follow the decryption
steps listed in the **Execution** section below.

**Execution:** To use this feature, enter 1 when asked to "Run Folder Lock Down?", then write "e" or
"encrypt" when prompted for encryption or decryption and enter a alphanumeric key for encryption. All
applicable files will be encrypted now, and the read and write settings will be changed to user only.
To decrypt, run the project_analyze.sh file again, once again choosing 1 when asked to
"Run Folder Lock Down?", this time entering "d" or "decrypt" when prompted for encryption or decryption,
and enter the same key that was used to encrypt the file names. This will restore all the files to their
original names.

## Currency Exchange

**Description:** This feature will use either a predetermined currency rate exchange file or information
curled from the internet (depending on my programming ability) to perform money exchanges between
different currencies. This will take foreign or Canadian amount of money and multiply by the appropriate
ratio to determine how much money you would receive for this exchange. The addition and multiplication
for these calculations will be run in a python script.

**Execution:** To execute this feature, enter 1 when prompted "Run Currency Exchange?". The user will
first be prompted whether they are exchanging foreign currency into Canadian Dollars (enter 1) or
exchanging Canadian Dollars into foreign currency (enter 2). If they are exchanging foreign to
Canadian, prompts will appear asking for how much foreign currency and what country it is from. If
they are exchanging Canadian to foreign, prompts will ask how many Canadian Dollars are being exchanged
and to which country's currency. Finally, the appropriate amount will be outputted.
