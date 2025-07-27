import 'package:flutter/material.dart';

class ResponsiveCard extends StatelessWidget {
  final Widget child;
  const ResponsiveCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final max = MediaQuery.of(context).size.width > 600 ? 480.0 : double.infinity;
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: max),
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
