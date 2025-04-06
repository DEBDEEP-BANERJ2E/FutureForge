import 'package:flutter/material.dart';
import '../shared/user_profile_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("👤 Profile",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text("Name: ${UserProfileData.name}"),
            Text("Address: ${UserProfileData.address}"),
            Text("Age: ${UserProfileData.age}"),
            Text("Experience: ${UserProfileData.experience} years"),
            Text("Job Title: ${UserProfileData.jobTitle}"),
            Text("City: ${UserProfileData.city}"),
            Text("State/Country: ${UserProfileData.stateAndCountry}"),
            Text("Expected Salary: ₹${UserProfileData.expectedSalary}"),
            const SizedBox(height: 10),
            Text(
                "Resume: ${UserProfileData.resumePath.isNotEmpty ? UserProfileData.resumePath : 'Not uploaded'}"),
          ],
        ),
      ),
    );
  }
}
