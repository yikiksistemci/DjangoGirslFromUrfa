"""mysite URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
    Önceki bölümde gördüğümüz yönetici URL'si burada:
/////------------///////
mysite/urls.py
    path('admin/', admin.site.urls),
Bu satırın anlamı Django, admin ile başlayan her URL için ona uyan bir view bulur demektir. Bu durumda bir sürü yönetici URL'lerini ekliyoruz, böylece hepsi bu küçük dosyanın içinde sıkıştırılmış bir şekilde durmuyor -- bu hali daha okunabilir ve düzenli.



"""
from django.urls import path, include
from django.contrib import admin

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('blog.urls')),
]