import 'package:flutter/foundation.dart';

class TransactionClass {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  TransactionClass({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
