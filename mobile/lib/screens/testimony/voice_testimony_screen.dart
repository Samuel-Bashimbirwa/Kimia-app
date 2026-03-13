import 'package:flutter/material.dart';
import 'package:record/record.dart';

class VoiceTestimonyScreen extends StatefulWidget {
  const VoiceTestimonyScreen({super.key});

  @override
  State<VoiceTestimonyScreen> createState() => _VoiceTestimonyScreenState();
}

class _VoiceTestimonyScreenState extends State<VoiceTestimonyScreen> {
  late final AudioRecorder _audioRecorder;
  bool _isRecording = false;
  String? _audioPath;

  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        await _audioRecorder.start(const RecordConfig(), path: ''); // Path depends on platform
        setState(() => _isRecording = true);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _audioPath = path;
      });
    } catch (e) {
        print(e);
    }
  }

  void _submit() {
      // Mock submit
      showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Témoignage envoyé'),
        content: const Text('Fichier audio sauvegardé de manière chiffrée. La retranscription est en cours.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
              Navigator.pop(context); 
              Navigator.pop(context); 
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
        title: const Text('Message vocal'),
        backgroundColor: const Color(0xFF4C6EF5),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isRecording ? 'Enregistrement en cours...' : 'Appuyez pour enregistrer',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _isRecording ? _stopRecording : _startRecording,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isRecording ? Colors.redAccent : const Color(0xFF4C6EF5),
                  boxShadow: [
                    BoxShadow(
                      color: (_isRecording ? Colors.redAccent : const Color(0xFF4C6EF5)).withOpacity(0.4),
                      blurRadius: _isRecording ? 30 : 15,
                      spreadRadius: _isRecording ? 10 : 2,
                    )
                  ],
                ),
                child: Icon(
                  _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                  color: Colors.white,
                  size: 80,
                ),
              ),
            ),
            const SizedBox(height: 60),
            if (_audioPath != null) ...[
                const Text('Enregistrement terminé.', style: TextStyle(color: Colors.green, fontSize: 16)),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4C6EF5),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: _submit,
                  child: const Text('Envoyer mon témoignage', style: TextStyle(fontSize: 16)),
                ),
            ]
          ],
        ),
      ),
    );
  }
}
