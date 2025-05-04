import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../intro/widgets/typing_animation_widget.dart';
import '../../../design/circuit_background.dart';

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
                  top: size.height * 0.15, // Fixed top padding for desktop
                  left: size.width * 0.1, // 10% horizontal padding
                  right: size.width * 0.1, // 10% horizontal padding
                  bottom: 40.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // "Hey there!" text
                    Text(
                      'Hey there! 👋',
                      style: GoogleFonts.poppins(
                        fontSize: 32.0, // Fixed desktop size
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10.0), // Fixed desktop spacing
                    // Name with left alignment
                    Text(
                      "I'm Atharv Jagzap",
                      style: GoogleFonts.baloo2(
                        fontSize: 90.0, // Fixed desktop size
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),

                    // Typewriter animation with left alignment
                    const TypingAnimationWidget(
                      fontSize: 50.0, // Fixed desktop size
                      textColor: Color(0xFF13BBFF),
                      isMobile: false,
                    ),

                    const SizedBox(height: 30.0), // Fixed desktop spacing
                    // About info text - width constraint for better readability
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: size.width * 0.5, // Fixed desktop width
                      ),
                      child: Text(
                        "I'm Atharv, an Android developer skilled in Flutter. I also have backend experience using Spring Boot. I love building real-world apps. I enjoy turning ideas into smooth, working mobile apps. From designing UI to writing backend code — I do it all.",
                        style: GoogleFonts.poppins(
                          fontSize: 18.0, // Fixed desktop size
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40.0), // Fixed desktop spacing
                    // Social media icons
                    const Wrap(
                      spacing: 20.0, // Fixed desktop spacing
                      runSpacing: 20.0, // Fixed desktop spacing
                      children: [
                        // GitHub
                        _SocialButton(
                          icon: FontAwesomeIcons.github,
                          url: 'https://github.com/ajax-39',
                          size: 52.0, // Fixed desktop size
                          iconSize: 30.0, // Fixed desktop size
                        ),
                        // LinkedIn
                        _SocialButton(
                          icon: FontAwesomeIcons.linkedin,
                          url: 'https://www.linkedin.com/in/atharv-jagzap/',
                          size: 52.0, // Fixed desktop size
                          iconSize: 30.0, // Fixed desktop size
                        ),
                        // WhatsApp
                        _SocialButton(
                          icon: FontAwesomeIcons.whatsapp,
                          url: 'https://wa.me/919975202001',
                          size: 52.0, // Fixed desktop size
                          iconSize: 30.0, // Fixed desktop size
                        ),
                      ],
                    ),

                    const SizedBox(height: 40.0), // Fixed desktop spacing
                    // Action buttons
                    Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: [
                        _buildActionButton(
                          text: 'Message Me',
                          color: const Color(0xFF13BBFF),
                          onPressed:
                              () => _launchURL('https://wa.me/919975202001'),
                        ),
                        _buildActionButton(
                          text: 'Download Resume',
                          color: const Color(0xFF13BBFF),
                          onPressed:
                              () => _launchURL(
                                'https://drive.google.com/file/d/1I45qZBRz9n862Ovx9-rhauMeJemrnwS1/view?usp=drive_link',
                              ),
                        ),
                      ],
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
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
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0, // Fixed desktop value
                vertical: 12.0, // Fixed desktop value
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.0, // Fixed desktop value
                  fontFamily: 'Preah',
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
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
  final Color color;

  const _SocialButton({
    required this.icon,
    required this.url,
    required this.size,
    required this.iconSize,
    this.color = const Color(0xFF13BBFF),
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.5),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _launchURL(url),
            borderRadius: BorderRadius.circular(size / 2),
            child: Center(child: FaIcon(icon, color: color, size: iconSize)),
          ),
        ),
      ),
    );
  }
}
