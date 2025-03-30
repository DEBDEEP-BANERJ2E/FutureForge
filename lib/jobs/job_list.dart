// job_list.dart
import 'package:flutter/material.dart';
import 'job_service.dart';
import 'job_detail.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobCategories = JobService.getJobs();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Job Listings'),
      automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: jobCategories.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.key, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...entry.value.map((job) => JobCard(job: job)),
              const SizedBox(height: 20),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context, MaterialPageRoute(builder: (context) => JobDetailPage(job: job))),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.asset(job.image, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(job.category),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}