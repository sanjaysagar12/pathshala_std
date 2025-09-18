import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'screen/login_screen.dart';
import 'screen/home_screen.dart';
import 'screen/subject_detail_screen.dart';
import 'screen/notes_screen.dart';
import 'screen/learning_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathshala',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/subject-detail') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => SubjectDetailScreen(
              subjectName: args['name'],
              subjectIcon: args['icon'],
              subjectColor: args['color'],
            ),
          );
        }
        if (settings.name == '/notes') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => NotesScreen(
              subjectName: args['subjectName'],
              subjectColor: args['subjectColor'],
            ),
          );
        }
        if (settings.name == '/learning') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => LearningScreen(
              subjectName: args['subjectName'],
              subjectColor: args['subjectColor'],
            ),
          );
        }
        return null;
      },
    );
  }
}