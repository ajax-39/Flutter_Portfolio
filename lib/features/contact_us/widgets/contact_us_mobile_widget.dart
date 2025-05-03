import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsMobileWidget extends StatelessWidget {
  const ContactUsMobileWidget({super.key});

  final String recipientEmail = 'deshpandeamogh25@gmail.com';

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

  Future<void> _sendEmailWithContent(String name, String message) async {
    final subject = 'Message from $name via Portfolio';
    final body = 'Name: $name\n\nMessage:\n$message';

    // Use Gmail specific URL scheme for mobile
    final gmailUrl =
        'https://mail.google.com/mail/?view=cm&fs=1'
        '&to=$recipientEmail'
        '&su=${Uri.encodeComponent(subject)}'
        '&body=${Uri.encodeComponent(body)}';

    try {
      // Try Gmail first
      if (await canLaunchUrl(Uri.parse(gmailUrl))) {
        await launchUrl(
          Uri.parse(gmailUrl),
          mode: LaunchMode.externalApplication,
        );
      } else {
        // Fallback to regular mailto
        final Uri emailUri = Uri.parse(
          'mailto:$recipientEmail?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
        );

        if (await canLaunchUrl(emailUri)) {
          await launchUrl(emailUri);
        } else {
          print('Could not launch email');
        }
      }
    } catch (e) {
      print('Error launching email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
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
              style: GoogleFonts.tourney(
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
                      'deshpandeamogh25@gmail.com',
                      Icons.email,
                    ),
                    const SizedBox(height: 20),
                    _buildContactInfo('Phone', '+91 7448205228', Icons.phone),
                    const SizedBox(height: 20),
                    _buildContactInfo(
                      'Location',
                      'Pune, India',
                      Icons.location_on,
                    ),
                    const SizedBox(height: 30),
                    // GitHub Link
                    Row(
                      children: [
                        Text(
                          'GitHub',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Preah',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap:
                                () => _launchURL('https://github.com/Amogh050'),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/github.svg',
                                width: 24,
                                height: 24,
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
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                messageController.text.isNotEmpty) {
                              _sendEmailWithContent(
                                nameController.text.trim(),
                                messageController.text.trim(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF13BBFF),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Send Message',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Preah',
                              fontSize: 16,
                            ),
                          ),
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
}
