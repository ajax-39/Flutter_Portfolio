import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedGradientBackground extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final List<Color> colors1;
  final List<Color> colors2;
  final Alignment begin;
  final Alignment end;
  final bool shimmer;

  const AnimatedGradientBackground({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 8),
    required this.colors1,
    required this.colors2,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
    this.shimmer = true,
  }) : super(key: key);

  @override
  State<AnimatedGradientBackground> createState() => _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground> with TickerProviderStateMixin {
  late AnimationController _colorController;
  late AnimationController _shimmerController;
  late Animation<double> _colorAnimation;
  late Animation<AlignmentGeometry> _beginAlignment;
  late Animation<AlignmentGeometry> _endAlignment;

  @override
  void initState() {
    super.initState();
    
    // Main color transition animation
    _colorController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    
    _colorAnimation = CurvedAnimation(
      parent: _colorController, 
      curve: Curves.easeInOut,
    );
    
    // Shimmer effect animation (if enabled)
    _shimmerController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    );
    
    // Create shimmer effect with dynamic alignment changes
    _beginAlignment = TweenSequence<AlignmentGeometry>([
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<AlignmentGeometry>(
          begin: widget.begin,
          end: Alignment.topRight,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.bottomLeft,
          end: widget.begin,
        ),
      ),
    ]).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));
    
    _endAlignment = TweenSequence<AlignmentGeometry>([
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<AlignmentGeometry>(
          begin: widget.end,
          end: Alignment.bottomLeft,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.topRight,
          end: widget.end,
        ),
      ),
    ]).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));
    
    // Start animations
    _colorController.repeat(reverse: true);
    
    if (widget.shimmer) {
      _shimmerController.repeat();
    }
  }

  @override
  void dispose() {
    _colorController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_colorController, _shimmerController]),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: widget.shimmer ? _beginAlignment.value as Alignment : widget.begin,
              end: widget.shimmer ? _endAlignment.value as Alignment : widget.end,
              colors: [
                Color.lerp(widget.colors1[0], widget.colors2[0], _colorAnimation.value)!,
                Color.lerp(widget.colors1[1], widget.colors2[1], _colorAnimation.value)!,
                Color.lerp(widget.colors1[2], widget.colors2[2], _colorAnimation.value)!,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
} 