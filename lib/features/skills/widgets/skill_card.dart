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

class _SkillCardState extends State<SkillCard> with SingleTickerProviderStateMixin {
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
    final cardSize = widget.isDesktop ? 150.0 : 100.0;
    
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: cardSize,
          height: cardSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: _isHovered 
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.6),
                    blurRadius: 20,
                    spreadRadius: 5,
                  )
                ] 
              : [],
          ),
          child: InkWell(
            onTap: () {
              // Optionally show details or trigger an animation
            },
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.borderRadius)),
              elevation: _isHovered ? widget.elevation + 1 : widget.elevation,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isHovered 
                      ? [Colors.blue.shade100, Colors.blue.shade200]
                      : [Colors.blue.shade50, Colors.blue.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
                width: cardSize,
                height: cardSize,
                padding: EdgeInsets.all(widget.cardPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: widget.iconSize,
                      width: widget.iconSize,
                      child: SvgPicture.asset(
                        widget.skill.iconPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: widget.isDesktop ? widget.cardPadding : widget.cardPadding),
                    Flexible(
                      child: Text(
                        widget.skill.label,
                        style: TextStyle(
                          fontSize: widget.textSize,
                          fontWeight: FontWeight.w600,
                          color: _isHovered ? Colors.blue.shade700 : Colors.black87,
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
          ),
        ),
      ),
    );
  }
} 