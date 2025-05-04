import 'package:flutter/material.dart';
import 'package:portfolio/features/common/responsive_utils.dart';
import 'widgets/projects_desktop_widget.dart';
import 'widgets/projects_mobile_widget.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use LayoutBuilder for even more granular control over responsiveness
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use constraints directly for more precise checks
        final isDesktop =
            constraints.maxWidth > ResponsiveUtils.mobileBreakpoint;

        // Return the appropriate widget based on screen size
        return isDesktop
            ? const ProjectsDesktopWidget()
            : const ProjectsMobileWidget();
      },
    );
  }
}
