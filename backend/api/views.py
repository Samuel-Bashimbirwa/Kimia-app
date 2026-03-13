from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework.views import APIView
from django.contrib.auth import get_user_model
from .models import Law, Submission, Diagnosis, CabinetInfo
from .serializers import UserSerializer, LawSerializer, SubmissionSerializer, DiagnosisSerializer, CabinetInfoSerializer
from rest_framework_simplejwt.tokens import RefreshToken

User = get_user_model()

class RegisterView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            refresh = RefreshToken.for_user(user)
            return Response({
                'user': serializer.data,
                'refresh': str(refresh),
                'access': str(refresh.access_token),
            }, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class SubmissionViewSet(viewsets.ModelViewSet):
    serializer_class = SubmissionSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Submission.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
    
    @action(detail=True, methods=['post'])
    def analyze(self, request, pk=None):
        submission = self.get_object()
        
        # Simple placeholder logic for matching laws (to be expanded)
        # Mock analysis result
        laws = Law.objects.all()[:3] # Get some mock laws
        
        diagnosis, created = Diagnosis.objects.get_or_create(
            submission=submission,
            defaults={
                'analysis_result': 'Analyse préliminaire basée sur votre témoignage.',
                'score': 80,
                'recommendations': 'Votre situation présente des éléments qualifiables juridiquement. Nous vous conseillons de contacter notre cabinet partenaire.'
            }
        )
        if created:
            diagnosis.applicable_laws.set(laws)
            
        serializer = DiagnosisSerializer(diagnosis)
        return Response(serializer.data)

class LawViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Law.objects.all()
    serializer_class = LawSerializer
    permission_classes = [permissions.IsAuthenticated]

class DiagnosisViewSet(viewsets.ReadOnlyModelViewSet):
    serializer_class = DiagnosisSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Diagnosis.objects.filter(submission__user=self.request.user)

class CabinetInfoViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = CabinetInfo.objects.all()
    serializer_class = CabinetInfoSerializer
    permission_classes = [permissions.IsAuthenticated]
