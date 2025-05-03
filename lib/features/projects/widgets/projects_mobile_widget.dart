import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'project_card.dart';

class ProjectsMobileWidget extends StatelessWidget {
  const ProjectsMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.7;
    final cardHeight = 400.0; // Increased height to avoid overflow
    
    return Column(
      children: [
        Center(
          child: Text(
            'Featured Projects',
            style: GoogleFonts.tourney(
              fontSize: 31,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 25), // Reduced from 30
        
        // First row of projects (FlutterAmazon and Scribble)
        SizedBox(
          height: cardHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 12), // Reduced from 16
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: ProjectCard(
                    imagePaths: [
                      'assets/projects/user1.png',
                      'assets/projects/user2.png',
                    ],
                    title: 'FlutterAmazon',
                    description: 'FlutterAmazon is a full-featured Amazon clone built with Flutter for the frontend and Node.js/Express with MongoDB for the backend. Deployed using Render, this project offers a robust e-commerce experience with role-based functionalities for both users and administrators.',
                    githubUrl: 'https://github.com/Amogh050/FlutterAmazon',
                    technologies: ['Flutter', 'NodeJS', 'MongoDB', 'JWT', 'Render'],
                  ),
                ),
                const SizedBox(width: 20), // Reduced from 24
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: ProjectCard(
                    imagePaths: [
                      'assets/projects/scribble1.png',
                      'assets/projects/scribble3.png',
                    ],
                    title: 'Scribble',
                    description: 'Scribble is a fun and interactive multiplayer drawing and guessing game where players take turns drawing an assigned word while others try to guess it. Compete with friends in a fast-paced game that challenges your creativity and word-guessing skills!',
                    githubUrl: 'https://github.com/Amogh050/Scribble',
                    technologies: ['Flutter', 'NodeJS', 'MongoDB', 'WebSockets'],
                  ),
                ),
                const SizedBox(width: 12), // Reduced from 16
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 20), // Reduced from 24
        
        // Second row of projects (FlutterNews and Echo AI)
        SizedBox(
          height: cardHeight,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 12), // Reduced from 16
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: ProjectCard(
                    imagePaths: [
                      'assets/projects/news1.png',
                      'assets/projects/news2.png',
                    ],
                    title: 'FlutterNews',
                    description: 'FlutterNews is a Flutter application that fetches and displays news articles dynamically using an API. It features category-based filtering, location-based news, and a user-friendly UI. Additionally, it integrates Gemini AI to summarize news articles efficiently.',
                    githubUrl: 'https://github.com/Amogh050/FlutterNews',
                    technologies: ['Flutter', 'Riverpod', 'API'],
                  ),
                ),
                const SizedBox(width: 20), // Reduced from 24
                SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: ProjectCard(
                    imagePaths: [
                      'assets/projects/echo1.png',
                      'assets/projects/echo2.png',
                    ],
                    title: 'Echo AI',
                    description: 'Echo-AI is a simple Flutter project where you can interact with the app using your voice. The app listens to your commands and reads its responses aloud. It also supports generating images based on your input.',
                    githubUrl: 'https://github.com/Amogh050/Echo-AI',
                    technologies: ['Flutter', 'API', 'Text-to-Speech'],
                  ),
                ),
                const SizedBox(width: 12), // Reduced from 16
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 20), // Reduced from 24
      ],
    );
  }
} 