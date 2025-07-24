import 'package:flutter/material.dart';
import 'package:two_gezer/screens/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '2gezer',
      theme: ThemeData(primarySwatch: Colors.orange),
      routerConfig: AppRouter.create(),
    );
  }
}
