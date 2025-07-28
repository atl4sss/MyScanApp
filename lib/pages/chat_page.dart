// lib/pages/chat_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/chat_service.dart';
import '../core/theme.dart';
import '../l10n/app_localizations.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _input = TextEditingController();
  final _scrollCtl = ScrollController();
  final _messages = <({String role, String text})>[];
  bool _busy = false;
  int _dummyStep = 0;

  Future<void> _ask() async {
    final loc = AppLocalizations.of(context)!;
    final prompt = _input.text.trim();
    if (prompt.isEmpty || _busy) return;

    setState(() {
      _messages.add((role: 'user', text: prompt));
      _busy = true;
      _input.clear();
    });
    _jumpToEnd();

    late String answer;
    if (_dummyStep < 2) {
      await Future.delayed(const Duration(milliseconds: 300));
      answer = _dummyStep == 0
          ? loc.chatDummy1
          : loc.chatDummy2;
      _dummyStep++;
    } else {
      try {
        answer = await ChatService().ask(prompt);
      } catch (e) {
        answer = loc.chatError(e.toString());
      }
    }

    if (!mounted) return;
    setState(() {
      _messages.add((role: 'ai', text: answer));
      _busy = false;
    });
    _jumpToEnd();
  }

  void _jumpToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtl.hasClients) {
        _scrollCtl.animateTo(
          _scrollCtl.position.maxScrollExtent + 60,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _input.dispose();
    _scrollCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final c = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kBlue),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          loc.chatTitle,
          style: const TextStyle(
            fontFamily: 'SamsungSharpSans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: kBlue, // брендовый синий
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: kBlue),
            tooltip: loc.chatCloseTooltip,
            onPressed: () => context.go('/home'),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Сообщения ────────────────────────────────────────────────
          Expanded(
            child: ListView.builder(
              controller: _scrollCtl,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final isUser = m.role == 'user';
                return Align(
                  alignment:
                  isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUser ? kBlue : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(18),
                        topRight: const Radius.circular(18),
                        bottomLeft: Radius.circular(isUser ? 18 : 4),
                        bottomRight: Radius.circular(isUser ? 4 : 18),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: SelectableText(
                      m.text,
                      style: TextStyle(
                        fontFamily: 'Gothic',
                        fontSize: 14,
                        color: isUser ? Colors.white : kTextBlack,
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ── Поле ввода ───────────────────────────────────────────────
          SafeArea(
            top: false,
            child: Container(
              color: Colors.white,
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _ask(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: c.surface,
                        hintText: loc.chatHint,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide:
                          BorderSide(color: c.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide:
                          BorderSide(color: c.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: kBlue, width: 1.6),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: kBlue,
                    shape: const CircleBorder(),
                    child: IconButton(
                      onPressed: _busy ? null : _ask,
                      icon: _busy
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
