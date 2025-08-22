import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_card.dart';

class ProjectsDesktopWidget extends StatelessWidget {
  const ProjectsDesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth <= 768;

    if (isMobile) {
      // Mobile layout implementation
      // Calculate responsive margins and sizing for mobile
      final horizontalPadding = screenWidth * 0.05; // 5% of screen width
      final cardWidth = screenWidth - (horizontalPadding * 2);
      final verticalSpacing = 16.0;
      final titleFontSize = screenWidth < 350 ? 24.0 : 28.0;

      return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.03),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Projects',
                style: GoogleFonts.baloo2(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 24.0),

              // Projects list for mobile layout
              _buildProjectItem(
                context: context,
                isMobile: true,
                cardWidth: cardWidth,
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalSpacing,
                imagePath: 'assets/projects/streetBuddy.png',
                title: 'StreetBuddy: Smart Travel Buddy',
                description:
                    'Welcome to "StreetBuddy" your smart travel buddy for exploring the best of every city! Designed especially for Indian travelers, StreetBuddy helps you find delicious food spots, vibrant shopping markets, famous attractions, and hidden gems that only locals know about.',
                githubUrl: 'https://github.com/ajax-39/StreetBuddy_Flutter.git',
                technologies: [
                  'Supabase',
                  'Provider',
                  'Admob',
                  'Dio',
                  'Hive',
                  'Twilio'
                ],
              ),

              _buildProjectItem(
                context: context,
                isMobile: true,
                cardWidth: cardWidth,
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalSpacing,
                imagePath: 'assets/projects/roomly.png',
                title: 'Roomly : Hotel Booking App',
                description:
                    'A complete hotel booking platform with user and hotel owner modules, real-time updates, wallet, and Razorpay integration. Built using Flutter, Firebase, and Clean Architecture.',
                githubUrl: 'https://github.com/ajax-39/Flutter_Roomly',
                technologies: [
                  'Razorpay',
                  'MVVM',
                  'GoRouter',
                  'GetIt',
                  'Riverpod',
                  'Flutter',
                  'Firebase',
                ],
              ),

              _buildProjectItem(
                context: context,
                isMobile: true,
                cardWidth: cardWidth,
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalSpacing,
                imagePath: 'assets/projects/scribble.png',
                title: 'Scribble : Drawing & Guessing Game',
                description:
                    'Built with Socket.IO, Flutter, Node.js, and MongoDB. Implements real-time multiplayer functionality with custom drawing canvas and gesture detection.',
                githubUrl: 'https://github.com/ajax-39/Scribble',
                technologies: [
                  'Socket.IO',
                  'Node.js',
                  'MongoDB',
                  'REST API',
                  'Flutter',
                ],
              ),
              _buildProjectItem(
                context: context,
                isMobile: true,
                cardWidth: cardWidth,
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalSpacing,
                imagePath: 'assets/projects/pokedex.png',
                title: 'Pokedex : Pokemon App',
                description:
                    'Developed with Flutter and PokeAPI integration. Uses Riverpod for state management, Dio for API Calls and SharedPreferences for local storage.',
                githubUrl: 'https://github.com/ajax-39/Flutter_Pokedex',
                technologies: [
                  'PokeAPI',
                  'Riverpod',
                  'Shared Preferences',
                  'Flutter',
                  'Dio',
                ],
              ),

              _buildProjectItem(
                context: context,
                isMobile: true,
                cardWidth: cardWidth,
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalSpacing,
                imagePath: 'assets/projects/bSafe.png',
                title: 'bSafe : Women\'s Safety App',
                description:
                    'Built with Flutter, Firebase, and Google Maps API. Implements real-time location tracking with Geolocator and Flutter_SMS for Alert Message sending.',
                githubUrl: 'https://github.com/ajax-39/Flutter_bSafe',
                technologies: [
                  'Google Maps API',
                  'Geolocator',
                  'Flutter',
                  'Firebase',
                ],
              ),

              _buildProjectItem(
                context: context,
                isMobile: true,
                cardWidth: cardWidth,
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalSpacing,
                imagePath: 'assets/projects/mychat.png',
                title: 'QuickChat: WhatsApp Clone',
                description:
                    'Developed with Flutter, Firebase (Firestore/Auth/Storage), and Riverpod 2.0 for state management. Features real-time messaging with push notifications.',
                githubUrl: 'https://github.com/ajax-39/Flutter_WhatsApp_Clone',
                technologies: ['Flutter', 'Firebase', 'Firestore', 'Riverpod'],
              ),
            ],
          ),
        ),
      );
    }

    // Desktop layout implementation (existing code)
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
                  imagePath: 'assets/projects/streetBuddy.png',
                  title: 'StreetBuddy: Smart Travel Buddy',
                  description:
                      'StreetBuddy – your smart travel buddy for exploring every city. Discover tasty food joints, vibrant markets, and must-see attractions. Uncover hidden gems and local favorites on every trip!',
                  githubUrl:
                      'https://github.com/ajax-39/StreetBuddy_Flutter.git',
                  technologies: [
                    'Supabase',
                    'Provider',
                    'Admob',
                    'dio',
                    'Hive',
                    'Twilio',
                  ],
                  isMobileCard: false,
                ),
                ProjectCard(
                  imagePath: 'assets/projects/roomly.png',
                  title: 'Roomly : Hotel Booking App',
                  description:
                      'A complete hotel booking platform with user and hotel owner modules, real-time updates, wallet, and Razorpay integration. Built using Flutter, Firebase, and Clean Architecture.',
                  githubUrl: 'https://github.com/ajax-39/Flutter_Roomly',
                  technologies: [
                    'Flutter',
                    'Firebase',
                    'Razorpay',
                    'Clean Architecture',
                  ],
                  isMobileCard: false,
                ),
                ProjectCard(
                  imagePath: 'assets/projects/scribble.png',
                  title: 'Scribble : Drawing & Guessing Game',
                  description:
                      'Built with Socket.IO, Flutter, Node.js, and MongoDB. Implements real-time multiplayer functionality with custom drawing canvas and gesture detection.',
                  githubUrl: 'https://github.com/ajax-39/Scribble',
                  technologies: [
                    'Socket.IO',
                    'Node.js',
                    'MongoDB',
                    'Flutter',
                  ],
                  isMobileCard: false,
                ),

                // Second Row
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
                  isMobileCard: false,
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
                  isMobileCard: false,
                ),
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
                  isMobileCard: false,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
      ],
    );
  }

  Widget _buildProjectItem({
    required BuildContext context,
    required bool isMobile,
    required double cardWidth,
    required double horizontalPadding,
    required double verticalPadding,
    required String imagePath,
    required String title,
    required String description,
    required String githubUrl,
    required List<String> technologies,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding / 2,
      ),
      child: SizedBox(
        width: cardWidth,
        child: ProjectCard(
          imagePath: imagePath,
          title: title,
          description: description,
          githubUrl: githubUrl,
          technologies: technologies,
          isMobileCard: isMobile, // Pass mobile flag to ProjectCard
        ),
      ),
    );
  }
}
