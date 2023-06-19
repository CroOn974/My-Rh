from django.shortcuts import render
from api.models import Gender, Personal
#api
from rest_framework import viewsets
from api.serializers import GenderSerializer, PersonalSerializer
# Create your views here.

class PersonalViewset(viewsets.ModelViewSet):
    queryset = Personal.objects.all()
    serializer_class = PersonalSerializer


class GenderViewset(viewsets.ReadOnlyModelViewSet):
    queryset = Gender.objects.all()
    serializer_class = GenderSerializer