import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const HopkinsGirlsFlagFootballApp());
}

// ---------------------------------------------------------------------------
// App root
// ---------------------------------------------------------------------------
class HopkinsGirlsFlagFootballApp extends StatelessWidget {
  const HopkinsGirlsFlagFootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hopkins Girls Flag Football',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.black,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.black,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// Home screen
// ---------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Map<String, dynamic>> _menuItems = [
    {'label': 'Registration', 'icon': Icons.app_registration},
    {'label': 'Scholarship Application', 'icon': Icons.school},
    {'label': 'Speed Training', 'icon': Icons.directions_run},
    {'label': 'Surveys', 'icon': Icons.poll},
    {'label': 'Practice Schedule', 'icon': Icons.event_note},
    {'label': 'Game Schedule', 'icon': Icons.sports_football},
    {'label': 'Team Links', 'icon': Icons.link},
  ];

  void _navigate(BuildContext context, String label) {
    Widget screen;
    switch (label) {
      case 'Registration':
        screen = const RegistrationScreen();
        break;
      case 'Scholarship Application':
        screen = const ScholarshipScreen();
        break;
      case 'Speed Training':
        screen = const SpeedTrainingScreen();
        break;
      case 'Surveys':
        screen = const SurveysScreen();
        break;
      case 'Practice Schedule':
        screen = const ScheduleScreen(title: 'Practice Schedule');
        break;
      case 'Game Schedule':
        screen = const ScheduleScreen(title: 'Game Schedule');
        break;
      case 'Team Links':
        screen = const TeamLinksScreen();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Logo
          Center(
            child: Image.asset(
              'assets/logo.png',
              height: 160,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.sports_football,
                size: 160,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Menu buttons
          ..._menuItems.map(
            (item) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ElevatedButton.icon(
                icon: Icon(item['icon'] as IconData),
                label: Text(
                  item['label'] as String,
                  style: const TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => _navigate(context, item['label'] as String),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Registration screen
// ---------------------------------------------------------------------------
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
        const SnackBar(
          content: Text('Registration submitted successfully!'),
          backgroundColor: Colors.green,
        ),
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
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scholarship Application screen
// ---------------------------------------------------------------------------
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
          content: Text('Scholarship application submitted successfully!'),
          backgroundColor: Colors.green,
        ),
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
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
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
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Essay is required';
                  }
                  if (value.trim().length < 10) {
                    return 'Essay must be at least 10 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Speed Training screen
// ---------------------------------------------------------------------------
class SpeedTrainingScreen extends StatelessWidget {
  const SpeedTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speed Training')),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Speed Training Program',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Our speed training program is designed to help players improve their '
              'agility, acceleration, and overall athletic performance on the field.\n\n'
              '• Warm-up drills and dynamic stretching\n'
              '• 40-yard dash technique\n'
              '• Ladder and cone agility drills\n'
              '• Resisted sprint training\n'
              '• Plyometric exercises for explosive power\n'
              '• Cool-down and recovery routines\n\n'
              'Sessions are held weekly. Please check the Practice Schedule for dates and times.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Surveys screen
// ---------------------------------------------------------------------------
class SurveysScreen extends StatelessWidget {
  const SurveysScreen({super.key});

  static const List<Map<String, String>> _surveys = [
    {
      'title': 'Season Feedback Survey',
      'url': 'https://forms.google.com/season-feedback',
    },
    {
      'title': 'Player Wellness Check',
      'url': 'https://forms.google.com/player-wellness',
    },
    {
      'title': 'Coaching & Practice Survey',
      'url': 'https://forms.google.com/coaching-practice',
    },
    {
      'title': 'Equipment Needs Survey',
      'url': 'https://forms.google.com/equipment-needs',
    },
  ];

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
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
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _surveys.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final survey = _surveys[index];
          return ListTile(
            leading: const Icon(Icons.open_in_browser, color: Colors.blue),
            title: Text(survey['title']!),
            subtitle: Text(
              survey['url']!,
              style: const TextStyle(color: Colors.blue),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => _openUrl(context, survey['url']!),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Schedule screen (Practice & Game)
// ---------------------------------------------------------------------------
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key, required this.title});

  final String title;

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
            'assets/schedule.jpg',
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Center(
              child: Text(
                'Schedule image not available.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Team Links screen
// ---------------------------------------------------------------------------
class TeamLinksScreen extends StatelessWidget {
  const TeamLinksScreen({super.key});

  static const List<Map<String, String>> _links = [
    {
      'title': 'Hopkins Girls Flag Football Website',
      'url': 'https://www.hopkinsflagfootball.com',
    },
    {
      'title': 'Team Instagram',
      'url': 'https://www.instagram.com/hopkinsgirls_flagfootball',
    },
    {
      'title': 'USA Football Resources',
      'url': 'https://www.usafootball.com',
    },
    {
      'title': 'MN Girls Flag Football',
      'url': 'https://www.mngirlsflagfootball.org',
    },
    {
      'title': 'Team Store',
      'url': 'https://www.hopkinsflagfootball.com/store',
    },
  ];

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
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
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _links.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final link = _links[index];
          return ListTile(
            leading: const Icon(Icons.link, color: Colors.blue),
            title: Text(link['title']!),
            subtitle: Text(
              link['url']!,
              style: const TextStyle(color: Colors.blue),
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => _openUrl(context, link['url']!),
          );
        },
      ),
    );
  }
}