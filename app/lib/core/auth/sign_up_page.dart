import 'package:flutter/material.dart';
import 'auth_service.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/loading_indicator.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _email = TextEditingController();
  final _pw = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    setState(() { _loading = true; _error = null; });
    try {
      await AuthService.instance.signUp(
        email: _email.text.trim(),
        password: _pw.text,
      );
      if (mounted) GoRouter.of(context).go('/groups');
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext c) {
    return AppScaffold(
      title: 'Sign Up',
      body: _loading
        ? const LoadingIndicator()
        : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _pw,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: const Text('Sign Up')),
          ]),
        ),
    );
  }
}