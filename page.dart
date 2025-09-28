import 'package:flutter/material.dart';

void main() {
  runApp(const GRCWebsite());
}

class GRCWebsite extends StatelessWidget {
  const GRCWebsite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Reciprocal Colleges',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/about': (context) => const AboutPage(),
        '/admissions': (context) => const AdmissionsPage(),
        '/contact': (context) => const ContactPage(),
        // Add more pages as needed
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.blue.shade700,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            'GLOBAL RECIPROCAL COLLEGES',
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Touching Hearts, Renewing Minds, Transforming Lives',
            style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/admissions');
            },
            child: const Text('Apply Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String body, {String? route}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(body),
          if (route != null)
            TextButton(
              onPressed: () {
                // maybe navigate
              },
              child: const Text('Learn More'),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GRC'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            child: const Text('About', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/admissions'),
            child: const Text('Admissions', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/contact'),
            child: const Text('Contact', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildSection(
              'Mission & Vision',
              'GRC is creating a culture for successful, socially responsible, morally upright skilled workers and highly competent professionals through values-based quality education. Vision: A global community of excellent individuals with values.',
              route: '/about',
            ),
            _buildSection(
              'Admissions & Scholarship',
              'We offer open admission and various scholarship programs. Check the Admission page for details.',
              route: '/admissions',
            ),
            _buildSection(
              'Contact Us',
              'See our contact page for address, emails, phone numbers.',
              route: '/contact',
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      footer: Container(
        color: Colors.blueGrey.shade900,
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: const Center(
          child: Text(
            '© 2025 Global Reciprocal Colleges',
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  final String _aboutText = '''
GRC is creating a culture for successful, socially responsible, morally upright skilled workers and highly competent professionals through values-based quality education.

With a dream of accessible education, GRC was founded by Chairman Vicente N. Ongtenco. Over the years, the institution has expanded its course offerings including Education, Business, IT, Accountancy, etc.  
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About GRC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(_aboutText),
      ),
    );
  }
}

class AdmissionsPage extends StatelessWidget {
  const AdmissionsPage({Key? key}) : super(key: key);

  final String _admissionsText = '''
Admission Policy: GRC practices open admission, welcoming applicants regardless of age, gender, religion, creed.  

Freshman Requirements:
- Form 137 / 138A  
- Good Moral Character  
- 2 pcs 2×2 & 1×1 photos  
- Birth certificate (PSA)  
- etc  

Transferee / Cross-enrollee requirements:
- Certificate of Grades  
- Honorable Dismissal  
- TOR, etc  

You can pay for the entrance exam (GRC CAT) fee, take exams, then proceed with enrollment.  
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admissions'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(_admissionsText),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  final String _contactInfo = '''
Physical Address:
454 GRC Bldg., Rizal Ave. corner 9th Ave, East Grace Park, Caloocan City 1400 Metro Manila  

Phone & Email:
Admissions: 09519637603 / 09283875420  
Email: admissions@grc.edu.ph  
Registrar: 8-452-2945  
Other offices: see website  
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(_contactInfo),
      ),
    );
  }
}
