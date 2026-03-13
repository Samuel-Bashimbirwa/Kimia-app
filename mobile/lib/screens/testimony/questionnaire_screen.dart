import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';

class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _isSubmitting = false;

  final Map<String, String> _answers = {
    'violence_type': '',
    'urgency': '',
    'evidence': '',
    'additional': '',
  };

  void _nextPage() {
    if (_currentIndex < 3) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _submitQuestionnaire();
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Future<void> _submitQuestionnaire() async {
    setState(() => _isSubmitting = true);

    try {
      final token = await ApiService().getToken();
      
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/submissions/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'violence_type': _answers['violence_type'] ?? 'Non spécifié',
          'questionnaire_data': _answers,
        }),
      );

      if (response.statusCode == 201) {
        if (!mounted) return;
        _showSuccessDialog();
      } else {
        throw Exception('Erreur serveur');
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur lors de l\'envoi.')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Témoignage envoyé'),
        content: const Text('Votre témoignage a été enregistré en toute sécurité. Vous pouvez consulter votre diagnostic dans la rubrique "Mon Diagnostic".'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // Go back to options
              Navigator.pop(context); // Go back to Home
            },
            child: const Text('Retour à l\'accueil'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaire guidé'),
        backgroundColor: const Color(0xFF20C997),
        foregroundColor: Colors.white,
      ),
      body: _isSubmitting 
        ? const Center(child: CircularProgressIndicator())
        : Column(
        children: [
          LinearProgressIndicator(
            value: (_currentIndex + 1) / 4,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF20C997)),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => setState(() => _currentIndex = index),
              children: [
                _buildQuestion(
                  '1. Quel type de violence avez-vous subi principalement ?',
                  ['Psychologique', 'Physique', 'Sexuelle', 'Économique', 'Autre'],
                  'violence_type',
                ),
                _buildQuestion(
                  '2. Est-ce une situation d\'urgence ou passée ?',
                  [' Urgence immédiate (En danger)', 'Situation actuelle (Mais en sécurité)', 'Faits passés'],
                  'urgency',
                ),
                _buildQuestion(
                  '3. Avez-vous des éléments de preuve ?',
                  ['Oui, beaucoup (certificats, messages, témoins)', 'Quelques-uns (messages, photos)', 'Non, aucune preuve matérielle'],
                  'evidence',
                ),
                _buildTextInputQuestion(
                  '4. Souhaitez-vous préciser autre chose ? (Optionnel)',
                  'additional',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentIndex > 0)
                  TextButton(
                    onPressed: _prevPage,
                    child: const Text('Précédent', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  )
                else
                  const SizedBox(width: 80),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF20C997),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  onPressed: _nextPage,
                  child: Text(_currentIndex == 3 ? 'Terminer et envoyer' : 'Suivant', style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQuestion(String question, List<String> options, String key) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          ...options.map((option) => Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _answers[key] = option;
                });
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _answers[key] == option ? const Color(0xFFE6FCF5) : Colors.white,
                  border: Border.all(
                    color: _answers[key] == option ? const Color(0xFF20C997) : Colors.grey.withOpacity(0.3),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(option, style: TextStyle(
                  fontSize: 16, 
                  fontWeight: _answers[key] == option ? FontWeight.bold : FontWeight.normal,
                  color: _answers[key] == option ? const Color(0xFF0CA678) : Colors.black87,
                )),
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildTextInputQuestion(String question, String key) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              onChanged: (val) => _answers[key] = val,
              decoration: InputDecoration(
                hintText: 'Écrivez ici...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF20C997), width: 2),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
