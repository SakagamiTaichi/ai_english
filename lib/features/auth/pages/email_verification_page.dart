import 'package:ai_english/core/components/error_feedback.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/auth/pages/sign_in_page.dart';
import 'package:ai_english/features/auth/providers/auth_provider.dart';
import 'package:ai_english/features/dashboard/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class EmailVerificationPage extends ConsumerStatefulWidget {
  final String email;
  final String password;

  const EmailVerificationPage({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  ConsumerState<EmailVerificationPage> createState() =>
      _EmailVerificationPageState();
}

class _EmailVerificationPageState extends ConsumerState<EmailVerificationPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }

    // 全ての入力が完了したかチェック
    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
      _verifyCode();
    }
  }

  void _onKeyPressed(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  void _verifyCode() async {
    setState(() {
      _isLoading = true;
    });

    await ApiOperationWrapper.execute(
      context: context,
      operation: () => ref.read(authNotifierProvider.notifier).signUp(
          widget.email,
          widget.password,
          _controllers.map((c) => c.text).join()),
      successMessage: '認証が成功しました。',
      onSuccess: () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            PageTransition(
              child: const DashboardPage(),
              type: PageTransitionType.fade,
            ),
          );
        });
      },
    );

    setState(() {
      _isLoading = false;
    });
  }

  void _resendEmail() async {
    await ApiOperationWrapper.execute(
      context: context,
      operation: () => ref
          .read(authNotifierProvider.notifier)
          .sendVerificationEmail(widget.email),
      successMessage: '認証コードを再送しました。',
      onSuccess: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // キーボード表示時のレイアウト調整を有効にする
      resizeToAvoidBottomInset: true,
      appBar: header(context),
      body: SafeArea(
        child: SingleChildScrollView(
          // キーボード表示時に自動的にスクロールする
          physics: const ClampingScrollPhysics(),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 1),
                  Icon(
                    Icons.verified_user,
                    size: 64,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '認証コードを入力してください',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '6桁の認証コードを送信しました\n${widget.email}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  // 認証コード入力フィールド
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 50,
                        child: KeyboardListener(
                          focusNode: FocusNode(),
                          onKeyEvent: (event) => _onKeyPressed(event, index),
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(1),
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.all(16),
                            ),
                            onChanged: (value) => _onCodeChanged(value, index),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final code = _controllers.map((c) => c.text).join();
                            if (code.length == 6) {
                              _verifyCode();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('6桁の認証コードを入力してください'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                          child: const Text('認証する'),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: _resendEmail,
                          child: const Text('認証コードを再送する'),
                        ),
                      ],
                    ),
                  const Spacer(flex: 1),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          child: const SignInPage(),
                          type: PageTransitionType.fade,
                        ),
                      );
                    },
                    child: const Text('ログイン画面に戻る'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
