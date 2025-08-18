import 'dart:math';
import 'package:flutter/material.dart';

class CircuitBoardBackground extends StatefulWidget {
  final Widget child;
  final Color lineColor;
  final Color nodeColor;
  
  const CircuitBoardBackground({
    super.key, 
    required this.child,
    this.lineColor = const Color(0xFF075985),
    this.nodeColor = const Color(0xFF0EA5E9),
  });

  @override
  State<CircuitBoardBackground> createState() => _CircuitBoardBackgroundState();
}

class _CircuitBoardBackgroundState extends State<CircuitBoardBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random random = Random();
  Offset _mousePosition = Offset.zero;
  bool _mouseInside = false;
  bool _isHoveringInteractiveElement = false;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 15000),
    )..repeat();
    
    // Create particles
    _initializeParticles();
  }
  
  void _initializeParticles() {
    _particles.clear();
    for (int i = 0; i < 80; i++) {
      _particles.add(Particle(random));
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _mouseInside = true;
          _mousePosition = event.localPosition;
        });
      },
      onExit: (event) {
        setState(() {
          _mouseInside = false;
          _isHoveringInteractiveElement = false;
        });
      },
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      child: Stack(
        children: [
          // Background color
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF050510), // Darker blue-black
                  Color(0xFF07101E), // Darker blue
                  Color(0xFF020E21), // Deeper navy
                ],
              ),
            ),
          ),
          
          // Circuit board particle effect
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                painter: CircuitPainter(
                  particles: _particles,
                  lineColor: widget.lineColor,
                  nodeColor: widget.nodeColor,
                  mousePosition: _mousePosition,
                  mouseInside: _mouseInside && !_isHoveringInteractiveElement,
                  screenSize: MediaQuery.of(context).size,
                ),
                size: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
              );
            },
          ),
          
          // Content with notification listener for hover detection
          NotificationListener<InteractiveElementHoverNotification>(
            onNotification: (notification) {
              setState(() {
                _isHoveringInteractiveElement = notification.isHovering;
              });
              return true;
            },
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

// Custom notification to signal interactive element hover
class InteractiveElementHoverNotification extends Notification {
  final bool isHovering;
  
  InteractiveElementHoverNotification(this.isHovering);
}

// Use this widget to wrap interactive elements like buttons and cards
class InteractiveElement extends StatelessWidget {
  final Widget child;
  
  const InteractiveElement({Key? key, required this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => InteractiveElementHoverNotification(true).dispatch(context),
      onExit: (_) => InteractiveElementHoverNotification(false).dispatch(context),
      child: child,
    );
  }
}

class Particle {
  late double x;
  late double y;
  late double speed;
  late double baseSize;
  late double size;
  late double directionX;
  late double directionY;
  late double alpha;
  
  Particle(Random random) {
    x = random.nextDouble() * 100; // Percentage position
    y = random.nextDouble() * 100;
    speed = 0.05 + random.nextDouble() * 0.1;
    baseSize = 1 + random.nextDouble() * 2;
    size = baseSize;
    directionX = random.nextBool() ? speed : -speed;
    directionY = random.nextBool() ? speed : -speed;
    alpha = 0.4;
  }
  
  void update() {
    x += directionX;
    y += directionY;
    
    // Bounce off walls
    if (x < 0 || x > 100) directionX *= -1;
    if (y < 0 || y > 100) directionY *= -1;
  }
  
  void reactToMouse(Offset mousePosition, Size screenSize, bool mouseInside) {
    if (!mouseInside) {
      size = baseSize;
      alpha = 0.4;
      return;
    }
    
    final percentX = x / 100;
    final percentY = y / 100;
    final particleX = percentX * screenSize.width;
    final particleY = percentY * screenSize.height;
    
    final distance = sqrt(
      pow(mousePosition.dx - particleX, 2) + 
      pow(mousePosition.dy - particleY, 2)
    );
    
    // Interactive radius (pixels)
    const interactiveRadius = 150.0;
    
    if (distance < interactiveRadius) {
      // Calculate how close the cursor is (1.0 = at the center, 0.0 = at the edge)
      final influence = 1.0 - (distance / interactiveRadius);
      
      // Grow the particle based on proximity
      size = baseSize + (baseSize * 2 * influence);
      
      // Increase opacity based on proximity
      alpha = 0.4 + (0.6 * influence);
      
      // Add small attraction towards cursor
      final angle = atan2(mousePosition.dy - particleY, mousePosition.dx - particleX);
      final attraction = 0.02 * influence;
      
      directionX += cos(angle) * attraction;
      directionY += sin(angle) * attraction;
      
      // Cap speed
      final currentSpeed = sqrt(pow(directionX, 2) + pow(directionY, 2));
      if (currentSpeed > speed * 3) {
        directionX = (directionX / currentSpeed) * speed * 3;
        directionY = (directionY / currentSpeed) * speed * 3;
      }
    } else {
      // Return to normal state
      size = baseSize;
      alpha = 0.4;
    }
  }
}

class CircuitPainter extends CustomPainter {
  final List<Particle> particles;
  final Color lineColor;
  final Color nodeColor;
  final Offset mousePosition;
  final bool mouseInside;
  final Size screenSize;
  final double connectionDistance = 15; // Connection distance in percentage
  
  CircuitPainter({
    required this.particles,
    required this.lineColor,
    required this.nodeColor,
    required this.mousePosition,
    required this.mouseInside,
    required this.screenSize,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round;
    
    final linePaint = Paint()
      ..strokeWidth = 0.4;
    
    // Update particles
    for (var particle in particles) {
      particle.update();
      particle.reactToMouse(mousePosition, size, mouseInside);
    }
    
    // Draw connections
    for (int i = 0; i < particles.length; i++) {
      final percentX = particles[i].x / 100;
      final percentY = particles[i].y / 100;
      final currentX = percentX * size.width;
      final currentY = percentY * size.height;
      
      for (int j = i + 1; j < particles.length; j++) {
        final otherPercentX = particles[j].x / 100;
        final otherPercentY = particles[j].y / 100;
        final otherX = otherPercentX * size.width;
        final otherY = otherPercentY * size.height;
        
        final distance = sqrt(
          pow(otherPercentX - percentX, 2) + 
          pow(otherPercentY - percentY, 2)
        );
        
        if (distance < connectionDistance / 100) {
          // Calculate average alpha between two particles for connection
          final avgAlpha = (particles[i].alpha + particles[j].alpha) / 2;
          
          // Draw line with brightness based on particle alpha
          linePaint.color = lineColor.withOpacity(0.15 * avgAlpha);
          canvas.drawLine(
            Offset(currentX, currentY),
            Offset(otherX, otherY),
            linePaint,
          );
        }
      }
      
      // Draw particle with dynamic size and alpha
      paint.color = nodeColor.withOpacity(particles[i].alpha);
      canvas.drawCircle(
        Offset(currentX, currentY),
        particles[i].size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CircuitPainter oldDelegate) => true;
} 