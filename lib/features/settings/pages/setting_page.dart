import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:ai_english/features/auth/providers/auth_provider.dart';
import 'package:ai_english/features/auth/pages/sign_in_page.dart';
import 'package:ai_english/features/settings/pages/theme_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在ログイン中のユーザーアカウントを取得
    final user = ref.watch(authNotifierProvider).user;
    return Scaffold(
      appBar: header(context),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSectionHeader(context, '一般'),
          _buildNavigationItem(
            context,
            icon: Icons.color_lens,
            title: 'テーマ',
            subtitle: 'テーマを変更',
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const ThemeSelectionPage(),
                  type: PageTransitionType.rightToLeftWithFade,
                ),
              );
            },
          ),
          _buildNavigationItem(
            context,
            icon: Icons.notifications,
            title: '通知',
            subtitle: '通知の設定',
            onTap: () {
              // Will be implemented in the future
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Coming soon!'),
                ),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'アカウント'),
          _buildNavigationItem(
            context,
            icon: Icons.logout,
            title: 'ログアウト',
            subtitle: '${user?.email}',
            onTap: () {
              _showSignOutConfirmationDialog(context, ref);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: footer(context, false),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildNavigationItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showSignOutConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ログアウト'),
        content: const Text('ログアウトしますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await ref.read(authNotifierProvider.notifier).signOut();
              if (context.mounted) {
                // Navigate to sign in page and clear navigation stack
                Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    child: const SignInPage(),
                    type: PageTransitionType.fade,
                  ),
                  (route) => false,
                );
              }
            },
            child: const Text('ログアウト'),
          ),
        ],
      ),
    );
  }
}
