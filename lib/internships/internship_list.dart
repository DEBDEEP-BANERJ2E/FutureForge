import 'package:flutter/material.dart';
import 'internship_service.dart';
import 'internship_detail.dart';

class InternshipListPage extends StatelessWidget {
  const InternshipListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final techInternships = InternshipService.getTechInternships();
    final nonTechInternships = InternshipService.getNonTechInternships();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Internships'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SectionTitle(title: 'Tech Internships'),
          ...techInternships
              .map((intern) => InternshipCard(internship: intern)),
          const SectionTitle(title: 'Non-Tech Internships'),
          ...nonTechInternships
              .map((intern) => InternshipCard(internship: intern)),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class InternshipCard extends StatelessWidget {
  final Internship internship;

  const InternshipCard({required this.internship, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(internship.image,
            width: 50, height: 50, fit: BoxFit.cover),
        title: Text(internship.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Text('${internship.company} • Duration: ${internship.duration}'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => InternshipDetailPage(internship: internship),
            ),
          );
        },
      ),
    );
  }
}
