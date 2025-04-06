// job_list.dart

import 'package:flutter/material.dart';
import 'job_service.dart';
import 'job_detail.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({super.key});

  @override
  State<JobListPage> createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  final Map<String, bool> _showAll = {};

  @override
  Widget build(BuildContext context) {
    final jobCategories = JobService.getJobs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Listings'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: jobCategories.entries.map((entry) {
          final category = entry.key;
          final jobs = entry.value;
          final showAll = _showAll[category] ?? false;
          final jobsToShow = showAll ? jobs : jobs.take(4).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...jobsToShow.map((job) => JobCard(job: job)),
              if (!showAll && jobs.length > 4)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showAll[category] = true;
                    });
                  },
                  child: const Text('More...'),
                ),
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
        context,
        MaterialPageRoute(builder: (context) => JobDetailPage(job: job)),
      ),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Image.asset(
            job.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(
            job.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(job.category),
              Text("Type: ${job.locationType}"),
              Text("Salary: ${job.salary}"),
            ],
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
