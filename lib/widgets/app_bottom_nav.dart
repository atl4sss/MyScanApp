import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNav extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  const AppBottomNav({
    super.key,
    required this.index,
    required this.onChanged,
  });

  NavigationDestination _svg(String asset, String label) {
    return NavigationDestination(
      icon: SvgPicture.asset(asset, width: 24, height: 24),
      selectedIcon: SvgPicture.asset(
        asset, width: 24, height: 24,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Замените пути на ваши actual assets/icons/*.svg
    return NavigationBar(
      selectedIndex: index,
      onDestinationSelected: onChanged,
      destinations: [
        _svg('assets/icons/info.svg', 'Info'),
        _svg('assets/icons/doc.svg',  'Reports'),
        _svg('assets/icons/home.svg', 'Home'),
        _svg('assets/icons/chat.svg', 'Chat'),
        _svg('assets/icons/user.svg', 'Profile'),
      ],
    );
  }
}
