import 'package:flutter/material.dart';

class InternshipListPage extends StatelessWidget {
  const InternshipListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internships'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SectionTitle(title: 'Tech Internships'),
          InternshipCard(
            title: 'Flutter Development Intern',
            company: 'TechCorp',
            image: 'assets/flutter_dev.png',
            duration: '3 months',
          ),
          InternshipCard(
            title: 'UI/UX Design Intern',
            company: 'Creative Studios',
            image: 'assets/uiux.jpeg',
            duration: '6 months',
          ),
          const SectionTitle(title: 'Non-Tech Internships'),
          InternshipCard(
            title: 'Marketing Intern',
            company: 'BrandWorks',
            image: 'assets/marketing.png',
            duration: '4 months',
          ),
          InternshipCard(
            title: 'Human Resources Intern',
            company: 'HR Solutions',
            image: 'assets/hr.jpeg',
            duration: '5 months',
          ),
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
  final String title;
  final String company;
  final String image;
  final String duration;

  const InternshipCard({
    required this.title,
    required this.company,
    required this.image,
    required this.duration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$company • Duration: $duration'),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          // Navigate to internship details page (to be implemented)
        },
      ),
    );
  }
}
