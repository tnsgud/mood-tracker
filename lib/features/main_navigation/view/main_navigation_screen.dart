import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../model/custom_tab.dart';

class MainNavigationScreen extends StatelessWidget {
  MainNavigationScreen({
    super.key,
    required this.currentPath,
    required this.child,
  });

  final String currentPath;
  final Widget child;
  final List<CustomTab> tabs = [
    CustomTab(
      icon: FontAwesomeIcons.house,
      path: '/feeds',
    ),
    CustomTab(
      icon: FontAwesomeIcons.pencil,
      path: '/posting',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: child,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final tab in tabs)
              GestureDetector(
                onTap: () => context.go(tab.path),
                child: FaIcon(
                  tab.icon,
                  color: currentPath == tab.path ? Colors.white : Colors.grey,
                ),
              )
          ],
        ),
      ),
    );
  }
}
