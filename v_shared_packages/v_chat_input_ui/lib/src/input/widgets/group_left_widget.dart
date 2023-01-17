import 'package:flutter/material.dart';
import 'package:v_chat_utils/v_chat_utils.dart';

class GroupLeftWidget extends StatelessWidget {
  const GroupLeftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            "You don't have access".text.color(Colors.white).black,
          ],
        ),
      ),
    );
  }
}
