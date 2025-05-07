import 'package:flutter/material.dart';
import '../data/colors/main_colors.dart';
import '../data/icons.dart';

class MainNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MainNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: accentLightColor,
      unselectedItemColor: Colors.grey,
      currentIndex: currentIndex,
      onTap: onTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            homeIcon,
            color: currentIndex == 0 ? accentLightColor : Colors.grey,
            height: 28,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart, color: currentIndex == 1 ? accentLightColor : Colors.grey),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            favoriteIcon,
            color: currentIndex == 2 ? accentLightColor : Colors.grey,
            height: 28,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            accountIcon,
            color: currentIndex == 3 ? accentLightColor : Colors.grey,
            height: 28,
          ),
          label: '',
        ),
      ],
    );
  }
} 