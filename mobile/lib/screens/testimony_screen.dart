import 'package:flutter/material.dart';
import 'testimony/text_testimony_screen.dart';
import 'testimony/voice_testimony_screen.dart';
import 'testimony/questionnaire_screen.dart';

class TestimonyScreen extends StatelessWidget {
  const TestimonyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Témoigner'),
        backgroundColor: const Color(0xFF2C0F4C),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xFFF8F9FA),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Comment souhaitez-vous raconter votre vécu ?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2C0F4C)),
              ),
              const SizedBox(height: 10),
              const Text(
                'Vos données sont chiffrées et confidentielles. Vous pouvez vous arrêter ou faire une pause à tout moment.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              
              _buildOptionCard(
                context,
                title: 'Par écrit',
                subtitle: 'Rédigez librement ce qui s\'est passé.',
                icon: Icons.edit_document,
                color: const Color(0xFFD6336C),
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => const TextTestimonyScreen()));
                },
              ),
              const SizedBox(height: 16),
              _buildOptionCard(
                context,
                title: 'Par message vocal',
                subtitle: 'Enregistrez votre voix, nous la retranscrirons pour vous.',
                icon: Icons.mic,
                color: const Color(0xFF4C6EF5),
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => const VoiceTestimonyScreen()));
                },
              ),
              const SizedBox(height: 16),
              _buildOptionCard(
                context,
                title: 'Questionnaire guidé',
                subtitle: 'Laissez-nous vous poser des questions simples étape par étape.',
                icon: Icons.checklist_rtl,
                color: const Color(0xFF20C997),
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => const QuestionnaireScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}


