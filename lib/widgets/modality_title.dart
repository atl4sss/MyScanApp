import 'package:flutter/material.dart';
import '../core/theme.dart';

class ModalityTile extends StatelessWidget {
  final String title;
  final ImageProvider image;
  final VoidCallback onTap;
  const ModalityTile({super.key, required this.title, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 92,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kRadius),
          image: DecorationImage(
            image: image, fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.25), BlendMode.darken),
          ),
          boxShadow: [BoxShadow(color: c.shadow.withOpacity(0.06), blurRadius: 18, offset: const Offset(0, 8))],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kRadius),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.25)],
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white, fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
