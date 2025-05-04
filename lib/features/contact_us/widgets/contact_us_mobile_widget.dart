import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsMobileWidget extends StatelessWidget {
  const ContactUsMobileWidget({super.key});

  final String recipientEmail = 'atharvjagzap@gmail.com';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _launchGmailWithContent(
    String name,
    String email,
    String message,
  ) async {
    // Construct the Gmail compose URL with exact same format as React component
    final gmailLink =
        'https://mail.google.com/mail/?view=cm&fs=1&to=atharvjagzap@gmail.com&su=Contact%20Form%20Submission&body=Name:%20${Uri.encodeComponent(name)}%0AEmail:%20${Uri.encodeComponent(email)}%0AMessage:%20${Uri.encodeComponent(message)}';

    try {
      final Uri uri = Uri.parse(gmailLink);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $gmailLink');
      }
    } catch (e) {
      print('Error launching Gmail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate width based on screen size for responsive layout, but cap at 450px
    final contentWidth =
        screenWidth <= 600
            ? screenWidth * 0.9
            : screenWidth <= 800
            ? screenWidth * 0.7
            : 450.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Contact Me',
              style: GoogleFonts.baloo2(
                fontSize: 31,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Contact Information
          Center(
            child: SizedBox(
              width: contentWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactInfo(
                      'Email',
                      'atharvjagzap@gmail.com',
                      Icons.email,
                    ),
                    const SizedBox(height: 20),
                    _buildContactInfo('Phone', '+91 9975202001', Icons.phone),
                    const SizedBox(height: 20),
                    _buildContactInfo(
                      'Location',
                      'Nashik, India',
                      Icons.location_on,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Contact Form
          Center(
            child: SizedBox(
              width: contentWidth,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Send a Message',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Preah',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Your Name',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF13BBFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Your Email',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF13BBFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: messageController,
                        maxLines: 5,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Your Message',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF13BBFF),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: _buildActionButton(
                          text: 'Send Message',
                          color: const Color(0xFF13BBFF),
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                emailController.text.isNotEmpty &&
                                messageController.text.isNotEmpty) {
                              _launchGmailWithContent(
                                nameController.text.trim(),
                                emailController.text.trim(),
                                messageController.text.trim(),
                              );

                              // Reset form after submission
                              nameController.clear();
                              emailController.clear();
                              messageController.clear();
                            }
                          },
                          isMobile: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String title, String value, IconData icon) {
    Widget valueWidget;

    if (title == 'Email') {
      valueWidget = GestureDetector(
        onTap: () => _launchEmail(value),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Preah',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white70,
              decorationThickness: 1,
            ),
          ),
        ),
      );
    } else if (title == 'Phone') {
      valueWidget = GestureDetector(
        onTap: () => _launchPhone(value),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Preah',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white70,
              decorationThickness: 1,
            ),
          ),
        ),
      );
    } else {
      valueWidget = Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Preah',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontFamily: 'Preah',
                fontSize: 14,
              ),
            ),
            valueWidget,
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
    required bool isMobile,
  }) {
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
