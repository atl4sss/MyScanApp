/* lib/pages/auth_page.dart */
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _phone   = TextEditingController();
  final _pass1   = TextEditingController();
  final _pass2   = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size   = MediaQuery.of(context).size;
    final isWide = size.width > 600;           // планшет/desktop

    return Scaffold(
      body: Stack(
        children: [
          // ── градиентный фон ───────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F1113), Color(0xFF1F2124)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // ── форма ─────────────────────────────────────────
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWide ? 400 : double.infinity,
                ),
                child: Material(
                  elevation: 12,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 36),
                    child: Form(
                      key: _formKey,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        // лого-лупа
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF1976FF),
                          ),
                          child: const Icon(Icons.search,
                              size: 48, color: Colors.white),
                        ),
                        const SizedBox(height: 24),
                        const Text('Регистрация',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 32),

                        // телефон
                        TextFormField(
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                          decoration: _dec('Номер телефона'),
                          validator: (v) =>
                              (v?.isEmpty ?? true) ? 'Введите телефон' : null,
                        ),
                        const SizedBox(height: 20),

                        // пароль 1
                        TextFormField(
                          controller: _pass1,
                          obscureText: true,
                          decoration: _dec('Пароль'),
                          validator: (v) => (v?.length ?? 0) < 6
                              ? 'Минимум 6 символов'
                              : null,
                        ),
                        const SizedBox(height: 20),

                        // пароль 2
                        TextFormField(
                          controller: _pass2,
                          obscureText: true,
                          decoration: _dec('Повторите пароль'),
                          validator: (v) => v != _pass1.text
                              ? 'Пароли не совпадают'
                              : null,
                        ),
                        const SizedBox(height: 36),

                        // кнопка
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                              // градиент
                              backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.transparent),
                              elevation: MaterialStateProperty.all(0),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.go('/home');
                              }
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF1E88E5), Color(0xFF42A5F5)],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text('Войти',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _dec(String label) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF1F4F8),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      );
}
