import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // Timeout timer for network issues
    _timer = Timer(const Duration(seconds: 15), () {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please check your internet connection'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background transparent
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent, // Transparent background
            ),
          ),

          // Content without fade-in animation
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Portfolio logo with slight bounce effect
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.9, end: 1.0),
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF13BBFF).withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Loading animation with decreased speed
                LoadingAnimationWidget.fourRotatingDots(
                  color: const Color(0xFF13BBFF),
                  size: 100,
                ),

                const SizedBox(height: 50),

                // Loading text
                Text(
                  "Loading...",
                  style: GoogleFonts.baloo2(
                    textStyle: const TextStyle(
                      color: Color(0xFF13BBFF),
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
