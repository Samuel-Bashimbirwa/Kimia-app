from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    # Extending default user
    phone = models.CharField(max_length=20, blank=True, null=True)
    preferences = models.JSONField(default=dict, blank=True)

class Law(models.Model):
    title = models.CharField(max_length=255)
    reference = models.CharField(max_length=100)
    content = models.TextField()
    keywords = models.TextField(help_text="Comma separated keywords")
    violence_type = models.CharField(max_length=100)
    sanctions = models.TextField()

    def __str__(self):
        return f"{self.reference} - {self.title}"

class Submission(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='submissions')
    date_submitted = models.DateTimeField(auto_now_add=True)
    violence_type = models.CharField(max_length=100, blank=True, null=True)
    content_text = models.TextField(blank=True, null=True)
    audio_path = models.CharField(max_length=255, blank=True, null=True)
    questionnaire_data = models.JSONField(default=dict, blank=True)

    def __str__(self):
        return f"Submission by {self.user.username} on {self.date_submitted.strftime('%Y-%m-%d')}"

class Diagnosis(models.Model):
    submission = models.OneToOneField(Submission, on_delete=models.CASCADE, related_name='diagnosis')
    analysis_result = models.TextField()
    score = models.IntegerField(default=0, help_text="Defensibility score out of 100")
    recommendations = models.TextField()
    applicable_laws = models.ManyToManyField(Law, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Diagnosis for Submission {self.submission.id} (Score: {self.score})"

class CabinetInfo(models.Model):
    name = models.CharField(max_length=255)
    description = models.TextField()
    address = models.TextField()
    phone = models.CharField(max_length=20)
    email = models.EmailField()

    def __str__(self):
        return self.name
