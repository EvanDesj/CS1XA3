# Generated by Django 3.0.3 on 2020-04-25 03:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('social', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='post',
            name='liked',
            field=models.BooleanField(default=False),
        ),
    ]
