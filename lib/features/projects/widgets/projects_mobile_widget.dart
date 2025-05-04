import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_card.dart';

class ProjectsMobileWidget extends StatelessWidget {
  const ProjectsMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.85;

    return Column(
      children: [
        Center(
          child: Text(
            'Projects',
            style: GoogleFonts.baloo2(
              fontSize: 31,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 25),

        // Project 1: Scribble
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: cardWidth,
            child: ProjectCard(
              imagePath: 'assets/projects/scribble.png',
              title: 'Scribble : Drawing & Guessing Game',
              description:
                  'Built with Socket.IO, Flutter, Node.js, and MongoDB. Implements real-time multiplayer functionality with custom drawing canvas and gesture detection.',
              githubUrl: 'https://github.com/ajax-39/Scribble',
              technologies: ['Socket.IO', 'Flutter', 'Node.js', 'MongoDB'],
            ),
          ),
        ),

        // Project 2: bSafe
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: cardWidth,
            child: ProjectCard(
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
          ),
        ),

        // Project 3: Pokedex
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: cardWidth,
            child: ProjectCard(
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
          ),
        ),

        // Project 4: QuickChat
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: cardWidth,
            child: ProjectCard(
              imagePath: 'assets/projects/mychat.png',
              title: 'QuickChat: WhatsApp Clone',
              description:
                  'Developed with Flutter, Firebase (Firestore/Auth/Storage), and Riverpod 2.0 for state management. Features real-time messaging with push notifications.',
              githubUrl: 'https://github.com/ajax-39/Flutter_WhatsApp_Clone',
              technologies: [
                'Flutter',
                'Firebase',
                'Firestore',
                'Riverpod 2.0',
              ],
            ),
          ),
        ),

        // Project 5: InfoMeal
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: cardWidth,
            child: ProjectCard(
              imagePath: 'assets/projects/infomeal.png',
              title: 'InfoMeal: Recipe App',
              description:
                  'Created using Flutter, Dio for REST API integration, and Provider for state management. Implements custom UI components and animations.',
              githubUrl: 'https://github.com/ajax-39/Flutter_InfoMeal',
              technologies: ['Flutter', 'Dio', 'Provider', 'REST API'],
            ),
          ),
        ),

        // Project 6: Foodo
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: cardWidth,
            child: ProjectCard(
              imagePath: 'assets/projects/foodo.png',
              title: 'Foodo : Food Delivery App',
              description:
                  'Built with Flutter, Firebase backend. Integrates Google Maps for location-based services and custom animations.',
              githubUrl: 'https://github.com/ajax-39/Flutter_Foodo',
              technologies: ['Flutter', 'Firebase', 'Google Maps'],
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
