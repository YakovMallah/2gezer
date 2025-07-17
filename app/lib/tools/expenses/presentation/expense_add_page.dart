import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/expense_repository.dart';
import 'package:two_gezer/core/models/profile.dart';
import 'package:two_gezer/core/widgets/app_scaffold.dart';
import 'package:two_gezer/core/widgets/loading_indicator.dart';

class ExpenseAddPage extends StatefulWidget {
  final String groupId;
  const ExpenseAddPage({super.key, required this.groupId});
  @override
  State<ExpenseAddPage> createState() => _ExpenseAddPageState();
}

class _ExpenseAddPageState extends State<ExpenseAddPage> {
  final _desc = TextEditingController();
  final _amt  = TextEditingController();
  final _repo = ExpenseRepository();
  List<Profile> _members = [];
  final _sel = <String>{};
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _repo.getGroupMembers(widget.groupId).then((m){
      setState(() => _members = m);
    });
  }

  Future<void> _submit() async {
    final desc = _desc.text.trim();
    final amt = double.tryParse(_amt.text) ?? 0;
    if (desc.isEmpty || amt<=0 || _sel.isEmpty) {
      setState(() => _error = 'Enter all fields');
      return;
    }
    setState(() { _loading=true; _error=null; });
    await _repo.createExpense(
      groupId: widget.groupId,
      description: desc,
      amount: amt,
      participantIds: _sel.toList(),
    );
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext c) {
    return AppScaffold(
      title: 'New Expense',
      body: _loading
        ? const LoadingIndicator()
        : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            if (_error!=null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            TextField(controller: _desc, decoration: const InputDecoration(labelText:'Description')),
            TextField(controller: _amt, decoration: const InputDecoration(labelText:'Amount')),
            const SizedBox(height:12),
            const Text('Participants:'),
            Expanded(
              child: ListView(
                children: _members.map((p){
                  final sel = _sel.contains(p.id);
                  return CheckboxListTile(
                    title: Text(p.fullName),
                    value: sel,
                    onChanged: (b){
                      setState(() {
                        if (b==true) {
                          _sel.add(p.id);
                        } else {
                          _sel.remove(p.id);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(onPressed: _submit, child: const Text('Create')),
          ]),
        ),
    );
  }
}