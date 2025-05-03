import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/skill.dart';
import 'package:marqueer/marqueer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillsDesktopWidget extends StatelessWidget {
  static final List<Skill> firstRowSkills = [
    Skill(iconPath: 'assets/icons/flutter.svg', label: 'Flutter'),
    Skill(iconPath: 'assets/icons/dart.svg', label: 'Dart'),
    Skill(iconPath: 'assets/icons/firebase.svg', label: 'Firebase'),
    Skill(iconPath: 'assets/icons/github.svg', label: 'GitHub'),
    Skill(iconPath: 'assets/icons/git.svg', label: 'Git'),
    Skill(iconPath: 'assets/icons/javascript.svg', label: 'JavaScript'),
  ];
  
  static final List<Skill> secondRowSkills = [
    Skill(iconPath: 'assets/icons/nodejs.svg', label: 'Node.js'),
    Skill(iconPath: 'assets/icons/mongodb.svg', label: 'MongoDB'),
    Skill(iconPath: 'assets/icons/express.svg', label: 'Express'),
    Skill(iconPath: 'assets/icons/python.svg', label: 'Python'),
    Skill(iconPath: 'assets/icons/cpp.svg', label: 'C++'),
    Skill(iconPath: 'assets/icons/mysql.svg', label: 'MySQL'),
  ];
  
  static final List<Skill> thirdRowSkills = [
    Skill(iconPath: 'assets/icons/websocket.svg', label: 'WebSocket'),
    Skill(iconPath: 'assets/icons/jwt.svg', label: 'JWT'),
    Skill(iconPath: 'assets/icons/cloudinary.svg', label: 'Cloudinary'),
    Skill(iconPath: 'assets/icons/postman.svg', label: 'Postman'),
    Skill(iconPath: 'assets/icons/ocaml.svg', label: 'OCaml'),
    Skill(iconPath: 'assets/icons/netlify.svg', label: 'Netlify'),
    Skill(iconPath: 'assets/icons/figma.svg', label: 'Figma'),
  ];

  const SkillsDesktopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 160, // Account for padding and margins
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Skills',
              style: GoogleFonts.tourney(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 60),
          
          // First Row Marquee
          SizedBox(
            height: 100,
            child: Marqueer(
              pps: 60, // Pixels per second - speed
              direction: MarqueerDirection.rtl,
              restartAfterInteractionDuration: const Duration(seconds: 3),
              child: Row(
                children: [
                  ...firstRowSkills.map((skill) => _buildSkillCard(skill)),
                  // Add duplicates to ensure continuous flow
                  ...firstRowSkills.map((skill) => _buildSkillCard(skill)),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Second Row Marquee
          SizedBox(
            height: 100,
            child: Marqueer(
              pps: 40, // Different speed for visual interest
              direction: MarqueerDirection.ltr,
              restartAfterInteractionDuration: const Duration(seconds: 3),
              child: Row(
                children: [
                  ...secondRowSkills.map((skill) => _buildSkillCard(skill)),
                  // Add duplicates to ensure continuous flow
                  ...secondRowSkills.map((skill) => _buildSkillCard(skill)),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Third Row Marquee
          SizedBox(
            height: 100,
            child: Marqueer(
              pps: 50, // Different speed for visual interest
              direction: MarqueerDirection.rtl,
              restartAfterInteractionDuration: const Duration(seconds: 3),
              child: Row(
                children: [
                  ...thirdRowSkills.map((skill) => _buildSkillCard(skill)),
                  // Add duplicates to ensure continuous flow
                  ...thirdRowSkills.map((skill) => _buildSkillCard(skill)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSkillCard(Skill skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Card(
        elevation: 3,
        shadowColor: Colors.grey.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color(0xFF1A1A1A), // Dark gray instead of black
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 75,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  skill.iconPath,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 16, 8),
              child: Text(
                skill.label,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 