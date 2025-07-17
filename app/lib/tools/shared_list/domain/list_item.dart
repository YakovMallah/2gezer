class ListItem {
  final String id, listId, content, updatedBy;
  bool isCompleted;
  DateTime updatedAt;
  ListItem({
    required this.id,
    required this.listId,
    required this.content,
    required this.isCompleted,
    required this.updatedBy,
    required this.updatedAt,
  });
}