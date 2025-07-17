class Group {
  final String id;
  final String ownerId;
  final String name;
  final String description;
  final DateTime createdAt;

  Group({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.createdAt,
  });
}