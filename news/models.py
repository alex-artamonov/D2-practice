from django.db import models as m
from django.contrib.auth.models import User

# Create your models here.

class Author(m.Model):
    user = m.OneToOneField(User, on_delete=m.CASCADE)
    rating = m.SmallIntegerField(default=0)

    def update_rating(self):
        pass

    def __str__(self) -> str:
        return self.user

    
class Category(m.Model):
    name = m.CharField(max_length=30, unique=True)

    def __str__(self) -> str:
        return self.name

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
    rating = m.SmallIntegerField(default=0)

    def __str__(self) -> str:
        return f"{self.title=}, {self.type=}"

    def preview(self):
        return self.content[:124] + '...'

    def like(self):
        self.rating += 1

    def dislike(self):
        self.rating -= 1

class PostCategory(m.Model):
    post = m.ForeignKey(Post, on_delete=m.CASCADE)
    category = m.ForeignKey(Category, on_delete=m.CASCADE)



class Comment(m.Model):
    post = m.ForeignKey(Post, on_delete=m.CASCADE)
    user = m.ForeignKey(User, on_delete=m.CASCADE)
    text = m.TextField()
    created_dtm = m.DateTimeField(auto_now=True)
    rating = m.SmallIntegerField(default=0)

    def like(self):
        self.rating += 1

    def dislike(self):
        self.rating -= 1
