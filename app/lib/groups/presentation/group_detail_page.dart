import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/group_repository.dart';
import '../domain/group.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/loading_indicator.dart';

class GroupDetailPage extends StatefulWidget {
  final String groupId;
  const GroupDetailPage({super.key, required this.groupId});

  @override
  State<GroupDetailPage> createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  final _repo = GroupRepository.instance;
  late Future<Group?> _futureGroup;

  @override
  void initState() {
    super.initState();
    _futureGroup = _repo.getGroupById(widget.groupId);
  }

  @override
  Widget build(BuildContext c) {
    return FutureBuilder<Group?>(
      future: _futureGroup,
      builder: (_, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Scaffold(body: LoadingIndicator());
        }
        final g = snap.data;
        if (g == null) return Scaffold(body: Center(child: Text('Group not found')));
        return AppScaffold(
          title: g.name,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(g.description, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _ToolCard(
                        icon: Icons.list_alt,
                        label: 'Shared Lists',
                        onTap: () => c.go('/groups/${g.id}/lists'),
                      ),
                      _ToolCard(
                        icon: Icons.attach_money,
                        label: 'Expenses',
                        onTap: () => c.go('/groups/${g.id}/expenses'),
                      ),
                      // add more tools here...
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ToolCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ToolCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext c) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(c).primaryColor),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}