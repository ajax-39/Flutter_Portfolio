import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../common/responsive_utils.dart';

class ProjectCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final String githubUrl;
  final List<String> technologies;

  const ProjectCard({
    super.key,
    required this.imagePath,
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
    final width = MediaQuery.of(context).size.width;

    // Adjust sizes based on screen width for more fine-grained responsiveness
    final double fontSize =
        isMobile ? (width < 400 ? 14.0 : 16.0) : (width < 1200 ? 18.0 : 20.0);

    final double descriptionFontSize =
        isMobile ? (width < 400 ? 14.0 : 16.0) : (width < 1200 ? 14.0 : 15.0);

    final double tagFontSize =
        isMobile ? (width < 400 ? 12.0 : 14.0) : (width < 1200 ? 12.0 : 13.0);

    final double iconSize =
        isMobile ? (width < 400 ? 24.0 : 26.0) : (width < 1200 ? 32.0 : 36.0);

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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF0F172A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                padding: EdgeInsets.all(width < 400 ? 8.0 : 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(widget.imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(height: isMobile ? 8 : 12),

            // Content Section
            Padding(
              padding: EdgeInsets.all(
                isMobile ? (width < 400 ? 12.0 : 16.0) : 14.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title and GitHub icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // GitHub Link
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _launchGithubUrl,
                          child: Container(
                            height: iconSize,
                            width: iconSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                            padding: EdgeInsets.all(isMobile ? 6 : 8),
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
                  SizedBox(height: isMobile ? (width < 400 ? 6 : 8) : 12),

                  // Description with fixed height to avoid variable spacing
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: descriptionFontSize,
                      height: 1.4,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Technology tags with optimized layout
                  if (widget.technologies.isNotEmpty) ...[
                    SizedBox(height: isMobile ? 12 : 10),
                    SizedBox(
                      height: isMobile ? (width < 400 ? 26 : 30) : 28,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.technologies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: isMobile ? 6 : 4),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    isMobile ? (width < 400 ? 6 : 8) : 6,
                                vertical: isMobile ? (width < 400 ? 3 : 4) : 3,
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
                                  fontSize: tagFontSize,
                                  fontWeight: FontWeight.w500,
                                ),
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
          ],
        ),
      ),
    );
  }
}
