import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const HopkinsFlagApp());
}

class HopkinsFlagApp extends StatelessWidget {
  const HopkinsFlagApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hopkins Girls Flag Football',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.yellow,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Home Screen
// ─────────────────────────────────────────────────────────────────────────────

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, dynamic>> _menuItems = [
    {'title': 'Registration', 'icon': Icons.app_registration},
    {'title': 'Scholarship Application', 'icon': Icons.school},
    {'title': 'Speed Training', 'icon': Icons.directions_run},
    {'title': 'Surveys', 'icon': Icons.poll},
    {'title': 'Practice Schedule', 'icon': Icons.calendar_today},
    {'title': 'Game Schedule', 'icon': Icons.sports_football},
    {'title': 'Team Links', 'icon': Icons.link},
  ];

  void _navigate(BuildContext context, String title) {
    Widget destination;
    switch (title) {
      case 'Registration':
        destination = const RegistrationScreen();
        break;
      case 'Scholarship Application':
        destination = const ScholarshipScreen();
        break;
      case 'Speed Training':
        destination = const SpeedTrainingScreen();
        break;
      case 'Surveys':
        destination = const SurveysScreen();
        break;
      case 'Practice Schedule':
        destination = const ScheduleImageScreen(
          title: 'Practice Schedule',
          assetPath: 'assets/schedule.jpg',
        );
        break;
      case 'Game Schedule':
        destination = const ScheduleImageScreen(
          title: 'Game Schedule',
          assetPath: 'assets/schedule.jpg',
        );
        break;
      case 'Team Links':
        destination = const TeamLinksScreen();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hopkins Girls Flag Football'),
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: colorScheme.primary,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Image.asset(
              'assets/logo.png',
              height: 100,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.sports_football,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: Icon(
                      item['icon'] as IconData,
                      color: colorScheme.primary,
                    ),
                    title: Text(
                      item['title'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _navigate(context, item['title'] as String),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Registration Screen
// ─────────────────────────────────────────────────────────────────────────────

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration submitted successfully!')),
      );
      _nameController.clear();
      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex =
                      RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Submit Registration'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Scholarship Screen
// ─────────────────────────────────────────────────────────────────────────────

class ScholarshipScreen extends StatefulWidget {
  const ScholarshipScreen({super.key});

  @override
  State<ScholarshipScreen> createState() => _ScholarshipScreenState();
}

class _ScholarshipScreenState extends State<ScholarshipScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _essayController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _essayController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Scholarship application submitted successfully!')),
      );
      _nameController.clear();
      _essayController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scholarship Application')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _essayController,
                decoration: const InputDecoration(
                  labelText: 'Essay',
                  hintText: 'Write your scholarship essay here...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Essay is required';
                  }
                  if (value.trim().length < 50) {
                    return 'Essay must be at least 50 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Submit Application'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Speed Training Screen
// ─────────────────────────────────────────────────────────────────────────────

class SpeedTrainingScreen extends StatelessWidget {
  const SpeedTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speed Training')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Speed Training Program',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Our speed training program is designed to help players develop the '
              'quickness and agility needed to excel in flag football.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Weekly Drills',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• 40-yard dash intervals'),
            Text('• Ladder footwork drills'),
            Text('• Cone agility circuits'),
            Text('• Route running techniques'),
            Text('• Reaction time training'),
            SizedBox(height: 20),
            Text(
              'Training Schedule',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Monday & Wednesday: Speed and agility (6:00–7:30 PM)'),
            Text('Friday: Game-speed scrimmage (5:00–7:00 PM)'),
            SizedBox(height: 20),
            Text(
              'Tips for Success',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• Stretch before and after every session'),
            Text('• Stay hydrated throughout training'),
            Text('• Focus on form over speed'),
            Text('• Rest adequately between sessions'),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Surveys Screen
// ─────────────────────────────────────────────────────────────────────────────

class SurveysScreen extends StatelessWidget {
  const SurveysScreen({super.key});

  static const List<Map<String, String>> _surveys = [
    {
      'title': 'Player Interest Survey',
      'url': 'https://forms.google.com/player-interest',
    },
    {
      'title': 'Season Feedback Survey',
      'url': 'https://forms.google.com/season-feedback',
    },
    {
      'title': 'Parent Satisfaction Survey',
      'url': 'https://forms.google.com/parent-satisfaction',
    },
    {
      'title': 'Equipment Needs Survey',
      'url': 'https://forms.google.com/equipment-needs',
    },
  ];

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Surveys')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _surveys.length,
        itemBuilder: (context, index) {
          final survey = _surveys[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.poll),
              title: Text(survey['title']!),
              subtitle: Text(
                survey['url']!,
                style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => _launchUrl(context, survey['url']!),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Schedule Image Screen (pinch-to-zoom)
// ─────────────────────────────────────────────────────────────────────────────

class ScheduleImageScreen extends StatelessWidget {
  final String title;
  final String assetPath;

  const ScheduleImageScreen({
    super.key,
    required this.title,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: InteractiveViewer(
        panEnabled: true,
        minScale: 0.5,
        maxScale: 4.0,
        child: Center(
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Center(
              child: Text('Schedule image not available'),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Team Links Screen
// ─────────────────────────────────────────────────────────────────────────────

class TeamLinksScreen extends StatelessWidget {
  const TeamLinksScreen({super.key});

  static const List<Map<String, String>> _links = [
    {
      'title': 'Team Website',
      'url': 'https://www.hopkinsflagfootball.com',
    },
    {
      'title': 'Minnesota Girls Flag Football',
      'url': 'https://www.mngirlsflagfootball.com',
    },
    {
      'title': 'USA Football',
      'url': 'https://usafootball.com',
    },
    {
      'title': 'Team Instagram',
      'url': 'https://www.instagram.com/hopkinsgirls_flagfootball',
    },
    {
      'title': 'Register on MaxPreps',
      'url': 'https://www.maxpreps.com',
    },
  ];

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Team Links')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _links.length,
        itemBuilder: (context, index) {
          final link = _links[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.link),
              title: Text(link['title']!),
              subtitle: Text(
                link['url']!,
                style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline),
              ),
              trailing: const Icon(Icons.open_in_new),
              onTap: () => _launchUrl(context, link['url']!),
            ),
          );
        },
      ),
    );
  }
}