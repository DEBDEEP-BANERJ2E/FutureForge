import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  late stt.SpeechToText _speech;
  bool _isListening = false;
  final String _apiKey = "AIzaSyBvVNNsxVwo-OrNrVeXE7D9AlCH-uWd9Sw";
  late final GenerativeModel _model;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _model = GenerativeModel(model: "gemini-2.0-flash", apiKey: _apiKey);

  }

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    setState(() {
      _messages.add({"user": message});
      _messageController.clear();
    });

    final response = await _model.generateContent([Content.text(message)]);
    setState(() {
      _messages.add({"bot": response.text ?? "No response"});
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      List<int> fileBytes = await file.readAsBytes();
      Uint8List uint8FileBytes = Uint8List.fromList(fileBytes);
      String mimeType =
          result.files.single.extension ?? "application/octet-stream";

      setState(() {
        _messages.add({"user": "Sent a file: ${result.files.single.name}"});
      });

      final response = await _model.generateContent([
        Content.text("Analyze this file"),
        Content.data(mimeType, uint8FileBytes)
      ]);

      setState(() {
        _messages.add({"bot": response.text ?? "No response"});
      });
    }
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(onResult: (result) {
        setState(() {
          _messageController.text = result.recognizedWords;
        });
      });
    }
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                String sender = _messages[index].keys.first;
                return ListTile(
                  title: Text(_messages[index][sender]!),
                  subtitle: Text(sender == "user" ? "You" : "Bot"),
                  tileColor:
                      sender == "user" ? Colors.blue[100] : Colors.grey[200],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: _pickFile,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration:
                        const InputDecoration(hintText: "Type a message"),
                  ),
                ),
                IconButton(
                  icon: Icon(_isListening ? Icons.mic_off : Icons.mic),
                  onPressed: _isListening ? _stopListening : _startListening,
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
