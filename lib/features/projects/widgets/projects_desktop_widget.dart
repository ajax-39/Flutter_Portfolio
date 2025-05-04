import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_card.dart';

class ProjectsDesktopWidget extends StatelessWidget {
  const ProjectsDesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive adjustments based on screen width
    int crossAxisCount = 3; // Default for large screens
    double childAspectRatio = 0.85; // Default aspect ratio

    // Adjust grid layout based on screen width breakpoints
    if (screenWidth < 1400) {
      crossAxisCount = 2;
      childAspectRatio = 0.78;
    }
    if (screenWidth < 1100) {
      childAspectRatio = 0.82;
    }

    final titleFontSize = screenWidth < 1200 ? 40.0 : 45.0;
    final contentWidth = screenWidth * (screenWidth < 1200 ? 0.9 : 0.85);
    final gridSpacing = screenWidth < 1200 ? 20.0 : 30.0;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.03),
          child: Center(
            child: Text(
              'Projects',
              style: GoogleFonts.baloo2(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        SizedBox(
          width: contentWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth < 1200 ? 15.0 : 20.0,
              vertical: screenWidth < 1200 ? 10.0 : 20.0,
            ),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: gridSpacing,
              mainAxisSpacing: gridSpacing,
              children: [
                // First Row
                ProjectCard(
                  imagePath: 'assets/projects/scribble.png',
                  title: 'Scribble : Drawing & Guessing Game',
                  description:
                      'Built with Socket.IO, Flutter, Node.js, and MongoDB. Implements real-time multiplayer functionality with custom drawing canvas and gesture detection.',
                  githubUrl: 'https://github.com/ajax-39/Scribble',
                  technologies: ['Socket.IO', 'Flutter', 'Node.js', 'MongoDB'],
                ),
                ProjectCard(
                  imagePath: 'assets/projects/bSafe.png',
                  title: 'bSafe : Women\'s Safety App',
                  description:
                      'Built with Flutter, Firebase, and Google Maps API. Implements real-time location tracking with Geolocator and Flutter_SMS for Alert Message sending.',
                  githubUrl: 'https://github.com/ajax-39/Flutter_bSafe',
                  technologies: [
                    'Flutter',
                    'Firebase',
                    'Google Maps API',
                    'Geolocator',
                    'Flutter_SMS',
                  ],
                ),
                ProjectCard(
                  imagePath: 'assets/projects/pokedex.png',
                  title: 'Pokedex : Pokemon App',
                  description:
                      'Developed with Flutter and PokeAPI integration. Uses Riverpod for state management, Dio for API Calls and SharedPreferences for local storage.',
                  githubUrl: 'https://github.com/ajax-39/Flutter_Pokedex',
                  technologies: [
                    'Flutter',
                    'PokeAPI',
                    'Riverpod',
                    'Dio',
                    'SharedPreferences',
                  ],
                ),

                // Second Row
                ProjectCard(
                  imagePath: 'assets/projects/mychat.png',
                  title: 'QuickChat: WhatsApp Clone',
                  description:
                      'Developed with Flutter, Firebase (Firestore/Auth/Storage), and Riverpod 2.0 for state management. Features real-time messaging with push notifications.',
                  githubUrl:
                      'https://github.com/ajax-39/Flutter_WhatsApp_Clone',
                  technologies: [
                    'Flutter',
                    'Firebase',
                    'Firestore',
                    'Riverpod 2.0',
                  ],
                ),
                ProjectCard(
                  imagePath: 'assets/projects/infomeal.png',
                  title: 'InfoMeal: Recipe App',
                  description:
                      'Created using Flutter, Dio for REST API integration, and Provider for state management. Implements custom UI components and animations.',
                  githubUrl: 'https://github.com/ajax-39/Flutter_InfoMeal',
                  technologies: ['Flutter', 'Dio', 'Provider', 'REST API'],
                ),
                ProjectCard(
                  imagePath: 'assets/projects/foodo.png',
                  title: 'Foodo : Food Delivery App',
                  description:
                      'Built with Flutter, Firebase backend. Integrates Google Maps for location-based services and custom animations.',
                  githubUrl: 'https://github.com/ajax-39/Flutter_Foodo',
                  technologies: ['Flutter', 'Firebase', 'Google Maps'],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
      ],
    );
  }
}
