import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsDesktopWidget extends StatelessWidget {
  const ContactUsDesktopWidget({super.key});

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
        'https://mail.google.com/mail/?view=cm&fs=1&to=atharvjagzap@gmail.com&su=Message%20from%20${Uri.encodeComponent(name)}%20via%20portfolio&body=Name:%20${Uri.encodeComponent(name)}%0AEmail:%20${Uri.encodeComponent(email)}%0AMessage:%20${Uri.encodeComponent(message)}';

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

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Contact Me',
                style: GoogleFonts.baloo2(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact Information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildContactInfo(
                          'Email',
                          'atharvjagzap@gmail.com',
                          Icons.email,
                        ),
                        const SizedBox(height: 20),
                        _buildContactInfo(
                          'Phone',
                          '+91 9975202001',
                          Icons.phone,
                        ),
                        const SizedBox(height: 20),
                        _buildContactInfo(
                          'Location',
                          'Nashik, India',
                          Icons.location_on,
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  const SizedBox(width: 60),
                  // Contact Form
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(30),
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
                          const SizedBox(height: 30),
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
                                  color: Color(0xff13bbff),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
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
                                  color: Color(0xff13bbff),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
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
                                  color: Color(0xff13bbff),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff13bbff).withOpacity(0.2),
                                border: Border.all(
                                  color: const Color(0xff13bbff),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
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
                                  borderRadius: BorderRadius.circular(8),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 12.0,
                                    ),
                                    child: Text(
                                      'Send Message',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Preah',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff13bbff),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(String title, String value, IconData icon) {
    Widget valueWidget;

    if (title == 'Email') {
      valueWidget = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _launchEmail(value),
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
      valueWidget = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _launchPhone(value),
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
