import 'package:flutter/material.dart';

/// A Scaffold with:
///  - an AppBar that shows a back button if Navigator.canPop()
///  - optional actions & fab
class AppScaffold extends StatelessWidget {
  final String title;
  final Widget? body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.title,
    this.body,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    return Scaffold(
      appBar: AppBar(
        leading: canPop ? const BackButton() : null,
        title: Text(title),
        actions: actions,
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}