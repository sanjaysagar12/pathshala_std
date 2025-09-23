import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'screen/login_screen.dart';
import 'screen/home_screen.dart';
import 'screen/subject_detail_screen.dart';
import 'screen/notes_screen.dart';
import 'screen/learning_screen.dart';
import 'screen/test_screen.dart';
import 'screen/quiz_screen.dart';
import 'screen/ai_guide_screen.dart';


// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_gemma/flutter_gemma.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathshala',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4285F4),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
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
        if (settings.name == '/test') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => TestScreen(
              subjectName: args['subjectName'],
              subjectColor: args['subjectColor'],
              lessonTitle: args['lessonTitle'],
            ),
          );
        }
        if (settings.name == '/quiz') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => QuizScreen(
              subjectName: args['subjectName'],
              subjectColor: args['subjectColor'],
            ),
          );
        }
        if (settings.name == '/ai-guide') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => AIGuideScreen(
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