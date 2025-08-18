import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/skill.dart';

class SkillCard extends StatefulWidget {
  final Skill skill;
  final double iconSize;
  final double cardPadding;
  final double borderRadius;
  final double elevation;
  final double textSize;
  final bool isDesktop; 

  const SkillCard({
    super.key,
    required this.skill,
    required this.iconSize,
    required this.isDesktop,
    this.cardPadding = 8,
    this.borderRadius = 12,
    this.elevation = 2,
    this.textSize = 16,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  bool _isHovered = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Perfect square size based on desktop/mobile
    final cardSize = widget.isDesktop ? 140.0 : 100.0;
    // Calculate icon size to maintain proportions with padding
    final imageSize = cardSize * 0.6;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: SizedBox(
          width: cardSize,
          height:
              cardSize +
              (widget.textSize * 2.0), // Add more height for text below
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Card with image
              Container(
                width: cardSize,
                height: cardSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow:
                      _isHovered
                          ? [
                            BoxShadow(
                              color: Color(0xFF13BBFF).withOpacity(0.6),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: Offset(0, 4),
                            ),
                          ]
                          : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: Offset(0, 2),
                            ),
                          ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // Optionally show details or trigger an animation
                    },
                    onTapDown: _onTapDown,
                    onTapUp: _onTapUp,
                    onTapCancel: _onTapCancel,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors:
                              _isHovered
                                  ? [
                                    Color(0xFF1A2151).withOpacity(0.9),
                                    Color(0xFF1F3A93).withOpacity(0.9),
                                  ]
                                  : [
                                    Color(0xFF1A2151).withOpacity(0.7),
                                    Color(0xFF1F3A93).withOpacity(0.7),
                                  ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                        border: Border.all(
                          color:
                              _isHovered
                                  ? Color(0xFF13BBFF)
                                  : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      padding: EdgeInsets.all(widget.cardPadding),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: imageSize,
                          width: imageSize,
                          padding: EdgeInsets.all(widget.cardPadding / 2),
                          decoration: BoxDecoration(
                            color:
                                _isHovered
                                    ? Colors.white.withOpacity(0.15)
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius / 2,
                            ),
                          ),
                          child: SvgPicture.asset(
                            widget.skill.iconPath,
                            fit: BoxFit.contain,
                            colorFilter:
                                _isHovered
                                    ? ColorFilter.mode(
                                      Colors.white,
                                      BlendMode.srcIn,
                                    )
                                    : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Text below card
              Container(
                padding: EdgeInsets.only(top: 8.0),
                width: cardSize,
                child: Text(
                  widget.skill.label,
                  style: TextStyle(
                    fontSize: widget.textSize,
                    fontWeight: FontWeight.w600,
                    color: _isHovered ? Color(0xFF13BBFF) : Colors.white,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
