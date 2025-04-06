import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'job_service.dart';

class JobDetailPage extends StatefulWidget {
  final Job job;
  const JobDetailPage({super.key, required this.job});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _openMapWithDirections() async {
    try {
      final currentPosition = await _getCurrentLocation();
      if (!mounted) return;

      final origin = '${currentPosition.latitude},${currentPosition.longitude}';
      final destination = '${widget.job.latitude},${widget.job.longitude}';

      final url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=driving',
      );

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open Google Maps')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.job;

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
            const SizedBox(height: 10),
            Text('Category: ${job.category}'),
            Text('Type: ${job.locationType}'),
            Text('Salary: ${job.salary}'),
            if (job.locationType != 'remote')
              Text('Location: (${job.latitude}, ${job.longitude})',
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Apply Now')),
            const SizedBox(height: 10),
            if (job.locationType != 'remote')
              ElevatedButton(
                  onPressed: _openMapWithDirections,
                  child: const Text('View Distance on Google Maps')),
          ],
        ),
      ),
    );
  }
}
