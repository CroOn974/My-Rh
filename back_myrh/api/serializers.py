from rest_framework import serializers
from api.models import Personal, Gender


class PersonalSerializer(serializers.ModelSerializer):
    gender_label = serializers.CharField(source='id_gender.label', read_only=True)

    class Meta:
        model = Personal
        fields = ['id_personal', 'first_name', 'last_name', 'phone_number', 'email', 'email_personnal', 'id_gender', 'gender_label']

class GenderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Gender
        fields = '__all__'

