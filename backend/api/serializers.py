from rest_framework import serializers
from .models import User, Law, Submission, Diagnosis, CabinetInfo
from django.contrib.auth import get_user_model

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'phone', 'preferences', 'password')
    
    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data.get('email', ''),
            phone=validated_data.get('phone', ''),
            password=validated_data['password']
        )
        return user

class LawSerializer(serializers.ModelSerializer):
    class Meta:
        model = Law
        fields = '__all__'

class SubmissionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Submission
        fields = '__all__'
        read_only_fields = ('user', 'date_submitted')

class DiagnosisSerializer(serializers.ModelSerializer):
    applicable_laws = LawSerializer(many=True, read_only=True)
    submission = SubmissionSerializer(read_only=True)
    class Meta:
        model = Diagnosis
        fields = '__all__'

class CabinetInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = CabinetInfo
        fields = '__all__'
