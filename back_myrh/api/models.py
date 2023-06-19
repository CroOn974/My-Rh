from django.db import models

class Gender(models.Model):
    id_gender = models.AutoField(primary_key=True)
    label = models.CharField(unique=True, max_length=50)

    class Meta:
        managed = False
        db_table = 'gender'


class Personal(models.Model):
    id_personal = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    phone_number = models.CharField(max_length=50, blank=True, null=True)
    email = models.CharField(max_length=50, blank=True, null=True)
    email_personnal = models.CharField(max_length=50, blank=True, null=True)
    id_gender = models.ForeignKey(Gender, models.DO_NOTHING, db_column='id_gender')

    class Meta:
        managed = False
        db_table = 'personal'
