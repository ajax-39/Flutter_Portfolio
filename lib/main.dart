import 'package:flutter/material.dart';
import 'features/home/home_screen.dart';
import 'features/loader/loader.dart';
import 'design/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Atharv's Portfolio",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LoaderWrapper(),
    );
  }
}

class LoaderWrapper extends StatefulWidget {
  const LoaderWrapper({super.key});

  @override
  State<LoaderWrapper> createState() => _LoaderWrapperState();
}

class _LoaderWrapperState extends State<LoaderWrapper> {
  @override
  void initState() {
    super.initState();
    // Navigate to home screen after a delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Loader();
  }
}
