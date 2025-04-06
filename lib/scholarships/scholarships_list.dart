import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScholarshipsListPage extends StatelessWidget {
  const ScholarshipsListPage({super.key});

  // 👇 Dummy data with placeIds (real placeIds needed for real map functionality)
  final List<Map<String, String>> nearbyNGOs = const [
    {
      'name': 'Helping Hands Foundation',
      'address': '123 Charity Lane',
      'placeId': 'ChIJN1t_tDeuEmsRUsoyG83frY4',
    },
    {
      'name': 'Hope for All NGO',
      'address': '456 Hope Street',
      'placeId': 'ChIJDbdkHFQayUwR7-8fITgxTmU',
    },
    {
      'name': 'EduBridge Trust',
      'address': '789 Education Avenue',
      'placeId': 'ChIJLfySpTOuEmsRsc_JfJtljdc',
    },
  ];

  final List<Map<String, String>> nearbyInstitutions = const [
    {
      'name': 'ABC Educational Services',
      'address': '12 Knowledge Road',
      'placeId': 'ChIJP3Sa8ziYEmsRUKgyFmh9AQM',
    },
    {
      'name': 'Future Scholars Pvt Ltd',
      'address': '88 Future Lane',
      'placeId': 'ChIJrTLr-GyuEmsRBfy61i59si0',
    },
    {
      'name': 'SkillUp Corporation',
      'address': '99 Skills Street',
      'placeId': 'ChIJD7fiBh9u5kcRYJSMaMOCCwQ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scholarships'),
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
          const SizedBox(height: 24),

          const Text(
            'Nearby NGOs',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildNearbyList(nearbyNGOs),

          const SizedBox(height: 24),

          const Text(
            'Nearby Institutions & Companies Providing Financial Aid',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildNearbyList(nearbyInstitutions),
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

  Widget _buildNearbyList(List<Map<String, String>> places) {
    return Column(
      children: places.map((place) {
        return ListTile(
          leading: const Icon(Icons.location_on, color: Colors.blueAccent),
          title: Text(place['name']!),
          subtitle: Text(place['address']!),
          trailing: const Icon(Icons.map),
          onTap: () => _openMap(place['placeId']!),
        );
      }).toList(),
    );
  }

  void _openMap(String placeId) async {
    final url = 'https://www.google.com/maps/search/?api=1&query_place_id=$placeId';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
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
