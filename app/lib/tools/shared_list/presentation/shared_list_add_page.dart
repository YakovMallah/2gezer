import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/list_repository.dart';
import 'package:two_gezer/core/widgets/app_scaffold.dart';
import 'package:two_gezer/core/widgets/loading_indicator.dart';

class SharedListAddPage extends StatefulWidget {
  final String groupId;
  const SharedListAddPage({super.key, required this.groupId});

  @override
  State<SharedListAddPage> createState() => _SharedListAddPageState();
}

class _SharedListAddPageState extends State<SharedListAddPage> {
  final _title = TextEditingController();
  final _repo = ListRepository();
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    setState(() { _loading = true; _error = null; });
    try {
      await _repo.createList(widget.groupId, _title.text.trim());
      if (mounted) context.pop();
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext c) {
    return AppScaffold(
      title: 'New List',
      body: _loading
        ? const LoadingIndicator()
        : Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            TextField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _submit, child: const Text('Create')),
          ]),
        ),
    );
  }
}