import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_service.dart';

class TextTestimonyScreen extends StatefulWidget {
  const TextTestimonyScreen({super.key});

  @override
  State<TextTestimonyScreen> createState() => _TextTestimonyScreenState();
}

class _TextTestimonyScreenState extends State<TextTestimonyScreen> {
  final _contentController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitTestimony() async {
    if (_contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez écrire quelques mots avant d\'envoyer.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final token = await ApiService().getToken();
      
      final response = await http.post(
        // Uri.parse('http://127.0.0.1:8000/api/submissions/'), // Web/iOS
        Uri.parse('http://10.0.2.2:8000/api/submissions/'), // Android Emulator
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'violence_type': 'Non spécifié (Texte libre)',
          'content_text': _contentController.text.trim(),
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
      setState(() => _isSubmitting = false);
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
              Navigator.pop(context); // Close dialog
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
        title: const Text('Récit écrit'),
        backgroundColor: const Color(0xFFD6336C),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: const Color(0xFFF8F9FA),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Racontez avec vos propres mots. Prenez votre temps.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
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
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    hintText: 'Commencez à écrire ici...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6336C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _isSubmitting ? null : _submitTestimony,
                child: _isSubmitting 
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Envoyer mon témoignage', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
