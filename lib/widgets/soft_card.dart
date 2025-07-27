import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme.dart';

class SoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding, margin;
  final VoidCallback? onTap;
  final double radius;
  final bool glass;

  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(12),
    this.onTap,
    this.radius = kRadius,
    this.glass = false,
  });

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;

    Widget body = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: glass ? c.surface.withOpacity(0.6) : c.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: c.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: c.shadow.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );

    if (glass) {
      body = ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: body,
        ),
      );
    }

    body = Container(margin: margin, child: body);
    if (onTap == null) return body;

    return _Tap(child: body, onTap: onTap!);
  }
}

class _Tap extends StatefulWidget {
  final Widget child; final VoidCallback onTap;
  const _Tap({required this.child, required this.onTap});
  @override State<_Tap> createState() => _TapState();
}
class _TapState extends State<_Tap> {
  bool down = false;
  @override
  Widget build(BuildContext context) {
    const d = Duration(milliseconds: 180);
    const curve = Curves.easeOutCubic;
    return GestureDetector(
      onTapDown: (_) => setState(() => down = true),
      onTapUp: (_)   => setState(() => down = false),
      onTapCancel: () => setState(() => down = false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: down ? 0.98 : 1, duration: d, curve: curve,
        child: AnimatedOpacity(
          opacity: down ? 0.92 : 1, duration: d, curve: curve,
          child: widget.child,
        ),
      ),
    );
  }
}
