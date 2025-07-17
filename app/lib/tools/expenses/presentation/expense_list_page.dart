import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../data/expense_repository.dart';
import '../domain/expense.dart';

class ExpenseListPage extends StatefulWidget {
  final String groupId;
  const ExpenseListPage({super.key, required this.groupId});

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  final _repo = ExpenseRepository();
  late Future<List<Expense>> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => _future = _repo.getExpenses(widget.groupId);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Expenses',
      body: FutureBuilder<List<Expense>>(
        future: _future,
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const LoadingIndicator();
          }
          final ex = snap.data!;
          if (ex.isEmpty) {
            return const Center(child: Text('No expenses yet.'));
          }
          return RefreshIndicator(
            onRefresh: () async => setState(_load),
            child: ListView.separated(
              itemCount: ex.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, i) {
                final e = ex[i];
                return ListTile(
                  title: Text(e.description),
                  subtitle: Text('\$${e.amount.toStringAsFixed(2)}'),
                  onTap: () => context.push(
                    '/groups/${widget.groupId}/expenses/${e.id}',
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          '/groups/${widget.groupId}/expenses/new',
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}