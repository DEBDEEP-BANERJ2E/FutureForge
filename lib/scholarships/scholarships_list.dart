import 'package:flutter/material.dart';

class ScholarshipsListPage extends StatelessWidget {
  const ScholarshipsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scholarships')),
      body: const Center(child: Text('Scholarships Listings Page')),
    );
  }
}