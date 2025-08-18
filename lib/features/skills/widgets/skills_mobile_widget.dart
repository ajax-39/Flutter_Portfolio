import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/skill.dart';
import 'package:marqueer/marqueer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SkillsMobileWidget extends StatelessWidget {
  // Android-related skills
  static final List<Skill> firstRowSkills = [
    Skill(iconPath: 'assets/icons/android.svg', label: 'Android'),
    Skill(iconPath: 'assets/icons/java.svg', label: 'Java'),
    Skill(iconPath: 'assets/icons/kotlin.svg', label: 'Kotlin'),
    Skill(iconPath: 'assets/icons/android-studio.svg', label: 'Android Studio'),
    Skill(iconPath: 'assets/icons/intellij.svg', label: 'IntelliJ'),
    Skill(iconPath: 'assets/icons/gradle.svg', label: 'Gradle'),
    Skill(iconPath: 'assets/icons/python.svg', label: 'Python'),
    Skill(iconPath: 'assets/icons/cpp.svg', label: 'C++'),
    Skill(iconPath: 'assets/icons/docker.svg', label: 'Docker'),
  ];

  // Flutter-related skills
  static final List<Skill> secondRowSkills = [
    Skill(iconPath: 'assets/icons/flutter.svg', label: 'Flutter'),
    Skill(iconPath: 'assets/icons/dart.svg', label: 'Dart'),
    Skill(iconPath: 'assets/icons/firebase.svg', label: 'Firebase'),
    Skill(iconPath: 'assets/icons/git.svg', label: 'Git'),
    Skill(iconPath: 'assets/icons/github.svg', label: 'GitHub'),
    Skill(iconPath: 'assets/icons/javascript.svg', label: 'JavaScript'),
    Skill(iconPath: 'assets/icons/ts.svg', label: 'TypeScript'),
    Skill(iconPath: 'assets/icons/nodejs.svg', label: 'Node.js'),
    Skill(iconPath: 'assets/icons/aws.svg', label: 'AWS'),
  ];

  // Spring Boot and backend-related skills
  static final List<Skill> thirdRowSkills = [
    Skill(iconPath: 'assets/icons/spring-boot.svg', label: 'Spring Boot'),
    Skill(iconPath: 'assets/icons/mysql.svg', label: 'MySQL'),
    Skill(iconPath: 'assets/icons/mongodb.svg', label: 'MongoDB'),
    Skill(iconPath: 'assets/icons/jwt.svg', label: 'JWT'),
    Skill(iconPath: 'assets/icons/postman.svg', label: 'Postman'),
    Skill(iconPath: 'assets/icons/express.svg', label: 'Express'),
    Skill(iconPath: 'assets/icons/websocket.svg', label: 'WebSocket'),
    Skill(iconPath: 'assets/icons/k8.svg', label: 'Kubernetes'),
    Skill(iconPath: 'assets/icons/cloudinary.svg', label: 'Cloudinary'),
  ];

  const SkillsMobileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height -
          160, // Account for padding and margins
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Skills',
              style: GoogleFonts.baloo2(
                fontSize: 31,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // First Row Marquee
          SizedBox(
            height: 80,
            child: Marqueer(
              pps: 40, // Pixels per second - speed
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

          const SizedBox(height: 20),

          // Second Row Marquee
          SizedBox(
            height: 80,
            child: Marqueer(
              pps: 30, // Different speed for visual interest
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

          const SizedBox(height: 20),

          // Third Row Marquee
          SizedBox(
            height: 80,
            child: Marqueer(
              pps: 35, // Different speed for visual interest
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
              width: 60,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(
                  skill.iconPath,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 8, 12, 8),
              child: Text(
                skill.label,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
