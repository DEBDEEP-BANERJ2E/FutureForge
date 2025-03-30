// job_detail.dart
import 'package:flutter/material.dart';
import 'job_service.dart';

class JobDetailPage extends StatelessWidget {
  final Job job;
  const JobDetailPage({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(job.image,
                width: double.infinity, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 10),
            Text(job.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(job.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Apply Now')),
          ],
        ),
      ),
    );
  }
}
