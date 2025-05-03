import 'package:flutter/material.dart';
import 'skill_card.dart';
import '../models/skill.dart';

class SkillsGrid extends StatelessWidget {
  final bool isDesktop;
  final List<Skill> skills;

  const SkillsGrid({
    Key? key,
    required this.isDesktop,
    required this.skills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Different sizes based on desktop or mobile
    final iconSize = isDesktop ? 90.0 : 60.0;
    final cardPadding = isDesktop ? 10.0 : 6.0;
    final borderRadius = isDesktop ? 12.0 : 8.0;
    final elevation = isDesktop ? 3.0 : 2.0;
    final textSize = isDesktop ? 16.0 : 12.0;
    final gridSpacing = isDesktop ? 20.0 : 16.0;

    if (isDesktop) {
      // Desktop view with wrap layout
      return Container(
        padding: EdgeInsets.symmetric(vertical: gridSpacing),
        width: double.infinity,
        child: Wrap(
          spacing: gridSpacing,
          runSpacing: gridSpacing,
          alignment: WrapAlignment.start,
          children: skills.map((skill) => 
            SkillCard(
              skill: skill,
              iconSize: iconSize,
              cardPadding: cardPadding,
              borderRadius: borderRadius,
              elevation: elevation,
              textSize: textSize,
              isDesktop: isDesktop,
            )
          ).toList(),
        ),
      );
    } else {
      // Mobile view with 2 horizontally scrollable rows
      final int halfLength = (skills.length / 2).ceil();
      final firstRow = skills.sublist(0, halfLength);
      final secondRow = skills.sublist(halfLength);

      return Container(
        height: 240, // Two 100px cards + spacing
        child: Column(
          children: [
            // First row
            Container(
              height: 120,
              padding: EdgeInsets.only(bottom: gridSpacing / 2),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: firstRow.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: gridSpacing),
                    child: SkillCard(
                      skill: firstRow[index],
                      iconSize: iconSize,
                      cardPadding: cardPadding,
                      borderRadius: borderRadius,
                      elevation: elevation,
                      textSize: textSize,
                      isDesktop: isDesktop,
                    ),
                  );
                },
              ),
            ),
            // Second row
            Container(
              height: 120,
              padding: EdgeInsets.only(top: gridSpacing / 2),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: secondRow.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: gridSpacing),
                    child: SkillCard(
                      skill: secondRow[index],
                      iconSize: iconSize,
                      cardPadding: cardPadding,
                      borderRadius: borderRadius,
                      elevation: elevation,
                      textSize: textSize,
                      isDesktop: isDesktop,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}