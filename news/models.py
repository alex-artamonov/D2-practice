from tkinter import CASCADE
from unicodedata import category
from arrow import now
from django.db import models as m
from django.contrib.auth.models import User

# Create your models here.

class Author(m.Model):
    user = m.OneToOneField(User, on_delete=m.CASCADE)
    rating = m.SmallIntegerField(default=0)

    
class Category(m.Model):
    name = m.CharField(max_length=30, unique=True)

class Post(m.Model):
    NEWS = 'NWS'
    ARTICLE = 'ACL'
    TYPES = [
        (NEWS, 'новость'),
        (ARTICLE, 'статья')
    ]
    author = m.ForeignKey(Author, on_delete=m.CASCADE)
    type = m.CharField(max_length=3, choices=TYPES)
    created_dtm = m.DateTimeField(auto_now=True)
    title = m.CharField(max_length=255)
    content = m.TextField()
    categories = m.ManyToManyField(Category, through='PostCategory')

class PostCategory(m.Model):
    post = m.ForeignKey(Post, on_delete=m.CASCADE)
    category = m.ForeignKey(Category, on_delete=m.CASCADE)

class Comment(m.Model):
    post = m.ForeignKey(Post, on_delete=m.CASCADE)
    user = m.ForeignKey(User, on_delete=m.CASCADE)
    text = m.TextField()
    created_dtm = m.DateTimeField(auto_now=True)
    rating = m.SmallIntegerField(default=0)
