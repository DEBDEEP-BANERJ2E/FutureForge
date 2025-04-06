import 'package:flutter/material.dart';
import '../shared/user_profile_data.dart';
import '../firebase_service.dart';
import '../auth/onboarding_tabs_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    var data = await FirebaseService.fetchUserProfile();
    if (data != null) {
      setState(() {
        UserProfileData.name = data['name'] ?? '';
        UserProfileData.address = data['address'] ?? '';
        UserProfileData.age = data['age'] ?? '';
        UserProfileData.experience = data['experience'] ?? '';
        UserProfileData.jobTitle = data['jobTitle'] ?? '';
        UserProfileData.city = data['city'] ?? '';
        UserProfileData.stateAndCountry = data['stateAndCountry'] ?? '';
        UserProfileData.expectedSalary = data['expectedSalary'] ?? '';
        UserProfileData.resumePath = data['resumeUrl'] ?? '';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OnboardingTabsPage(language: 'en'),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${UserProfileData.name}'),
                  Text('Address: ${UserProfileData.address}'),
                  Text('Age: ${UserProfileData.age}'),
                  Text('Experience: ${UserProfileData.experience}'),
                  Text('Job Title: ${UserProfileData.jobTitle}'),
                  Text('City: ${UserProfileData.city}'),
                  Text('State & Country: ${UserProfileData.stateAndCountry}'),
                  Text('Expected Salary: ${UserProfileData.expectedSalary}'),
                  Text('Resume Path: ${UserProfileData.resumePath}'),
                ],
              ),
            ),
    );
  }
}
