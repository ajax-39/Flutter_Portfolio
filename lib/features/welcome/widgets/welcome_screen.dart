import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../intro/widgets/typing_animation_widget.dart';
import '../../../design/circuit_background.dart';
import '../../common/responsive_utils.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // Function to launch URLs in a new tab
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // Open in browser in a new tab
      );
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = ResponsiveUtils.isMobile(context);

    // Responsive sizing
    final nameTextSize = isMobile
        ? size.width * 0.08 // Dynamic size for mobile
        : size.width > 1400
            ? 90.0 // Large desktop
            : size.width > 800
                ? 70.0 // Medium desktop
                : 50.0; // Small desktop

    final greetingTextSize = isMobile
        ? size.width * 0.05 // Dynamic size for mobile
        : size.width > 1400
            ? 32.0 // Large desktop
            : size.width > 800
                ? 28.0 // Medium desktop
                : 24.0; // Small desktop

    final typingAnimationSize = isMobile
        ? size.width * 0.06 // Dynamic size for mobile
        : size.width > 1400
            ? 50.0 // Large desktop
            : size.width > 800
                ? 40.0 // Medium desktop
                : 30.0; // Small desktop

    final aboutTextSize = isMobile
        ? 16.0
        : size.width > 1400
            ? 18.0
            : 16.0;

    // Calculate responsive horizontal padding
    final horizontalPadding = isMobile ? size.width * 0.05 : size.width * 0.1;

    return CircuitBoardBackground(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          // Detect even the slightest scroll and navigate to next section
          if (notification.metrics.pixels > 0) {
            // Find the scrollable parent
            final scrollable = Scrollable.maybeOf(context);
            if (scrollable != null && scrollable.widget.controller != null) {
              // Scroll to the next section (height of the welcome screen)
              scrollable.widget.controller!.animateTo(
                MediaQuery.of(context).size.height,
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeInOut,
              );
            }
            return true; // Stop notification bubbling
          }
          return false; // Allow notification to continue bubbling
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.only(
                  top: isMobile ? size.height * 0.1 : size.height * 0.15,
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: isMobile ? 20.0 : 40.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "Hey there!" text
                    Text(
                      'Hey there!',
                      style: GoogleFonts.poppins(
                        fontSize: greetingTextSize,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: isMobile ? 5.0 : 10.0),
                    // Name with left alignment
                    Text(
                      "I'm Atharv Jagzap",
                      style: GoogleFonts.baloo2(
                        fontSize: nameTextSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),

                    // Typewriter animation with left alignment
                    TypingAnimationWidget(
                      fontSize: typingAnimationSize,
                      textColor: const Color(0xFF13BBFF),
                      isMobile: isMobile,
                    ),

                    SizedBox(height: isMobile ? 15.0 : 30.0),
                    // About info text - width constraint for better readability
                    Container(
                      constraints: BoxConstraints(
                        maxWidth:
                            isMobile ? size.width * 0.9 : size.width * 0.5,
                      ),
                      child: Text(
                        """Android Developer with 3 years of experience building high-performance mobile apps using Kotlin and Flutter. Skilled in Android architecture, Jetpack Compose, Coroutines, and Dagger/Hilt. Proficient in backend development with Spring Boot for scalable APIs and end-to-end system design.""",
                        style: GoogleFonts.poppins(
                          fontSize: aboutTextSize,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                      ),
                    ),

                    SizedBox(height: isMobile ? 25.0 : 40.0),

                    // Wrap social media icons and resume button in a single InteractiveElement
                    InteractiveElement(
                      child: SizedBox(
                        width: isMobile ? double.infinity : null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Social media icons
                            Wrap(
                              spacing: isMobile ? 15.0 : 20.0,
                              runSpacing: isMobile ? 15.0 : 20.0,
                              children: [
                                // GitHub
                                _SocialButton(
                                  icon: FontAwesomeIcons.github,
                                  url: 'https://github.com/ajax-39',
                                  size: isMobile ? 42.0 : 52.0,
                                  iconSize: isMobile ? 22.0 : 30.0,
                                ),
                                // LinkedIn
                                _SocialButton(
                                  icon: FontAwesomeIcons.linkedin,
                                  url:
                                      'https://www.linkedin.com/in/atharv-jagzap/',
                                  size: isMobile ? 42.0 : 52.0,
                                  iconSize: isMobile ? 22.0 : 30.0,
                                ),
                                // LeetCode
                                _SocialButton(
                                  icon: FontAwesomeIcons
                                      .code, // Use a code icon for LeetCode
                                  url: 'https://leetcode.com/u/Ajax_03/',
                                  size: isMobile ? 42.0 : 52.0,
                                  iconSize: isMobile ? 22.0 : 30.0,
                                ),
                              ],
                            ),

                            SizedBox(height: isMobile ? 25.0 : 40.0),

                            // Action buttons
                            Wrap(
                              spacing: isMobile ? 10.0 : 16.0,
                              runSpacing: isMobile ? 10.0 : 16.0,
                              children: [
                                _buildActionButton(
                                  text: 'Resume',
                                  color: const Color(0xFF13BBFF),
                                  onPressed: () => _launchURL(
                                    'https://drive.google.com/file/d/16txH814eIEjuIStbpAAo8M6MrTbUVqXQ/view?usp=sharing',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : 24.0,
              vertical: isMobile ? 8.0 : 12.0,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 14.0 : 16.0,
                fontFamily: 'Preah',
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Social button widget as a stateless widget
class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String url;
  final double size;
  final double iconSize;

  const _SocialButton({
    required this.icon,
    required this.url,
    required this.size,
    required this.iconSize,
  });

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF13BBFF), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchURL(url),
          borderRadius: BorderRadius.circular(size / 2),
          child: Center(
              child:
                  FaIcon(icon, color: const Color(0xFF13BBFF), size: iconSize)),
        ),
      ),
    );
  }
}
