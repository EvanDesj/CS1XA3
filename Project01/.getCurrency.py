import urllib.request
import urllib.parse
import json

url = 'https://api.exchangeratesapi.io/latest?base=CAD'
f = urllib.request.urlopen(url)
result = f.read().decode('utf-8')

x = json.loads(result)
x = x["rates"]

file = open("rates.tmp", "w")

for line in x:
	file.write(line + " " + str(x[line]) + "\n")

