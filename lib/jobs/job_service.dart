class Job {
  final String title;
  final String category;
  final String description;
  final String image;
  final String salary;
  final String locationType; // 'remote', 'on-site', 'hybrid'
  final double? latitude;
  final double? longitude;

  Job({
    required this.title,
    required this.category,
    required this.description,
    required this.image,
    required this.salary,
    required this.locationType,
    this.latitude,
    this.longitude,
  });
}

class JobService {
  static Map<String, List<Job>> getJobs() {
    return {
      'Non-Tech Jobs': [
        Job(
          title: 'Medical Assistant',
          category: 'Non-Tech',
          description: 'Assist doctors in clinical tasks.',
          image: 'assets/medical_assistant.jpeg',
          salary: '₹30,000/month',
          locationType: 'on-site',
          latitude: 22.6725,
          longitude: 88.3495,
        ),
        Job(
          title: 'Farmer',
          category: 'Non-Tech',
          description: 'Work in agriculture and grow crops.',
          image: 'assets/farming.jpg',
          salary: '₹20,000/month',
          locationType: 'remote',
        ),
        Job(
          title: 'Electrician',
          category: 'Non-Tech',
          description: 'Fix electrical issues and wiring.',
          image: 'assets/electrician.jpg',
          salary: '₹25,000/month',
          locationType: 'on-site',
          latitude: 22.6732,
          longitude: 88.3510,
        ),
        Job(
          title: 'Plumber',
          category: 'Non-Tech',
          description: 'Install and repair plumbing systems.',
          image: 'assets/plumber.jpeg',
          salary: '₹22,000/month',
          locationType: 'hybrid',
          latitude: 22.6702,
          longitude: 88.3480,
        ),
        Job(
          title: 'Security Guard',
          category: 'Non-Tech',
          description: 'Ensure the safety and security of premises.',
          image: 'assets/security_guard.jpg',
          salary: '₹18,000/month',
          locationType: 'on-site',
          latitude: 22.6691,
          longitude: 88.3522,
        ),
        Job(
          title: 'Delivery Executive',
          category: 'Non-Tech',
          description: 'Deliver packages to customers in a timely manner.',
          image: 'assets/delivery.jpg',
          salary: '₹22,000/month',
          locationType: 'hybrid',
          latitude: 22.6728,
          longitude: 88.3474,
        ),
      ],
      'Tech Jobs': [
        Job(
          title: 'Video Editor',
          category: 'Tech',
          description: 'Edit and create engaging videos.',
          image: 'assets/video_editing.jpg',
          salary: '₹25,000/month',
          locationType: 'remote',
        ),
        Job(
          title: 'Thumbnail Designer',
          category: 'Tech',
          description: 'Design catchy YouTube thumbnails.',
          image: 'assets/thumbnail_design.jpg',
          salary: '₹15,000/month',
          locationType: 'remote',
        ),
        Job(
          title: 'UI/UX Designer',
          category: 'Tech',
          description: 'Design intuitive user experiences.',
          image: 'assets/uiux.jpg',
          salary: '₹45,000/month',
          locationType: 'hybrid',
          latitude: 22.6708,
          longitude: 88.3535,
        ),
        Job(
          title: 'Mobile App Developer',
          category: 'Tech',
          description: 'Develop mobile applications for Android & iOS.',
          image: 'assets/mobile_dev.webp',
          salary: '₹60,000/month',
          locationType: 'on-site',
          latitude: 22.6689,
          longitude: 88.3501,
        ),
        Job(
          title: 'Backend Developer',
          category: 'Tech',
          description: 'Build and maintain server-side logic.',
          image: 'assets/backend.jpg',
          salary: '₹65,000/month',
          locationType: 'on-site',
          latitude: 22.6730,
          longitude: 88.3492,
        ),
        Job(
          title: 'QA Tester',
          category: 'Tech',
          description: 'Test software for bugs and usability issues.',
          image: 'assets/qa.jpg',
          salary: '₹40,000/month',
          locationType: 'hybrid',
          latitude: 22.6695,
          longitude: 88.3489,
        ),
      ],
    };
  }
}
