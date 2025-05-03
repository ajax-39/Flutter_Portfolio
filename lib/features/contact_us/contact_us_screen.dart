import 'package:flutter/material.dart';
import '../common/responsive_utils.dart';
import 'widgets/contact_us_desktop_widget.dart';
import 'widgets/contact_us_mobile_widget.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (ResponsiveUtils.isDesktopFromConstraints(constraints)) {
          return const ContactUsDesktopWidget();
        } else {
          return const ContactUsMobileWidget();
        }
      },
    );
  }
} 