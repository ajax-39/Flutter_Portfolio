import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../common/responsive_utils.dart';
import '../skills/widgets/skills_desktop_widget.dart';
import '../skills/widgets/skills_mobile_widget.dart';
import '../projects/widgets/projects_desktop_widget.dart';
import '../projects/widgets/projects_mobile_widget.dart';
import '../contact_us/widgets/contact_us_desktop_widget.dart';
import '../contact_us/widgets/contact_us_mobile_widget.dart';
import '../welcome/widgets/welcome_screen.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../design/circuit_background.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(4, (index) => GlobalKey());
  int _currentSection = 0;

  // Animation controllers for each section
  late final List<AnimationController> _animationControllers;
  late final List<Animation<double>> _fadeAnimations;
  late final List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateCurrentSection);

    // Initialize animation controllers for each section
    _animationControllers = List.generate(
      4,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      ),
    );

    // Create fade animations
    _fadeAnimations =
        _animationControllers
            .map(
              (controller) =>
                  CurvedAnimation(parent: controller, curve: Curves.easeInOut),
            )
            .toList();

    // Create slide animations
    _slideAnimations =
        _animationControllers
            .map(
              (controller) => Tween<Offset>(
                begin: const Offset(0, 0),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
              ),
            )
            .toList();
  }

  void _updateCurrentSection() {
    for (int i = 0; i < _sectionKeys.length; i++) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        if (position.dy <= 100) {
          setState(() {
            _currentSection = i;
          });
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      setState(() {
        _currentSection = index;
      });

      final double offset =
          index == 0
              ? 0
              : _sectionKeys.sublist(0, index).fold(0.0, (sum, key) {
                final ctx = key.currentContext;
                if (ctx == null) return sum;
                final RenderBox box = ctx.findRenderObject() as RenderBox;
                return sum + box.size.height;
              });

      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateCurrentSection);
    _scrollController.dispose();

    // Dispose animation controllers
    for (final controller in _animationControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: CircuitBoardBackground(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = ResponsiveUtils.isDesktopFromConstraints(
              constraints,
            );
            final content = Column(
              children: [
                // Welcome Section
                VisibilityDetector(
                  key: const Key('welcome-section'),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.3 &&
                        !_animationControllers[0].isCompleted) {
                      _animationControllers[0].forward();
                    }
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimations[0],
                    child: Container(
                      key: _sectionKeys[0],
                      child: const WelcomeScreen(),
                    ),
                  ),
                ),
                // Skills Section
                VisibilityDetector(
                  key: const Key('skills-section'),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.3 &&
                        !_animationControllers[1].isCompleted) {
                      _animationControllers[1].forward();
                    }
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimations[1],
                    child: Container(
                      key: _sectionKeys[1],
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.only(
                        top: 90.0,
                        left: isDesktop ? 100.0 : 20.0,
                        right: isDesktop ? 100.0 : 20.0,
                        bottom: 40.0,
                      ),
                      child:
                          isDesktop
                              ? const SkillsDesktopWidget()
                              : const SkillsMobileWidget(),
                    ),
                  ),
                ),
                // Projects Section
                VisibilityDetector(
                  key: const Key('projects-section'),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.3 &&
                        !_animationControllers[2].isCompleted) {
                      _animationControllers[2].forward();
                    }
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimations[2],
                    child: Container(
                      key: _sectionKeys[2],
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: 90.0,
                        left: isDesktop ? 100.0 : 20.0,
                        right: isDesktop ? 100.0 : 20.0,
                        bottom: 50.0,
                      ),
                      child:
                          isDesktop
                              ? const ProjectsDesktopWidget()
                              : const ProjectsMobileWidget(),
                    ),
                  ),
                ),
                // Contact Section
                VisibilityDetector(
                  key: const Key('contact-section'),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.3 &&
                        !_animationControllers[3].isCompleted) {
                      _animationControllers[3].forward();
                    }
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimations[3],
                    child: Container(
                      key: _sectionKeys[3],
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: 90.0,
                        left: isDesktop ? 100.0 : 20.0,
                        right: isDesktop ? 100.0 : 20.0,
                        bottom: 50.0,
                      ),
                      child:
                          isDesktop
                              ? const ContactUsDesktopWidget()
                              : const ContactUsMobileWidget(),
                    ),
                  ),
                ),
              ],
            );

            return SingleChildScrollView(
              controller: _scrollController,
              child: isDesktop ? content : SafeArea(top: true, child: content),
            );
          },
        ),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = ResponsiveUtils.isDesktopFromConstraints(
              constraints,
            );
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color(0xFF0A0A1A).withOpacity(0.98),
                    const Color(0xFF0D1525).withOpacity(0.98),
                    const Color(0xFF0A1F3C).withOpacity(0.98),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF13BBFF).withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isDesktop ? 100.0 : 20.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Navigation
                      if (isDesktop)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildNavLink('Home', 0),
                            const SizedBox(width: 40),
                            _buildNavLink('Skills', 1),
                            const SizedBox(width: 40),
                            _buildNavLink('Projects', 2),
                            const SizedBox(width: 40),
                            _buildNavLink('Contact', 3),
                          ],
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              popupMenuTheme: PopupMenuThemeData(
                                color: Colors.black.withOpacity(0.9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            child: PopupMenuButton<int>(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 28,
                              ),
                              onSelected: _scrollToSection,
                              itemBuilder:
                                  (context) => [
                                    _buildPopupMenuItem('Home', 0),
                                    _buildPopupMenuItem('Skills', 1),
                                    _buildPopupMenuItem('Projects', 2),
                                    _buildPopupMenuItem('Contact', 3),
                                  ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  PopupMenuItem<int> _buildPopupMenuItem(String text, int value) {
    return PopupMenuItem<int>(
      value: value,
      child: Text(
        text,
        style: TextStyle(
          color:
              _currentSection == value ? const Color(0xFF13BBFF) : Colors.white,
          fontSize: 16,
          fontFamily: 'Preah',
        ),
      ),
    );
  }

  Widget _buildNavButton(String text, int index) {
    final isSelected = _currentSection == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: () => _scrollToSection(index),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  isSelected
                      ? const Color(0xFF13BBFF).withOpacity(0.2)
                      : Colors.transparent,
              border: Border.all(
                color:
                    isSelected ? const Color(0xFF13BBFF) : Colors.transparent,
                width: 1,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? const Color(0xFF13BBFF) : Colors.white,
                fontSize: 16,
                fontFamily: 'Preah',
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavLink(String text, int index) {
    final isSelected = _currentSection == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: InkWell(
          onTap: () => _scrollToSection(index),
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  isSelected
                      ? const Color(0xFF13BBFF).withOpacity(0.2)
                      : Colors.transparent,
              border: Border.all(
                color:
                    isSelected ? const Color(0xFF13BBFF) : Colors.transparent,
                width: 1,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? const Color(0xFF13BBFF) : Colors.white,
                fontSize: 16,
                fontFamily: 'Preah',
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
