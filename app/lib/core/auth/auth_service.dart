import 'dart:async';
import 'package:flutter/foundation.dart';

/// A very simple in‐memory auth service.
class AuthService extends ChangeNotifier {
  AuthService._();
  static final instance = AuthService._();

  String? _userId;
  final _authState = StreamController<bool>.broadcast();

  /// Call on startup to restore a previous session (here no‐op).
  void restoreSession() {
    // e.g. load from SharedPreferences. For now: no session.
  }

  /// The signed‐in user’s ID, or null.
  String? get currentUserId => _userId;

  /// Emits `true` on sign‐in, `false` on sign‐out.
  Stream<bool> get onAuthStateChange => _authState.stream;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    // In a real app you'd verify credentials
    await Future.delayed(const Duration(milliseconds: 300));
    _userId = email;
    _authState.add(true);
    notifyListeners();
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    // In a real app create user record
    await Future.delayed(const Duration(milliseconds: 300));
    _userId = email;
    _authState.add(true);
    notifyListeners();
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _userId = null;
    _authState.add(false);
    notifyListeners();
  }
}