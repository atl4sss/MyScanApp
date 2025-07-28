/* lib/pages/bottom_nav.dart */
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// Порядок: 0=info, 1=reports, 2=home (круглая), 3=chat, 4=profile
const _routes = ['/info', '/reports', '/home', '/chat', '/profile'];
const _assets = [
  'assets/icons/info.svg',
  'assets/icons/doc.svg',
  'assets/icons/home.svg',  // центр (в кружке)
  'assets/icons/chat.svg',
  'assets/icons/user.svg',
];

class BottomNav extends StatefulWidget {
  final Widget child;
  const BottomNav({super.key, required this.child});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  // размеры
  static const _barHeight = 72.0;
  static const _radius    = 26.0;
  static const _iconSize  = 30.0;
  static const _fabSize   = 66.0;

  // более яркий «приятный» синий для FAB
  static const Gradient _fabGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4F8CFF), Color(0xFF2F6BFF)],
  );

  int _idx = 2; // активна «Home»

  void _go(int i) {
    if (_idx == i) return;
    setState(() => _idx = i);
    context.go(_routes[i]);
  }

  Widget _sideIcon(int i, ColorScheme c) {
    final active = _idx == i;

    // ярко‑синий для активной, более светлый — для неактивной
    final Color iconColor = active
        ? const Color(0xFF2F6BFF) // насыщённый
        : Color.lerp(const Color(0xFF2F6BFF), Colors.white, 0.35)!; // мягкий голубой

    return InkResponse(
      onTap: () => _go(i),
      radius: _iconSize + 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            tween: Tween(begin: 1, end: active ? 1.08 : 1.0),
            builder: (context, scale, child) => Transform.scale(
              scale: scale,
              child: child,
            ),
            child: SvgPicture.asset(
              _assets[i],
              width: _iconSize,
              height: _iconSize,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          const SizedBox(height: 6),
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: active ? const Color(0xFF2F6BFF) : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // ── белая капсула ────────────────────────────────────────────────
            Container(
              height: _barHeight,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_radius),
                // лёгкий голубой бордер вместо серого
                border: Border.all(color: const Color(0xFF2F6BFF).withOpacity(.16), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _sideIcon(0, c),
                  _sideIcon(1, c),
                  SizedBox(width: _fabSize * .98), // место под центр
                  _sideIcon(3, c),
                  _sideIcon(4, c),
                ],
              ),
            ),

            // ── центральная круглая кнопка (БЕЗ «глоу» под ней) ──────────────
            Positioned(
              top: -_fabSize * 0.35,
              child: GestureDetector(
                onTap: () => _go(2),
                child: Container(
                  width: _fabSize,
                  height: _fabSize,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: _fabGradient,
                    boxShadow: [
                      // оставил лишь аккуратную тень для объёма
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    _assets[2],
                    width: 30,
                    height: 30,
                    colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
