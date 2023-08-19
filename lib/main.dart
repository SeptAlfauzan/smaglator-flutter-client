import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smaglator_web/auth_page.dart';
import 'package:smaglator_web/firebase_options.dart';
import 'package:smaglator_web/hand_detection.dart';
import 'package:smaglator_web/home_page.dart';
import 'package:smaglator_web/speech.dart';
import 'package:smaglator_web/text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const AuthPage(),
      routes: {
        '/dashboard': (context) => const HomePage(),
        '/speech': (context) => const SpeechScreen(),
        '/text': (context) => const TextListScreen(),
        '/camera': (context) => const HandDetectionScreen(),
      },
    );
  }
}
