class Internship {
  final String title;
  final String company;
  final String image;
  final String duration;
  final String locationType; // 'remote', 'on-site', 'hybrid'
  final double? latitude;
  final double? longitude;

  Internship({
    required this.title,
    required this.company,
    required this.image,
    required this.duration,
    required this.locationType,
    this.latitude,
    this.longitude,
  });
}

class InternshipService {
  static List<Internship> getTechInternships() {
    return [
      Internship(
        title: 'Flutter Development Intern',
        company: 'TechCorp',
        image: 'assets/flutter_dev.png',
        duration: '3 months',
        locationType: 'on-site',
        latitude: 28.6139,
        longitude: 77.2090,
      ),
      Internship(
        title: 'UI/UX Design Intern',
        company: 'Creative Studios',
        image: 'assets/uiux.jpeg',
        duration: '6 months',
        locationType: 'remote',
      ),
    ];
  }

  static List<Internship> getNonTechInternships() {
    return [
      Internship(
        title: 'Marketing Intern',
        company: 'BrandWorks',
        image: 'assets/marketing.png',
        duration: '4 months',
        locationType: 'hybrid',
        latitude: 22.9926,
        longitude: 88.9639,
      ),
      Internship(
        title: 'Human Resources Intern',
        company: 'HR Solutions',
        image: 'assets/hr.jpeg',
        duration: '5 months',
        locationType: 'on-site',
        latitude: 22.5726,
        longitude: 88.3639,
      ),
    ];
  }
}
