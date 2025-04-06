import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'internship_service.dart';

class InternshipDetailPage extends StatelessWidget {
  final Internship internship;

  const InternshipDetailPage({super.key, required this.internship});

  @override
  Widget build(BuildContext context) {
    final hasMap = internship.locationType.toLowerCase() != 'remote' &&
        internship.latitude != null &&
        internship.longitude != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(internship.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              internship.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    internship.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${internship.company} • ${internship.duration}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location Type: ${internship.locationType}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            if (hasMap)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 300,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        internship.latitude!,
                        internship.longitude!,
                      ),
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('internshipLocation'),
                        position: LatLng(
                          internship.latitude!,
                          internship.longitude!,
                        ),
                        infoWindow: InfoWindow(title: internship.title),
                      ),
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
