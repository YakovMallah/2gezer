import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/app_scaffold.dart';
import '../data/list_repository.dart';
import '../domain/shared_list.dart';

class SharedListListPage extends StatefulWidget {
  final String groupId;
  const SharedListListPage({super.key, required this.groupId});

  @override
  State<SharedListListPage> createState() => _SharedListListPageState();
}

class _SharedListListPageState extends State<SharedListListPage> {
  final _repo = ListRepository();
  late Future<List<SharedList>> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => _future = _repo.getLists(widget.groupId);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Shared Lists',
      body: FutureBuilder<List<SharedList>>(
        future: _future,
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const LoadingIndicator();
          }
          final lists = snap.data!;
          if (lists.isEmpty) {
            return const Center(child: Text('No lists yet.'));
          }
          return RefreshIndicator(
            onRefresh: () async => setState(_load),
            child: ListView.separated(
              itemCount: lists.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, i) {
                final l = lists[i];
                return ListTile(
                  title: Text(l.title),
                  onTap: () => context.push(
                    '/groups/${widget.groupId}/lists/${l.id}',
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(
          '/groups/${widget.groupId}/lists/new',
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}