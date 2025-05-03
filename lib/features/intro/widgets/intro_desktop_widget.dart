import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'typing_animation_widget.dart';

class IntroDesktopWidget extends StatelessWidget {
  const IntroDesktopWidget({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'About Me',
              style: GoogleFonts.tourney(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 50),

            Container(
              width: screenSize.width * 0.8,
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                border: Border.all(
                  color: const Color(0xFF13BBFF).withOpacity(0.5),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF13BBFF).withOpacity(0.15),
                    blurRadius: 25,
                    spreadRadius: 3,
                    offset: const Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.05),
                    blurRadius: 40,
                    spreadRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Text(
                "I'm a B.Tech Computer Science student at ABV IIITM Gwalior with a strong passion for software development. I specialize in Flutter for mobile app development and have experience in backend technologies like Node.js, Express, and MongoDB. My expertise extends to real-time systems, algorithmic problem-solving, and database management. I enjoy building efficient, scalable solutions and continuously exploring new technologies to enhance my skills.",
                style: GoogleFonts.poppins(
                  color: Colors.white.withOpacity(0.95),
                  fontSize: 20,
                  height: 1.7,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _launchURL('https://github.com/Amogh050'),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/github.svg',
                        width: 30,
                        height: 30,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap:
                        () => _launchURL(
                          'https://www.linkedin.com/in/amogh-deshpande-56a764289/',
                        ),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/linkedin.svg',
                        width: 30,
                        height: 30,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            Center(child: ResumeDownloadButton()),
          ],
        ),
      ),
    );
  }
}

class ResumeDownloadButton extends StatefulWidget {
  const ResumeDownloadButton({super.key});

  @override
  State<ResumeDownloadButton> createState() => _ResumeDownloadButtonState();
}

class _ResumeDownloadButtonState extends State<ResumeDownloadButton> {
  bool _isHovered = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: const Color(0xFF00FFFF).withOpacity(0.6),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                  : [],
        ),
        child: ElevatedButton(
          onPressed:
              () => _launchURL(
                'https://drive.google.com/file/d/1RQ1vE8m-dnODS2smp0tjFfwkQrYqe7X8/view?usp=sharing',
              ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _isHovered ? const Color(0xFF00FFFF) : const Color(0xFF00BFFF),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: _isHovered ? 8 : 4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Download Resume',
                style: TextStyle(
                  color: _isHovered ? Colors.black : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
