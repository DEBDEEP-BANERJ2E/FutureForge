import 'package:flutter/material.dart';

class InternshipListPage extends StatelessWidget {
  const InternshipListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Internship')),
      body: const Center(child: Text('Internship Listings Page')),
    );
  }
}
