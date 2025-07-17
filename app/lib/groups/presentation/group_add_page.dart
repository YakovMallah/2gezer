import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:two_gezer/groups/data/group_repository.dart';
import 'package:two_gezer/core/widgets/app_scaffold.dart';
import 'package:two_gezer/core/widgets/loading_indicator.dart';

class GroupAddPage extends StatefulWidget {
  const GroupAddPage({super.key});
  @override
  State<GroupAddPage> createState() => _GroupAddPageState();
}

class _GroupAddPageState extends State<GroupAddPage> {
  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _repo = GroupRepository.instance;

  bool _loading = false;
  String? _error;

  Future<void> _create() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _repo.createGroup(
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim(),
      );
      // pop with 'true' to signal success
      mounted ? context.pop(true) : null;
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'New Group',
      body: _loading
          ? const LoadingIndicator()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (_error != null)
                    Text(_error!, style: const TextStyle(color: Colors.red)),
                  TextField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _descCtrl,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _create,
                    child: const Text('Create'),
                  ),
                ],
              ),
            ),
    );
  }
}
