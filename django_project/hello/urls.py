from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [
	path('e/desjarde/, views.hello_world, name='hello.views.helloview'),
	path('goodbye/', views.goodbye_world, name='hello.views.goodbye_world'),
]
