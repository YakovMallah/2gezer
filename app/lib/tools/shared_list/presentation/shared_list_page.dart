import 'package:flutter/material.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../data/list_repository.dart';
import '../domain/list_item.dart';

class SharedListPage extends StatefulWidget {
  final String groupId;
  final String listId;
  const SharedListPage({super.key, required this.groupId, required this.listId});

  @override
  State<SharedListPage> createState() => _SharedListPageState();
}

class _SharedListPageState extends State<SharedListPage> {
  final _repo = ListRepository();
  final _newCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'List Details',
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ListItem>>(
              future: _repo.getItems(widget.listId),
              builder: (_, snap) {
                if (!snap.hasData) return const LoadingIndicator();
                final items = snap.data!;
                if (items.isEmpty) {
                  return const Center(child: Text('No items yet.'));
                }
                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, i) {
                    final it = items[i];
                    return CheckboxListTile(
                      title: Text(it.content),
                      value: it.isCompleted,
                      onChanged: (b) {
                        _repo.toggleCompleted(it.id, b ?? false);
                        setState(() {});
                      },
                      secondary: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _repo.deleteItem(it.id);
                          setState(() {});
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Add new item…',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _newCtrl.text.trim();
                    if (text.isNotEmpty) {
                      _repo.addItem(widget.listId, text).then((_) {
                        setState(() {});
                        _newCtrl.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
