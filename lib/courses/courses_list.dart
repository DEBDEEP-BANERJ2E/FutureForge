import 'package:flutter/material.dart';

class CoursesListPage extends StatelessWidget {
  const CoursesListPage({super.key});

  void _openAIGeneratePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AIGeneratePage()),
    );
  }

  void _openLeaderboardPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LeaderboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.smart_toy),
            onPressed: () => _openAIGeneratePage(context),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildCourseSection(
              'Tech Courses',
              [
                'AI & Machine Learning',
                'Web Development',
                'Cybersecurity',
                'Mobile App Development',
                'Data Science'
              ],
              context),
          _buildCourseSection(
              'Non-Tech Courses',
              [
                'Business Management',
                'Creative Writing',
                'Marketing',
                'Photography',
                'Finance & Investment'
              ],
              context),
        ],
      ),
    );
  }

  Widget _buildCourseSection(
      String title, List<String> courses, BuildContext context) {
    return ExpansionTile(
      title: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      children: courses
          .map((course) => ListTile(
                title: Text(course),
                trailing: ElevatedButton(
                  onPressed: () => _openLeaderboardPage(context),
                  child: const Text('Leaderboard'),
                ),
              ))
          .toList(),
    );
  }
}

class AIGeneratePage extends StatelessWidget {
  const AIGeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Generate Courses')),
      body: const Center(child: Text('AI Course generator Coming Soon!')),
    );
  }
}

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: const Center(child: Text('Leaderboard Data Here')),
    );
  }
}
