import 'package:flutter/material.dart';

class ScholarshipsListPage extends StatelessWidget {
  const ScholarshipsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scholarships'),
      automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildCategory(context, 'Merit-based Scholarships', [
            'National Talent Scholarship',
            'Academic Excellence Grant',
            'STEM Scholars Program'
          ]),
          _buildCategory(context, 'Need-based Scholarships', [
            'Financial Aid Scholarship',
            'Underprivileged Student Grant'
          ]),
          _buildCategory(context, 'Research Grants', [
            'AI Research Fellowship',
            'Medical Research Funding'
          ]),
          _buildCategory(context, 'International Scholarships', [
            'Global Leaders Scholarship',
            'Study Abroad Grant'
          ]),
        ],
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String category, List<String> scholarships) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ExpansionTile(
        title: Text(category, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        children: scholarships.map((scholarship) {
          return ListTile(
            title: Text(scholarship),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScholarshipDetailPage(scholarshipName: scholarship),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}

class ScholarshipDetailPage extends StatelessWidget {
  final String scholarshipName;
  const ScholarshipDetailPage({super.key, required this.scholarshipName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(scholarshipName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              scholarshipName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Details about this scholarship will be displayed here. Include eligibility criteria, application process, and deadlines.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
