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
  final bool isMobileCard;

  const ProjectCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.githubUrl,
    this.technologies = const [],
    this.isMobileCard = false,
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
    final bool isMobile =
        widget.isMobileCard || ResponsiveUtils.isMobile(context);
    final width = MediaQuery.of(context).size.width;

    // Adjust sizes based on screen width for mobile view
    final double fontSize =
        isMobile ? (width < 350 ? 13.0 : 15.0) : (width < 1200 ? 18.0 : 20.0);
    final double descriptionFontSize =
        isMobile ? (width < 350 ? 11.0 : 13.0) : (width < 1200 ? 14.0 : 15.0);
    final double tagFontSize =
        isMobile ? (width < 350 ? 9.0 : 11.0) : (width < 1200 ? 12.0 : 13.0);
    final double iconSize =
        isMobile ? (width < 350 ? 22.0 : 24.0) : (width < 1200 ? 32.0 : 36.0);
    final double contentPadding = isMobile ? (width < 350 ? 10.0 : 12.0) : 16.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isMobile ? 16 : 24),
          color: const Color(0xFF1E293B),
          border: Border.all(
            color:
                _isHovered ? Colors.blue.withOpacity(0.5) : Colors.transparent,
            width: 1.5,
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
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isMobile ? 14 : 22),
                    topRight: Radius.circular(isMobile ? 14 : 22),
                  ),
                ),
                padding: EdgeInsets.all(isMobile ? 6.0 : 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
                  child: Image.asset(widget.imagePath, fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(height: isMobile ? 6 : 12),

            // Content Section
            Padding(
              padding: EdgeInsets.all(contentPadding),
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
                      const SizedBox(width: 6),
                      // GitHub Link
                      GestureDetector(
                        onTap: _launchGithubUrl,
                        child: Container(
                          height: iconSize,
                          width: iconSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                          padding: EdgeInsets.all(isMobile ? 5 : 8),
                          child: SvgPicture.asset(
                            'assets/icons/github.svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 6 : 12),

                  // Description with fewer lines on mobile to save space
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: descriptionFontSize,
                      height: 1.3,
                    ),
                    maxLines: isMobile ? 3 : 4,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Technology tags with optimized layout for mobile
                  if (widget.technologies.isNotEmpty) ...[
                    SizedBox(height: isMobile ? 8 : 12),
                    SizedBox(
                      height: isMobile ? 24 : 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            widget.technologies.length > 4 && isMobile
                                ? 4
                                : widget.technologies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(right: isMobile ? 4 : 6),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 5 : 8,
                                vertical: isMobile ? 2 : 4,
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
  