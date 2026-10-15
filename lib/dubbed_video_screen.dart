import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DubbedVideoScreen extends StatefulWidget {
  final String title;
  final String summary;
  final VoidCallback onReward;

  const DubbedVideoScreen({
    super.key,
    required this.title,
    required this.summary,
    required this.onReward,
  });

  @override
  State<DubbedVideoScreen> createState() => _DubbedVideoScreenState();
}

class _DubbedVideoScreenState extends State<DubbedVideoScreen> {
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    await _flutterTts.setLanguage("vi-VN");
    await _flutterTts.setSpeechRate(0.5);
    if (widget.summary.isNotEmpty) {
      await _flutterTts.speak(widget.summary);
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.summary, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onReward();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã nhận 1000 xu thưởng!')),
                );
              },
              child: const Text('Nhận thưởng khi xem xong'),
            ),
          ],
        ),
      ),
    );
  }
}