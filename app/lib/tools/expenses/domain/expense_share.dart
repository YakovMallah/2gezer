import 'package:two_gezer/core/models/profile.dart';

class ExpenseShare {
  final String expenseId, profileId;
  final double shareAmount;
  Profile? profile;
  ExpenseShare({
    required this.expenseId,
    required this.profileId,
    required this.shareAmount,
    this.profile,
  });
}