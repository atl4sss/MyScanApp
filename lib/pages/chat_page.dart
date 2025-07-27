// lib/pages/chat_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/chat_service.dart';
import '../core/theme.dart';
import '../l10n/app_localizations.dart'; // NEW

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
    final loc = AppLocalizations.of(context)!; // NEW
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
      // CHANGED: локализованные ответы
      await Future.delayed(const Duration(milliseconds: 300));
      answer = _dummyStep == 0 ? loc.chatDummy1 : loc.chatDummy2;
      _dummyStep++;
    } else {
      try {
        answer = await ChatService().ask(prompt);
      } catch (e) {
        answer = loc.chatError(e.toString()); // CHANGED
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
    final loc = AppLocalizations.of(context)!; // NEW

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBlue,
        title: Row(
          children: [
            Image.asset('assets/icons/logoai.png', width: 32, height: 32),
            const SizedBox(width: 8),
            Text(
              loc.chatTitle, // CHANGED
              style: const TextStyle(
                fontFamily: 'SamsungSharpSans',
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: loc.chatCloseTooltip, // CHANGED
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => context.go('/home'),
          )
        ],
      ),
      body: Column(
        children: [
          // сообщения
          Expanded(
            child: ListView.builder(
              controller: _scrollCtl,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final isUser = m.role == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? kBlue : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    child: SelectableText(
                      m.text,
                      style: TextStyle(
                        fontFamily: 'Gothic',
                        color: isUser ? Colors.white : kTextBlack,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // поле ввода
          SafeArea(
            top: false,
            child: DecoratedBox(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _input,
                      minLines: 1,
                      maxLines: 4,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _ask(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        hintText: loc.chatHint, // CHANGED
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _busy ? null : _ask,
                    icon: _busy
                        ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: kBlue),
                    )
                        : const Icon(Icons.send, color: kBlue),
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
