// job_service.dart
class Job {
  final String title;
  final String category;
  final String description;
  final String image;

  Job(
      {required this.title,
      required this.category,
      required this.description,
      required this.image});
}

class JobService {
  static Map<String, List<Job>> getJobs() {
    return {
      'Tech Jobs': [
        Job(
            title: 'Video Editor',
            category: 'Tech',
            description: 'Edit and create engaging videos.',
            image: 'assets/video_editing.jpg'),
        Job(
            title: 'Thumbnail Designer',
            category: 'Tech',
            description: 'Design catchy YouTube thumbnails.',
            image: 'assets/thumbnail_design.jpg'),
        Job(
            title: 'UI/UX Designer',
            category: 'Tech',
            description: 'Design intuitive user experiences.',
            image: 'assets/uiux.jpg'),
        Job(
            title: 'Mobile App Developer',
            category: 'Tech',
            description: 'Develop mobile applications for Android & iOS.',
            image: 'assets/mobile_dev.webp'),
      ],
      'Non-Tech Jobs': [
        Job(
            title: 'Medical Assistant',
            category: 'Non-Tech',
            description: 'Assist doctors in clinical tasks.',
            image: 'assets/medical_assistant.jpeg'),
        Job(
            title: 'Farmer',
            category: 'Non-Tech',
            description: 'Work in agriculture and grow crops.',
            image: 'assets/farming.jpg'),
        Job(
            title: 'Electrician',
            category: 'Non-Tech',
            description: 'Fix electrical issues and wiring.',
            image: 'assets/electrician.jpg'),
        Job(
            title: 'Plumber',
            category: 'Non-Tech',
            description: 'Install and repair plumbing systems.',
            image: 'assets/plumber.jpeg'),
      ],
    };
  }
}
