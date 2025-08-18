import 'package:flutter/material.dart';
import 'widgets/projects_desktop_widget.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using only the ProjectsDesktopWidget which now handles all screen sizes
    return const ProjectsDesktopWidget();
  }
} 
