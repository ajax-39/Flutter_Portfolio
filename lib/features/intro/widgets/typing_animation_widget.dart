import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypingAnimationWidget extends StatefulWidget {
  final double fontSize;
  final Color textColor;
  final bool isMobile;

  const TypingAnimationWidget({
    super.key,
    required this.fontSize,
    required this.textColor,
    this.isMobile = false,
  });

  @override
  State<TypingAnimationWidget> createState() => _TypingAnimationWidgetState();
}

class _TypingAnimationWidgetState extends State<TypingAnimationWidget> {
  String _currentText = '';
  String _fullText = '';
  int _currentIndex = 0;
  bool _isDeleting = false;
  bool _isWaiting = false;
  int _currentRoleIndex = 0;
  final List<String> _roles = [
    'Flutter Developer',
    'Java Developer',
    'Web Developer',
    'Problem Solver',
  ];

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _fullText = _roles[_currentRoleIndex];
    _currentIndex = 0;
    _isDeleting = false;
    _isWaiting = false;
    _typeText();
  }

  void _typeText() {
    if (_isDeleting) {
      if (_currentIndex > 0) {
        setState(() {
          _currentIndex--;
          _currentText = _fullText.substring(0, _currentIndex);
        });
        Future.delayed(const Duration(milliseconds: 50), _typeText);
      } else {
        _currentRoleIndex = (_currentRoleIndex + 1) % _roles.length;
        _startTyping();
      }
    } else if (_isWaiting) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isDeleting = true;
        });
        _typeText();
      });
    } else {
      if (_currentIndex < _fullText.length) {
        setState(() {
          _currentIndex++;
          _currentText = _fullText.substring(0, _currentIndex);
        });
        Future.delayed(const Duration(milliseconds: 100), _typeText);
      } else {
        setState(() {
          _isWaiting = true;
        });
        _typeText();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentText,
      style: GoogleFonts.bangers(
      color: widget.textColor,
      fontSize: widget.fontSize,
      // fontWeight: FontWeight.w600,
      ),
      textAlign: widget.isMobile ? TextAlign.center : TextAlign.left,
    );
  }
} 