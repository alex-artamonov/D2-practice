# Generated by Django 4.0.6 on 2022-08-20 20:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('news', '0002_post_rating'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='created_dtm',
            field=models.DateTimeField(auto_now_add=True),
        ),
        migrations.AlterField(
            model_name='post',
            name='created_dtm',
            field=models.DateTimeField(auto_now_add=True),
        ),
    ]