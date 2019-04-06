#created by yyasar
from django.db import models
from django.utils import timezone


class Post(models.Model):  #post nesnesi için bir model oluşturduk.
    auther = models.ForeignKey('auth.User',on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    text = models.TextField()
    created_date = models.DateTimeField(default=timezone.now)
    published_date = models.DateField(blank=True,null=True)


    def publish(self):
        self.published_date = timezone.now()
        self.save()

    def __str__(self):  #burada Post nesnesinin başlığını geri döndeririz.
        return self.title




