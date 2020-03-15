from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.

def hello_view(request):
	return render(request, "hello.html")

def hello_world(request):
        html = "<html> <body> Hello World </body> </html>"
        return HttpResponse(html)

def goodbye_world(request):
	html = "<html> <body> Goodbye World </body> </html>"
	return HttpResponse(html)
