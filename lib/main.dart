import 'package:flutter/material.dart';
import 'collab.dart';
import 'practice.dart';
import 'advanced.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Music Studio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CollabMusic()),
                );
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.purple.shade900,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.purpleAccent, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.mic, color: Colors.purpleAccent, size: 36),
                    SizedBox(width: 16),
                    Text(
                      'Collab Music',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PracticeToggleScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.teal.shade900,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.tealAccent, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.tealAccent.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.piano, color: Colors.tealAccent, size: 36),
                    SizedBox(width: 16),
                    Text(
                      'Practice Timing',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PracticeToggleScreen extends StatefulWidget {
  const PracticeToggleScreen({super.key});

  @override
  State<PracticeToggleScreen> createState() => _PracticeToggleScreenState();
}

class _PracticeToggleScreenState extends State<PracticeToggleScreen> {
  bool isAdvanced = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Practice Timing',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ToggleButtons(
              isSelected: [!isAdvanced, isAdvanced],
              onPressed: (index) {
                setState(() {
                  isAdvanced = index == 1;
                });
              },
              borderRadius: BorderRadius.circular(20),
              selectedColor: Colors.black,
              fillColor: Colors.tealAccent,
              color: Colors.tealAccent,
              borderColor: Colors.tealAccent,
              selectedBorderColor: Colors.tealAccent,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text('Simple', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text('Advanced', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
      // FIX: use PracticeScreen (from advanced.dart) instead of non-existent Advanced()
      body: isAdvanced ? const PracticeScreen() : const PracticeTiming(),
    );
  }
}