import 'package:ai_english/core/components/footer.dart';
import 'package:ai_english/core/components/header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, 'AI English'),
      body: const Center(
        child: Text('Welcome to AI English!'),
      ),
      bottomNavigationBar: footer(context),
    );
  }
}
