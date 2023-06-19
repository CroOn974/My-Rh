from django.urls import path, include
from rest_framework.routers import DefaultRouter
from api.views import PersonalViewset, GenderViewset

router = DefaultRouter()
router.register('personal', PersonalViewset, basename='personal')
router.register('gender', GenderViewset, basename='gender')

urlpatterns = [
    path('', include(router.urls)),
]