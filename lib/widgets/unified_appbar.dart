import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnifiedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final bool centerTitle;

  const UnifiedAppBar({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0A1A4A),
      elevation: 8,
      title: Text(
        title,
        style: GoogleFonts.merriweather(
          textStyle: const TextStyle(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Color(0xFF0A1A4A), blurRadius: 8, offset: Offset(0, 0))],
          ),
        ),
      ),
      centerTitle: centerTitle,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            )
          : null,
      shape: null, // Без закруглений
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
} 