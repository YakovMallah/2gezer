import 'dart:async';
import 'package:two_gezer/core/models/profile.dart';
import '../domain/expense.dart';
import '../domain/expense_share.dart';

class ExpenseRepository {
  static final _expenses = <String, List<Expense>>{};
  static final _shares = <String, List<ExpenseShare>>{};
  static final _members = <Profile>[
    Profile(id: '1', fullName: 'Alice', avatarUrl: '', createdAt: DateTime.now()),
    Profile(id: '2', fullName: 'Bob', avatarUrl: '', createdAt: DateTime.now()),
    Profile(id: '3', fullName: 'Charlie', avatarUrl: '', createdAt: DateTime.now()),
  ];

  Future<List<Expense>> getExpenses(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_expenses[groupId] ?? []);
  }

  Future<List<Profile>> getGroupMembers(String groupId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_members);
  }

  Future<void> createExpense({
    required String groupId,
    required String description,
    required double amount,
    required List<String> participantIds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final eid = DateTime.now().microsecondsSinceEpoch.toString();
    final exp = Expense(
      id: eid,
      groupId: groupId,
      description: description,
      amount: amount,
      paidBy: 'Me',
      createdAt: DateTime.now(),
    );
    _expenses.putIfAbsent(groupId, () => []).add(exp);

    final shareAmt = amount / participantIds.length;
    final shares = participantIds.map((pid) => ExpenseShare(
      expenseId: eid,
      profileId: pid,
      shareAmount: shareAmt,
      profile: _members.firstWhere((m) => m.id == pid),
    )).toList();
    _shares[eid] = shares;
  }

  Future<List<ExpenseShare>> getShares(String expenseId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_shares[expenseId] ?? []);
  }
}