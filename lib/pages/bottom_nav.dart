/* lib/pages/bottom_nav.dart */
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// ─── визуальные константы ─────────────────────────────────────────────────────
const _navHeight   = 64.0;           // высота «капсулы»
const _fabSize     = 64.0;           // ⟵ БОЛЬШЕ: диаметр круглой кнопки‑домика
const _fabIconSize = 36.0;           // ⟵ БОЛЬШЕ: размер SVG внутри FAB
const _radius      = 18.0;           // радиус скругления бара
const _iconSize    = 32.0;           // боковые иконки
const _centerGap   = _fabSize * .8;  // ⟵ ширина «пустоты» под FAB
const _shadowColor = Color(0x33000000); // тень под FAB

/// позиция → (маршрут, svg‑иконка)
const _tabs = <int, ({String route, String asset})>{
  0: (route: '/info'   , asset: 'assets/icons/info.svg' ),
  1: (route: '/reports', asset: 'assets/icons/doc.svg'  ),
  2: (route: '/home'   , asset: 'assets/icons/home.svg' ), // FAB
  3: (route: '/chat'   , asset: 'assets/icons/chat.svg' ),
  4: (route: '/profile', asset: 'assets/icons/user.svg' ),
};

// ─── основной виджет ──────────────────────────────────────────────────────────
class BottomNav extends StatefulWidget {
  final Widget child;
  const BottomNav({super.key, required this.child});

  @override State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _idx = 2; // активная вкладка (домик по умолчанию)

  void _go(int i) {
    if (_idx == i) return;
    setState(() => _idx = i);
    context.go(_tabs[i]!.route);
  }

  Widget _navIcon(int i) {
    final active = _idx == i;
    return IconButton(
      onPressed: () => _go(i),
      splashRadius: _iconSize + 8,
      iconSize: _iconSize,
      icon: SvgPicture.asset(
        _tabs[i]!.asset,
        width : _iconSize,
        height: _iconSize,
        colorFilter: ColorFilter.mode(
          active ? Colors.white : Colors.white70,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,

      // ── нижняя навигация ──────────────────────────────────────
      bottomNavigationBar: SafeArea(
        top: false,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // ── капсула ─────────────────────────────────────────
            Container(
              height: _navHeight,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft : Radius.circular(_radius),
                  topRight: Radius.circular(_radius),
                ),
                gradient: LinearGradient(
                  begin : Alignment.centerLeft,
                  end   : Alignment.centerRight,
                  colors: [Color(0xFF3793FF), Color(0xFF006BFF)],
                ),
              ),
              foregroundDecoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft : Radius.circular(_radius),
                  topRight: Radius.circular(_radius),
                ),
                gradient: LinearGradient(
                  begin : Alignment.topCenter,
                  end   : Alignment.bottomCenter,
                  colors: [Colors.white24, Colors.transparent],
                  stops : [0, .06],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _navIcon(0),
                  _navIcon(1),
                  SizedBox(width: _centerGap), // ⟵ увеличенный промежуток
                  _navIcon(3),
                  _navIcon(4),
                ],
              ),
            ),

            // ── «плавающая» круглая кнопка‑домик ────────────────
            Positioned(
              // «утопили» примерно на 40 % высоты, чтобы выглядело как в макете
              top: -_fabSize * 0.3,
              child: GestureDetector(
                onTap: () => _go(2),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width : _fabSize,
                  height: _fabSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _idx == 2 ? const Color(0xFF0057FF)
                        : const Color(0xFF2E7BFF),
                    boxShadow: const [
                      BoxShadow(
                        color: _shadowColor,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: SvgPicture.asset(
                      _tabs[2]!.asset,
                      width : _fabIconSize,
                      height: _fabIconSize,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
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
