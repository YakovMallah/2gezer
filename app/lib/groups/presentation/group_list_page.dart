import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/group_repository.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/loading_indicator.dart';
import '../domain/group.dart';

class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key});
  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  final _repo = GroupRepository.instance;
  late Future<List<Group>> _future;

  @override
  void initState() {
    super.initState();
    _future = _repo.fetchUserGroups();
  }

  void _refresh() => setState(() => _future = _repo.fetchUserGroups());

  @override
  Widget build(BuildContext c) {
    return AppScaffold(
      title: 'Your Groups',
      body: FutureBuilder<List<Group>>(
        future: _future,
        builder: (_, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const LoadingIndicator();
          }
          final groups = snap.data!;
          if (groups.isEmpty) {
            return const Center(child: Text('No groups yet.'));
          }
          return RefreshIndicator(
            onRefresh: () async => _refresh(),
            child: ListView.separated(
              separatorBuilder: (_, __) => const Divider(),
              itemCount: groups.length,
              itemBuilder: (_, i) {
                final g = groups[i];
                return ListTile(
                  title: Text(g.name),
                  subtitle: Text(g.description),
                  onTap: () => c.push('/groups/${g.id}'),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/groups/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
