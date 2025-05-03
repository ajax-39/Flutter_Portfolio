import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/responsive_utils.dart';

class ProjectCard extends StatefulWidget {
  final List<String> imagePaths;
  final String title;
  final String description;
  final String githubUrl;
  final List<String> technologies;

  const ProjectCard({
    super.key,
    required this.imagePaths,
    required this.title,
    required this.description,
    required this.githubUrl,
    this.technologies = const [],
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Future<void> _launchGithubUrl() async {
    final Uri url = Uri.parse(widget.githubUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFF1E293B),
          border: Border.all(
            color:
                _isHovered ? Colors.blue.withOpacity(0.5) : Colors.transparent,
            width: 2,
          ),
          boxShadow:
              _isHovered
                  ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ]
                  : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Collage
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                child: _buildCollage(),
              ),
            ),
            // Content
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(isMobile ? 16.0 : 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 19 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // GitHub Link
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _launchGithubUrl,
                            child: Container(
                              height: isMobile ? 38 : 32,
                              width: isMobile ? 38 : 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              padding: EdgeInsets.all(isMobile ? 8 : 6),
                              child: SvgPicture.asset(
                                'assets/icons/github.svg',
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
                    SizedBox(height: isMobile ? 10 : 8),
                    // Description
                    Expanded(
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: isMobile ? 13 : 12,
                          height: 1.4,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: widget.technologies.isEmpty ? 4 : 3,
                      ),
                    ),
                    // Technology tags
                    if (widget.technologies.isNotEmpty) ...[
                      SizedBox(height: isMobile ? 10 : 8),
                      SizedBox(
                        height: isMobile ? 28 : 24,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.technologies.length,
                          separatorBuilder:
                              (context, index) =>
                                  SizedBox(width: isMobile ? 8 : 6),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 10 : 8,
                                vertical: isMobile ? 5 : 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF13BBFF,
                                ).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: const Color(
                                    0xFF13BBFF,
                                  ).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                widget.technologies[index],
                                style: TextStyle(
                                  color: const Color(0xFF13BBFF),
                                  fontSize: isMobile ? 11 : 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollage() {
    if (widget.imagePaths.isEmpty) {
      return Container(color: const Color(0xFF0F172A));
    }

    if (widget.imagePaths.length == 1) {
      return Container(
        padding: const EdgeInsets.all(15),
        child: Image.asset(widget.imagePaths[0], fit: BoxFit.contain),
      );
    }

    if (widget.imagePaths.length == 2) {
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(9),
              child: Image.asset(widget.imagePaths[0], fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 1),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(9),
              child: Image.asset(widget.imagePaths[1], fit: BoxFit.contain),
            ),
          ),
        ],
      );
    }

    // For 3 or 4 images
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 9,
                    right: 4.5,
                    top: 9,
                    bottom: 4.5,
                  ),
                  child: Image.asset(widget.imagePaths[0], fit: BoxFit.contain),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 4.5,
                    right: 9,
                    top: 9,
                    bottom: 4.5,
                  ),
                  child: Image.asset(widget.imagePaths[1], fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 9,
                    right: 4.5,
                    top: 4.5,
                    bottom: 9,
                  ),
                  child: Image.asset(
                    widget.imagePaths.length > 2
                        ? widget.imagePaths[2]
                        : widget.imagePaths[0],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 4.5,
                    right: 9,
                    top: 4.5,
                    bottom: 9,
                  ),
                  child: Image.asset(
                    widget.imagePaths.length > 3
                        ? widget.imagePaths[3]
                        : widget.imagePaths[1],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
