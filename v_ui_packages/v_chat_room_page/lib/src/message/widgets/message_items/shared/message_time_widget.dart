import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:textless/textless.dart';

class MessageTimeWidget extends StatelessWidget {
  final DateTime dateTime;

  const MessageTimeWidget({
    Key? key,
    required this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DateFormat.jm().format(dateTime.toLocal()).cap,
    );
  }
}