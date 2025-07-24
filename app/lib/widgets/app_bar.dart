import 'package:flutter/widgets.dart';

class AppBar extends StatelessWidget {
  const AppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(title: title);
  }
}
