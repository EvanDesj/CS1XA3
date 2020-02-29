import sys
import unicodedata

def main():
	input="{0}".format(sys.stdin.read())
	fkmSplit = input.split(",")
	mode = fkmSplit[2]
	key = fkmSplit[1]
	nameSplit = fkmSplit[0].split(".")
	fileName = nameSplit[0]
	if len(nameSplit) > 1:
		fileTag = nameSplit[1]
	else:
		fileTag = ""
	if mode == "encrypt":
		newName = encrypt(fileName, key, 0)
	elif mode == "decrypt":
		newName = decrypt(fileName, key, 0)
	if fileTag != "":
		print(newName + "." + fileTag)
	else:
		print(newName)

def encrypt(name, key, i):
	if len(name) == 1:
		return chr((ord(name[0]) + ord(key[i]))%5000)
	else:
		return encrypt(name[0], key, i) + encrypt(name[1:], key, (i+1)%len(key))

def decrypt(name, key, i):
	if len(name) == 1:
		return chr((ord(name[0]) - ord(key[i]))%5000)
	else:
		return decrypt(name[0], key, i) + decrypt(name[1:], key, (i+1)%len(key))

main()
