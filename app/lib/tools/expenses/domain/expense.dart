class Expense {
  final String id, groupId, description, paidBy;
  final double amount;
  final DateTime createdAt;
  Expense({
    required this.id,
    required this.groupId,
    required this.description,
    required this.amount,
    required this.paidBy,
    required this.createdAt,
  });
}