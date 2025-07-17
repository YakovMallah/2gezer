import 'dart:async';
import '../../core/auth/auth_service.dart';
import '../domain/group.dart';

class GroupRepository {
  // Singleton boilerplate
  GroupRepository._();
  static final GroupRepository instance = GroupRepository._();

  // Shared in‐memory store:
  static final List<Group> _groups = [];

  Future<List<Group>> fetchUserGroups() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final uid = AuthService.instance.currentUserId;
    return _groups.where((g) => g.ownerId == uid).toList();
  }

  Future<Group> createGroup({
    required String name,
    required String description,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final g = Group(
      id: id,
      ownerId: AuthService.instance.currentUserId!,
      name: name,
      description: description,
      createdAt: DateTime.now(),
    );
    _groups.add(g);
    return g;
  }

  Future<Group?> getGroupById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _groups.firstWhere(
      (g) => g.id == id,
      orElse: () => throw Exception("Group with id $id does not exist"),
    );
  }
}
