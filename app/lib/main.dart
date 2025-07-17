import 'package:flutter/material.dart';
import 'core/navigation/app_router.dart';
import 'core/auth/auth_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService.instance.restoreSession();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Group Manager (Mock)',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRouter.create(),
    );
  }
}