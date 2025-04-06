import 'package:flutter/material.dart';
import '../auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  final List<Map<String, dynamic>> features = [
    {
      'icon': Icons.feedback,
      'title': 'AI-Personalized Feedback',
      'description': 'Instant feedback on resumes, skills, and projects.',
    },
    {
      'icon': Icons.work,
      'title': 'Skill-based Marketplace',
      'description': 'Jobs and internships tailored to your skillset.',
    },
    {
      'icon': Icons.school,
      'title': 'AI & Human-created Courses',
      'description': 'Learn with dynamic AI and expert content.',
    },
    {
      'icon': Icons.card_giftcard,
      'title': 'Scholarship Listings',
      'description': 'Find and apply for latest scholarships.',
    },
    {
      'icon': Icons.verified_user,
      'title': 'Blockchain Skill Verification',
      'description': 'Certify and showcase skills on-chain.',
    },
    {
      'icon': Icons.chat,
      'title': 'AI Chatbot Suggestions',
      'description': 'Personalized learning & career advice.',
    },
    {
      'icon': Icons.mic,
      'title': 'Multilingual and Voice Input',
      'description': 'Speak or type in your preferred language.',
    },
    {
      'icon': Icons.stars,
      'title': 'Gamified Learning',
      'description': 'Earn rewards as you upskill.',
    },
  ];

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      height: 180, // Increased height for the container
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0x14FFFFFF), // 0x14 = 8% opacity
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51), // 20% opacity
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(fontSize: 13, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark Overlay
          Container(
            color: const Color.fromARGB(179, 0, 0, 0), // Replaced withAlpha
          ),
          // Main Content
          FadeTransition(
            opacity: _fadeIn,
            child: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    const Text(
                      'Welcome to FutureForge',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Empowering you with AI, Blockchain & Opportunities',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 25),

                    // Get Started Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Get Started',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Features Grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 0.85,
                      children: features
                          .map(
                            (f) => _buildFeatureTile(
                              icon: f['icon'],
                              title: f['title'],
                              description: f['description'],
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
