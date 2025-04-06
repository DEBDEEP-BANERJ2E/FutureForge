import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../dashboard/dashboard_page.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:geocoding/geocoding.dart';
import '../shared/user_profile_data.dart';
import '../firebase_service.dart';

class OnboardingTabsPage extends StatefulWidget {
  final String language;
  const OnboardingTabsPage({super.key, required this.language});

  @override
  State<OnboardingTabsPage> createState() => _OnboardingTabsPageState();
}

class _OnboardingTabsPageState extends State<OnboardingTabsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  File? resume;
  final TextEditingController expectedSalaryController =
      TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      setState(() {
        cityController.text = place.locality ?? '';
        stateController.text =
            '${place.administrativeArea ?? ''}, ${place.country ?? ''}';
      });
    }
  }

  void pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx']);
    if (result != null) {
      setState(() {
        resume = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete Your Profile")),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Tab 1: Location
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              const Text("Where are you currently located?",
                  style: TextStyle(fontSize: 18)),
              TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: "City")),
              TextField(
                  controller: stateController,
                  decoration: const InputDecoration(labelText: "State")),
              ElevatedButton.icon(
                onPressed: getCurrentLocation,
                icon: const Icon(Icons.gps_fixed),
                label: const Text("Use GPS Location"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _tabController.animateTo(1),
                child: const Text("Continue"),
              )
            ]),
          ),
          // Tab 2: Job title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              const Text("What's your current job title?",
                  style: TextStyle(fontSize: 18)),
              DropdownButton<String>(
                value: null,
                hint: const Text("Select a job"),
                items: [
                  "Sales Executive",
                  "Marketing Executive",
                  "Student",
                  "Teacher",
                  "Graphic Designer"
                ]
                    .map((title) => DropdownMenuItem(
                          value: title,
                          child: Text(title),
                          onTap: () => jobTitleController.text = title,
                        ))
                    .toList(),
                onChanged: (_) {},
              ),
              TextField(
                  controller: jobTitleController,
                  decoration: const InputDecoration(
                      labelText: "Or type your job title")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _tabController.animateTo(2),
                child: const Text("Continue"),
              )
            ]),
          ),
          // Tab 3: Basic Details
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              const Text("Tell us more about you",
                  style: TextStyle(fontSize: 18)),
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Full Name")),
              TextField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: "Address")),
              TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: "Age"),
                  keyboardType: TextInputType.number),
              TextField(
                  controller: experienceController,
                  decoration:
                      const InputDecoration(labelText: "Experience (years)")),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: pickResume,
                child:
                    Text(resume != null ? "Resume Selected" : "Upload Resume"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _tabController.animateTo(3),
                child: const Text("Continue"),
              )
            ]),
          ),
          // Tab 4: Salary/Scholarship Expectations
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              const Text("What is your minimum expected salary or scholarship?",
                  style: TextStyle(fontSize: 18)),
              TextField(
                controller: expectedSalaryController,
                decoration:
                    const InputDecoration(labelText: "Enter amount in ₹"),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  UserProfileData.name = nameController.text;
                  UserProfileData.address = addressController.text;
                  UserProfileData.age = ageController.text;
                  UserProfileData.experience = experienceController.text;
                  UserProfileData.jobTitle = jobTitleController.text;
                  UserProfileData.city = cityController.text;
                  UserProfileData.stateAndCountry = stateController.text;
                  UserProfileData.resumePath = resume?.path ?? '';
                  UserProfileData.expectedSalary =
                      expectedSalaryController.text;

                  // Now go to dashboard (no changes needed there!)
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardPage()),
                  );
                  FirebaseService.saveUserProfile({
                    'name': UserProfileData.name,
                    'address': UserProfileData.address,
                    'age': UserProfileData.age,
                    'experience': UserProfileData.experience,
                    'jobTitle': UserProfileData.jobTitle,
                    'city': UserProfileData.city,
                    'stateAndCountry': UserProfileData.stateAndCountry,
                    'expectedSalary': UserProfileData.expectedSalary,
                  }, resume);
                },
                child: const Text("Continue"),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
