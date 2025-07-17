import 'package:flutter/material.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../data/expense_repository.dart';
import '../domain/expense.dart';
import '../domain/expense_share.dart';

class ExpenseDetailPage extends StatefulWidget {
  final String groupId;
  final String expenseId;
  const ExpenseDetailPage({
    super.key,
    required this.groupId,
    required this.expenseId,
  });

  @override
  State<ExpenseDetailPage> createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  final _repo = ExpenseRepository();
  late Future<Expense> _expFut;
  late Future<List<ExpenseShare>> _shFut;

  @override
  void initState() {
    super.initState();
    _expFut = _repo
        .getExpenses(widget.groupId)
        .then((list) => list.firstWhere((e) => e.id == widget.expenseId));
    _shFut = _repo.getShares(widget.expenseId);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Expense Details',
      body: FutureBuilder<Expense>(
        future: _expFut,
        builder: (_, snap) {
          if (!snap.hasData) return const LoadingIndicator();
          final e = snap.data!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.description,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('\$${e.amount.toStringAsFixed(2)}'),
                const SizedBox(height: 16),
                const Text('Shares:', style: TextStyle(fontSize: 16)),
                FutureBuilder<List<ExpenseShare>>(
                  future: _shFut,
                  builder: (_, ss) {
                    if (!ss.hasData) return const LoadingIndicator();
                    final shares = ss.data!;
                    return Expanded(
                      child: ListView.separated(
                        itemCount: shares.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (_, i) {
                          final s = shares[i];
                          final name = s.profile?.fullName ?? s.profileId;
                          return ListTile(
                            title: Text(name),
                            trailing: Text(
                              '\$${s.shareAmount.toStringAsFixed(2)}',
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
